//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Wraps an EventBus to hold on to any HandlerRegistrations, so that they can
 * easily all be cleared at once.
 */
class ResettableEventBus extends EventBus {
  final EventBus _wrapped;
  final Set<HandlerRegistration> _registrations = new Set<HandlerRegistration>();

  ResettableEventBus(this._wrapped);

  
  HandlerRegistration addHandler(EventType type, EventHandler handler) {
    HandlerRegistration rtn = _wrapped.addHandler(type, handler);
    return _doRegisterHandler(rtn);
  }

  
  HandlerRegistration addHandlerToSource(EventType type, Object source, EventHandler handler) {
    HandlerRegistration rtn = _wrapped.addHandlerToSource(type, source, handler);
    return _doRegisterHandler(rtn);
  }

  
  void fireEvent(Event event) {
    _wrapped.fireEvent(event);
  }

  
  void fireEventFromSource(Event event, Object source) {
    _wrapped.fireEventFromSource(event, source);
  }

  /**
   * Remove all handlers that have been added through this wrapper.
   */
  void removeHandlers() {
    
    while (_registrations.length > 0) {
      HandlerRegistration r = _registrations.first;
      
      /*
       * must remove before we call removeHandler. Might have come from nested
       * ResettableEventBus
       */
      _registrations.remove(r);

      r.removeHandler();
    }
  }

  /**
   *  Visible for testing.
   */
  int getRegistrationSize() {
    return _registrations.length;
  }

  HandlerRegistration _doRegisterHandler(HandlerRegistration registration) {
    _registrations.add(registration);
    return new _ResettableHandlerRegistration(this, registration);
  }

  void _doUnregisterHandler(HandlerRegistration registration) {
    if (_registrations.contains(registration)) {
      registration.removeHandler();
      _registrations.remove(registration);
    }
  }
}

class _ResettableHandlerRegistration implements HandlerRegistration {
  
  ResettableEventBus _eventBus;
  HandlerRegistration _registration;
  
  _ResettableHandlerRegistration(this._eventBus, this._registration);
  
  void removeHandler() {
    _eventBus._doUnregisterHandler(_registration);
  }
}