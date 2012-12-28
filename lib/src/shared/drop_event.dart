//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native drop event.
 */
class DropEvent extends DragDropEventBase {
  
  /**
   * The event type.
   */
  static DomEventType<DropHandler> TYPE = new DomEventType<DropHandler>(BrowserEvents.DROP, new DropEvent());

  DomEventType<DropHandler> getAssociatedType() {
    return TYPE;
  }

  DropEvent();

  void dispatch(DropHandler handler) {
    handler.onDrop(this);
  }
  
}
