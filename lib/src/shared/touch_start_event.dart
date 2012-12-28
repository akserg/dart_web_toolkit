//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native touch start event.
 */
class TouchStartEvent extends TouchEvent {
 
  /**
   * The event type.
   */
  static DomEventType<TouchStartHandler> TYPE = new DomEventType<TouchStartHandler>(BrowserEvents.TOUCHCANCEL, new TouchStartEvent());

  DomEventType<TouchStartHandler> getAssociatedType() {
    return TYPE;
  }

  TouchStartEvent();

  void dispatch(TouchStartHandler handler) {
    handler.onTouchStart(this);
  }
  
}
