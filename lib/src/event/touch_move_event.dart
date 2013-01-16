//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native touch move event.
 */
class TouchMoveEvent extends TouchEvent {

  /**
   * The event type.
   */
  static DomEventType<TouchMoveHandler> TYPE = new DomEventType<TouchMoveHandler>(BrowserEvents.TOUCHMOVE, new TouchMoveEvent());

  DomEventType<TouchMoveHandler> getAssociatedType() {
    return TYPE;
  }

  TouchMoveEvent();

  void dispatch(TouchMoveHandler handler) {
    handler.onTouchMove(this);
  }

}
