//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native mouse move event.
 */
class MouseMoveEvent extends MouseEvent {

  /**
   * The event type.
   */
  static DomEventType<MouseMoveHandler> TYPE = new DomEventType<MouseMoveHandler>(BrowserEvents.MOUSEMOVE, new MouseMoveEvent());

  DomEventType<MouseMoveHandler> getAssociatedType() {
    return TYPE;
  }

  MouseMoveEvent();

  void dispatch(MouseMoveHandler handler) {
    handler.onMouseMove(this);
  }

}
