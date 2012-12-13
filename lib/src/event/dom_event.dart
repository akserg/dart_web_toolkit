//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

abstract class DomEvent extends DwtEvent {

  dart_html.UIEvent nativeEvent;
  dart_html.Element relativeElem;
  
  static Map<String, DomEventType> _registered;
  
  static Map<String, DomEventType> getRegistered() {
    if (_registered == null) {
      _registered = new Map<String, DomEventType>();
    }
    return _registered;
  }

  /**
   * The event type.
   */
  static EventType<DomEventHandler> TYPE = new EventType<DomEventHandler>();

  EventType<DomEventHandler> getAssociatedType() {
    return TYPE;
  }

  DomEvent();

  /**
   * Fires the given native event on the specified handlers.
   * 
   * @param nativeEvent the native event
   * @param handlerSource the source of the handlers to fire
   * @param relativeElem the element relative to which event coordinates will be
   *          measured
   */
  static void fireNativeEvent(dart_html.UIEvent nativeEvent,
      HasHandlers handlerSource, [dart_html.Element relativeElem = null]) {
    assert (nativeEvent != null); // : "nativeEvent must not be null";

    if (_registered != null) {
      DomEventType typeKey = _registered[nativeEvent.type];
      if (typeKey != null) {
        // Store and restore native event just in case we are in recursive
        // loop.
        dart_html.UIEvent currentNative = typeKey.flyweight.nativeEvent;
        dart_html.Element currentRelativeElem = typeKey.flyweight.relativeElem;
        typeKey.flyweight.nativeEvent = nativeEvent;
        typeKey.flyweight.relativeElem = relativeElem;

        handlerSource.fireEvent(typeKey.flyweight);

        typeKey.flyweight.nativeEvent = currentNative;
        typeKey.flyweight.relativeElem = currentRelativeElem;
      }
    }
  }
  
  /**
   * Prevents the wrapped native event's default action.
   */
  void preventDefault() {
    assertLive();
    nativeEvent.preventDefault();
  }
  
  /**
   * Stops the propagation of the underlying native event.
   */
  void stopPropagation() {
    assertLive();
    nativeEvent.stopPropagation();
  }
}

/**
 * Type class used by dom event subclasses. Type is specialized for dom in
 * order to carry information about the native event.
 * 
 * @param <H> handler type
 */
class DomEventType<H> extends EventType<H> {
  
  String eventName;
  DomEvent flyweight;
  
  DomEventType(this.eventName, this.flyweight) {
    DomEvent.getRegistered()[eventName] = this;
  }
  
  
}