//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native focus event.
 */
class FocusEvent extends DomEvent {

  /**
   * Event type for focus events. Represents the meta-data associated with this
   * event.
   */
  static final DomEventType<FocusHandler> TYPE = new DomEventType<FocusHandler>(BrowserEvents.FOCUS, new FocusEvent());

  /**
   * Protected constructor, use
   * {@link DomEvent#fireNativeEvent(com.google.gwt.dom.client.NativeEvent, com.google.gwt.event.shared.HasHandlers)}
   * to fire focus events.
   */
  FocusEvent();

  DomEventType<FocusHandler> getAssociatedType() {
    return TYPE;
  }

  void dispatch(FocusHandler handler) {
    handler.onFocus(this);
  }
}
