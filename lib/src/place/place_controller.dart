//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * In charge of the user's location in the app.
 */
class PlaceController {

  //private static final Logger log = Logger.getLogger(PlaceController.class.getName());

  final EventBus _eventBus;

  Delegate _delegate;
  Place _where = Place.NOWHERE;

//  /**
//   * Legacy method tied to the old location for {@link EventBus}.
//   * 
//   * @deprecated use {@link #PlaceController(EventBus)}
//   */
//  @Deprecated
//  PlaceController(com.google.gwt.event.shared.EventBus _eventBus) {
//    this((EventBus) _eventBus);
//  }

//  /**
//   * Legacy method tied to the old location for {@link EventBus}.
//   * 
//   * @deprecated use {@link #PlaceController(EventBus, Delegate)}
//   */
//  @Deprecated
//  PlaceController(com.google.gwt.event.shared.EventBus _eventBus, Delegate _delegate) {
//    this((EventBus) _eventBus, _delegate);
//  }

  /**
   * Create a new PlaceController.
   * 
   * @param _eventBus the {@link EventBus}
   * @param _delegate the {@link Delegate} in charge of Window-related events
   */
  PlaceController(this._eventBus, [Delegate delegate = null]) {
    if (delegate == null) {
      _delegate = new DefaultDelegate();
    } else {
      _delegate = delegate;
    }
    //
    _delegate.addWindowClosingHandler(new ClosingHandlerAdapter((ClosingEvent event) {
      String warning = maybeGoTo(Place.NOWHERE);
      if (warning != null) {
        event.setMessage(warning);
      }
    }));
  }

  /**
   * Returns the current place.
   * 
   * @return a {@link Place} instance
   */
  Place getWhere() {
    return _where;
  }

  /**
   * Request a change to a new place. It is not a given that we'll actually get
   * there. First a {@link PlaceChangeRequestEvent} will be posted to the event
   * bus. If any receivers post a warning message to that event, it will be
   * presented to the user via {@link Delegate#confirm(String)} (which is
   * typically a call to {@link Window#confirm(String)}). If she cancels, the
   * current location will not change. Otherwise, the location changes and a
   * {@link PlaceChangeEvent} is posted announcing the new place.
   * 
   * @param newPlace a {@link Place} instance
   */
  void goTo(Place newPlace) {
//    log().fine("goTo: " + newPlace);

    if (getWhere() == newPlace) {
//      log().fine("Asked to return to the same place: " + newPlace);
      return;
    }

    String warning = maybeGoTo(newPlace);
    if (warning == null || _delegate.confirm(warning)) {
      _where = newPlace;
      _eventBus.fireEvent(new PlaceChangeEvent(newPlace));
    }
  }

//  /**
//   * Visible for testing.
//   */
//  Logger log() {
//    return log;
//  }

  String maybeGoTo(Place newPlace) {
    PlaceChangeRequestEvent willChange = new PlaceChangeRequestEvent(newPlace);
    _eventBus.fireEvent(willChange);
    String warning = willChange.getWarning();
    return warning;
  }
}

/**
 * Optional _delegate in charge of Window-related events. Provides nice
 * isolation for unit testing, and allows customization of confirmation
 * handling.
 */
abstract class Delegate {
  /**
   * Adds a {@link ClosingHandler} to the Delegate.
   * 
   * @param handler a {@link ClosingHandler} instance
   * @return a {@link HandlerRegistration} instance
   */
  HandlerRegistration addWindowClosingHandler(ClosingHandler handler);

  /**
   * Called to confirm a window closing event.
   * 
   * @param message a warning message
   * @return true to allow the window closing
   */
  bool confirm(String message);
}

/**
 * Default implementation of {@link Delegate}, based on {@link Window}.
 */
class DefaultDelegate implements Delegate {
  
  HandlerRegistration addWindowClosingHandler(ClosingHandler handler) {
    return new ClosingHandlerRegistration(handler);
  }

  bool confirm(String message) {
    return dart_html.window.confirm(message);
  }
}

/**
 * Class wrapping window's before closing event in HandlerRegistration manner.
 */
class ClosingHandlerRegistration implements HandlerRegistration {
  
  ClosingHandler _handler;
  dart_async.StreamSubscription listener;
  
  ClosingHandlerRegistration(_handler) {
    listener = dart_html.window.onBeforeUnload.listen(_onData);
  }
  
  void _onData(dart_html.Event evt) {
    ClosingEvent event = new ClosingEvent();
    _handler.onWindowClosing(event);
  }
  
  /**
   * Deregisters the handler associated with this registration object if the
   * handler is still attached to the event source. If the handler is no longer
   * attached to the event source, this is a no-op.
   */
  void removeHandler() {
    listener.cancel();
  }
}