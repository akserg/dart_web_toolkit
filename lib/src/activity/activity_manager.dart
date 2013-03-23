//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Activity library.
 * Classes used to implement app navigation.
 */
part of dart_web_toolkit_activity;

/**
 * Manages {@link Activity} objects that should be kicked off in response to
 * {@link PlaceChangeEvent} events. Each activity can start itself
 * asynchronously, and provides a widget to be shown when it's ready to run.
 */
class ActivityManager implements PlaceChangeEventHandler, PlaceChangeRequestEventHandler {

  static final Activity NULL_ACTIVITY = new _AbstractActivity();

  final ActivityMapper mapper;

  final EventBus eventBus;

  /*
   * Note that we use the legacy class from com.google.gwt.event.shared, because
   * we can't change the Activity interface.
   */
  ResettableEventBus stopperedEventBus;

  Activity currentActivity = NULL_ACTIVITY;

  AcceptsOneWidget display;

  bool startingNext = false;

  HandlerRegistration handlerRegistration;

  /**
   * Create an ActivityManager. Next call {@link #setDisplay}.
   * 
   * @param mapper finds the {@link Activity} for a given
   *          {@link com.google.gwt.place.shared.Place}
   * @param eventBus source of {@link PlaceChangeEvent} and
   *          {@link PlaceChangeRequestEvent} events.
   */
  ActivityManager(this.mapper, this.eventBus) {
    stopperedEventBus = new ResettableEventBus(eventBus);
  }

  /**
  * Returns an event bus which is in use by the currently running activity.
  * <p>
  * Any handlers attached to the returned event bus will be de-registered when
  * the current activity is stopped.
  *
  * @return the event bus used by the current activity
  */
  EventBus getActiveEventBus() {
    return stopperedEventBus;
  }
 
  /**
   * Deactivate the current activity, find the next one from our ActivityMapper,
   * and start it.
   * <p>
   * The current activity's widget will be hidden immediately, which can cause
   * flicker if the next activity provides its widget asynchronously. That can
   * be minimized by decent caching. Perenially slow activities might mitigate
   * this by providing a widget immediately, with some kind of "loading"
   * treatment.
   */
  void onPlaceChange(PlaceChangeEvent event) {
    Activity nextActivity = getNextActivity(event);

    Exception caughtOnStop = null;
    Exception caughtOnCancel = null;
    Exception caughtOnStart = null;

    if (nextActivity == null) {
      nextActivity = NULL_ACTIVITY;
    }

    if (currentActivity == nextActivity) {
      return;
    }

    if (startingNext) {
      // The place changed again before the new current activity showed its
      // widget
      caughtOnCancel = tryStopOrCancel(false);
      currentActivity = NULL_ACTIVITY;
      startingNext = false;
    } else if (currentActivity != NULL_ACTIVITY) {
      showWidget(null);

      /*
       * Kill off the activity's handlers, so it doesn't have to worry about
       * them accidentally firing as a side effect of its tear down
       */
      stopperedEventBus.removeHandlers();
      caughtOnStop = tryStopOrCancel(true);
    }

    currentActivity = nextActivity;

    if (currentActivity == NULL_ACTIVITY) {
      showWidget(null);
    } else {
      startingNext = true;
      caughtOnStart = tryStart();
    }

    if (caughtOnStart != null || caughtOnCancel != null || caughtOnStop != null) {
      Set<Exception> causes = new dart_collection.LinkedHashSet<Exception>();
      if (caughtOnStop != null) {
        causes.add(caughtOnStop);
      }
      if (caughtOnCancel != null) {
        causes.add(caughtOnCancel);
      }
      if (caughtOnStart != null) {
        causes.add(caughtOnStart);
      }

      throw new UmbrellaException(causes);
    }
  }

  /**
   * Reject the place change if the current activity is not willing to stop.
   * 
   * @see com.google.gwt.place.shared.PlaceChangeRequestEvent.Handler#onPlaceChangeRequest(PlaceChangeRequestEvent)
   */
  void onPlaceChangeRequest(PlaceChangeRequestEvent event) {
    event.setWarning(currentActivity.mayStop());
  }

  /**
   * Sets the display for the receiver, and has the side effect of starting or
   * stopping its monitoring the event bus for place change events.
   * <p>
   * If you are disposing of an ActivityManager, it is important to call
   * setDisplay(null) to get it to deregister from the event bus, so that it can
   * be garbage collected.
   * 
   * @param display an instance of AcceptsOneWidget
   */
  void setDisplay(AcceptsOneWidget display) {
    bool wasActive = (null != this.display);
    bool willBeActive = (null != display);
    this.display = display;
    if (wasActive != willBeActive) {
      updateHandlers(willBeActive);
    }
  }

  Activity getNextActivity(PlaceChangeEvent event) {
    if (display == null) {
      /*
       * Display may have been nulled during PlaceChangeEvent dispatch. Don't
       * bother the mapper, just return a null to ensure we shut down the
       * current activity
       */
      return null;
    }
    return mapper.getActivity(event.getNewPlace());
  }

  void showWidget(IsWidget view) {
    if (display != null) {
      display.setWidgetIsWidget(view);
    }
  }

  Exception tryStart() {
    Exception caughtOnStart = null;
    try {
      /*
       * Wrap the actual display with a per-call instance that protects the
       * display from canceled or stopped activities, and which maintains our
       * startingNext state.
       */
      currentActivity.start(new _ProtectedDisplay(this, currentActivity), stopperedEventBus);
    } on Exception catch (t) {
      caughtOnStart = t;
    }
    return caughtOnStart;
  }

  Exception tryStopOrCancel(bool stop) {
    Exception caughtOnStop = null;
    try {
      if (stop) {
        currentActivity.onStop();
      } else {
        currentActivity.onCancel();
      }
    } on Exception catch (t) {
      caughtOnStop = t;
    } finally {
      /*
       * Kill off the handlers again in case it was naughty and added new ones
       * during onstop or oncancel
       */
      stopperedEventBus.removeHandlers();
    }
    return caughtOnStop;
  }

  void updateHandlers(bool activate) {
    if (activate) {
      final HandlerRegistration placeReg = eventBus.addHandler(PlaceChangeEvent.TYPE, this);
      final HandlerRegistration placeRequestReg =
          eventBus.addHandler(PlaceChangeRequestEvent.TYPE, this);

      this.handlerRegistration = new _ActivityHandlerRegistration(placeReg, placeRequestReg);
    } else {
      if (handlerRegistration != null) {
        handlerRegistration.removeHandler();
        handlerRegistration = null;
      }
    }
  }
}

/**
 * Wraps our real display to prevent an Activity from taking it over if it is
 * not the currentActivity.
 */
class _ProtectedDisplay implements AcceptsOneWidget {
  
  final Activity activity;
  final ActivityManager _manager;

  _ProtectedDisplay(this._manager, this.activity);

  void setWidgetIsWidget(IsWidget view) {
    if (this.activity == _manager.currentActivity) {
      _manager.startingNext = false;
      _manager.showWidget(view);
    }
  }
}

class _AbstractActivity extends AbstractActivity {
  void start(AcceptsOneWidget panel, EventBus eventBus) {
  }
}

class _ActivityHandlerRegistration implements HandlerRegistration {
  
  final HandlerRegistration _placeReg;
  final HandlerRegistration _placeRequestReg;
  
  _ActivityHandlerRegistration(this._placeReg, this._placeRequestReg);
  
  void removeHandler() {
    _placeReg.removeHandler();
    _placeRequestReg.removeHandler();
  }
}