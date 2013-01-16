//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native blur event.
 */
class BlurEvent extends DomEvent {
  /**
   * Event type for focus events. Represents the meta-data associated with this
   * event.
   */
  static final DomEventType<BlurHandler> TYPE = new DomEventType<BlurHandler>(BrowserEvents.BLUR, new BlurEvent());

  /**
   * Protected constructor, use
   * {@link DomEvent#fireNativeEvent(com.google.gwt.dom.client.NativeEvent, com.google.gwt.event.shared.HasHandlers)}
   * to fire focus events.
   */
  BlurEvent();

  DomEventType<BlurHandler> getAssociatedType() {
    return TYPE;
  }

  void dispatch(BlurHandler handler) {
    handler.onBlur(this);
  }
}
