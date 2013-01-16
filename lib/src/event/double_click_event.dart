//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native double click event.
 */
class DoubleClickEvent extends MouseEvent {
  
  /**
   * The event type.
   */
  static DomEventType<DoubleClickHandler> TYPE = new DomEventType<DoubleClickHandler>(BrowserEvents.DBLCLICK, new DoubleClickEvent());

  DomEventType<DoubleClickHandler> getAssociatedType() {
    return TYPE;
  }

  DoubleClickEvent();

  void dispatch(DoubleClickHandler handler) {
    handler.onDoubleClick(this);
  }
}
