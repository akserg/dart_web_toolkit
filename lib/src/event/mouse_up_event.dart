//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native mouse up event.
 */
class MouseUpEvent extends MouseEvent {

  /**
   * The event type.
   */
  static DomEventType<MouseUpHandler> TYPE = new DomEventType<MouseUpHandler>(BrowserEvents.MOUSEUP, new MouseUpEvent());

  DomEventType<MouseUpHandler> getAssociatedType() {
    return TYPE;
  }

  MouseUpEvent();

  void dispatch(MouseUpHandler handler) {
    handler.onMouseUp(this);
  }

}
