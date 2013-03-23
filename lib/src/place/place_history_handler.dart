//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * Monitors {@link PlaceChangeEvent}s and
 * {@link com.google.gwt.user.client.History} events and keep them in sync.
 */
class PlaceHistoryHandler {
//  private static final Logger log = Logger.getLogger(PlaceHistoryHandler.class.getName());

  Historian _historian;

  PlaceHistoryMapper _mapper;

  PlaceController _placeController;

  Place _defaultPlace = Place.NOWHERE;

  /**
   * Create a new PlaceHistoryHandler.
   * 
   * @param mapper a {@link PlaceHistoryMapper} instance
   * @param historian a {@link Historian} instance
   */
  PlaceHistoryHandler(this._mapper, [Historian historian = null]) {
    if (historian == null) {
      _historian = new DefaultHistorian();
    } else {
      _historian = historian;
    }
  }

  /**
   * Handle the current history token. Typically called at application start, to
   * ensure bookmark launches work.
   */
  void handleCurrentHistory() {
    _handleHistoryToken(_historian.getToken());
  }

//  /**
//   * Legacy method tied to the old location for {@link EventBus}.
//   * 
//   * @deprecated use {@link #register(PlaceController, EventBus, Place)}
//   */
//  @Deprecated
//  com.google.gwt.event.shared.HandlerRegistration register(PlaceController placeController,
//      com.google.gwt.event.shared.EventBus eventBus, Place defaultPlace) {
//    return new LegacyHandlerWrapper(register(placeController, (EventBus) eventBus, defaultPlace));
//  }

  /**
   * Initialize this place history handler.
   * 
   * @return a registration object to de-register the handler
   */
  HandlerRegistration register(PlaceController placeController, EventBus eventBus,
      Place defaultPlace) {
    this._placeController = placeController;
    this._defaultPlace = defaultPlace;

    
    HandlerRegistration placeReg =
        eventBus.addHandler(PlaceChangeEvent.TYPE, new _PlaceChangeEventHandlerAdapter(this)); 

    HandlerRegistration historyReg =
        _historian.addValueChangeHandler(new ValueChangeHandlerAdapter<String>((ValueChangeEvent<String> event) {
          String token = event.value;
          _handleHistoryToken(token);
        }));

    return new _PlaceHistoryHandlerRegistration(this, placeReg, historyReg);
  }

//  /**
//   * Visible for testing.
//   */
//  Logger log() {
//    return log;
//  }

  void _handleHistoryToken(String token) {

    Place newPlace = null;

    if ("" == token) {
      newPlace = _defaultPlace;
    }

    if (newPlace == null) {
      newPlace = _mapper.getPlace(token);
    }

    if (newPlace == null) {
//      log().warning("Unrecognized history token: " + token);
      newPlace = _defaultPlace;
    }

    _placeController.goTo(newPlace);
  }

  String _tokenForPlace(Place newPlace) {
    if (_defaultPlace == newPlace) {
      return "";
    }

    String token = _mapper.getToken(newPlace);
    if (token != null) {
      return token;
    }

//    log().warning("Place not mapped to a token: " + newPlace);
    return "";
  }
}

/**
 * Optional delegate in charge of History related events. Provides nice
 * isolation for unit testing, and allows pre- or post-processing of tokens.
 * Methods correspond to the like named methods on {@link History}.
 */
abstract class Historian {
  /**
   * Adds a {@link com.google.gwt.event.logical.shared.ValueChangeEvent}
   * handler to be informed of changes to the browser's history stack.
   * 
   * @param valueChangeHandler the handler
   * @return the registration used to remove this value change handler
   */
  HandlerRegistration addValueChangeHandler(ValueChangeHandler<String> valueChangeHandler);

  /**
   * @return the current history token.
   */
  String getToken();

  /**
   * Adds a new browser history entry. Calling this method will cause
   * {@link ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)}
   * to be called as well.
   */
  void newItem(String token, bool issueEvent);
}

/**
 * Default implementation of {@link Historian}, based on {@link History}.
 */
class DefaultHistorian implements Historian {
  
  HandlerRegistration addValueChangeHandler(ValueChangeHandler<String> valueChangeHandler) {
    return History.addValueChangeHandler(valueChangeHandler);
  }

  String getToken() {
    return History.getToken();
  }

  void newItem(String token, bool issueEvent) {
    History.newItem(token, issueEvent);
  }
}

class _PlaceChangeEventHandlerAdapter extends PlaceChangeEventHandler {
 
  PlaceHistoryHandler _handler;
  
  _PlaceChangeEventHandlerAdapter(this._handler);
  
  /**
   * Called when a {@link PlaceChangeEvent} is fired.
   *
   * @param event the {@link PlaceChangeEvent}
   */
  void onPlaceChange(PlaceChangeEvent event) {
    Place newPlace = event.getNewPlace();
    _handler._historian.newItem(_handler._tokenForPlace(newPlace), false);
  }
}

class _PlaceHistoryHandlerRegistration extends EventHandler implements HandlerRegistration {
 
  PlaceHistoryHandler _handler;
  HandlerRegistration _placeReg;
  HandlerRegistration _historyReg;
  
  _PlaceHistoryHandlerRegistration(this._handler, this._placeReg, this._historyReg);
  
  
  /**
   * Deregisters the handler associated with this registration object if the
   * handler is still attached to the event source. If the handler is no longer
   * attached to the event source, this is a no-op.
   */
  void removeHandler() {
    _handler._defaultPlace = Place.NOWHERE;
    _handler._placeController = null;
    _placeReg.removeHandler();
    _historyReg.removeHandler();
  }
}