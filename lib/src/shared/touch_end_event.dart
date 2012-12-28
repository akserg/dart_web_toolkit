//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native touch end event.
 */
class TouchEndEvent extends TouchEvent {
 
  /**
   * The event type.
   */
  static DomEventType<TouchEndHandler> TYPE = new DomEventType<TouchEndHandler>(BrowserEvents.TOUCHEND, new TouchEndEvent());

  DomEventType<TouchEndHandler> getAssociatedType() {
    return TYPE;
  }

  TouchEndEvent();

  void dispatch(TouchEndHandler handler) {
    handler.onTouchEnd(this);
  }
  
}
