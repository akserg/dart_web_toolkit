//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

abstract class DomEvent extends DwtEvent implements HasNativeEvent {

  dart_html.Event _nativeEvent;
  dart_html.Element _relativeElem;

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
   * @param _nativeEvent the native event
   * @param handlerSource the source of the handlers to fire
   * @param _relativeElem the element relative to which event coordinates will be
   *          measured
   */
  static void fireNativeEvent(dart_html.Event nativeEvent,
      HasHandlers handlerSource, [dart_html.Element relativeElem = null]) {
    assert (nativeEvent != null); // : "_nativeEvent must not be null";

    if (_registered != null) {
      DomEventType typeKey = _registered[nativeEvent.type];
      if (typeKey != null) {
        // Store and restore native event just in case we are in recursive
        // loop.
        dart_html.Event currentNative = typeKey.flyweight._nativeEvent;
        dart_html.Element currentRelativeElem = typeKey.flyweight._relativeElem;
        typeKey.flyweight._nativeEvent = nativeEvent;
        typeKey.flyweight._relativeElem = relativeElem;

        handlerSource.fireEvent(typeKey.flyweight);

        typeKey.flyweight._nativeEvent = currentNative;
        typeKey.flyweight._relativeElem = currentRelativeElem;
      }
    }
  }

  /**
   * Prevents the wrapped native event's default action.
   */
  void preventDefault() {
    assertLive();
    _nativeEvent.preventDefault();
  }

  /**
   * Stops the propagation of the underlying native event.
   */
  void stopPropagation() {
    assertLive();
    _nativeEvent.stopPropagation();
  }

  dart_html.Event getNativeEvent() {
    assertLive();
    return _nativeEvent;
  }

  /**
   * Gets the element relative to which event coordinates will be measured.
   * If this element is <code>null</code>, event coordinates will be measured
   * relative to the window's client area.
   *
   * @return the event's relative element
   */
  dart_html.Element getRelativeElement() {
    assertLive();
    return _relativeElem;
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