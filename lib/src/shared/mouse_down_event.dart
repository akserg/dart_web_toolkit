//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native mouse down event.
 */
class MouseDownEvent extends MouseEvent {

  /**
   * The event type.
   */
  static DomEventType<MouseDownHandler> TYPE = new DomEventType<MouseDownHandler>(BrowserEvents.MOUSEDOWN, new MouseDownEvent());

  DomEventType<MouseDownHandler> getAssociatedType() {
    return TYPE;
  }

  MouseDownEvent();

  void dispatch(MouseDownHandler handler) {
    handler.onMouseDown(this);
  }
  
}
