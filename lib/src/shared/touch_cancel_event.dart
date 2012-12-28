//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native touch start event.
 */
class TouchCancelEvent extends TouchEvent {
 
  /**
   * The event type.
   */
  static DomEventType<TouchCancelHandler> TYPE = new DomEventType<TouchCancelHandler>(BrowserEvents.TOUCHCANCEL, new TouchCancelEvent());

  DomEventType<TouchCancelHandler> getAssociatedType() {
    return TYPE;
  }

  TouchCancelEvent();

  void dispatch(TouchCancelHandler handler) {
    handler.onTouchCancel(this);
  }
}
