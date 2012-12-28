//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native drag enter event.
 */
class DragEnterEvent extends DragDropEventBase {
  
  /**
   * The event type.
   */
  static DomEventType<DragEnterHandler> TYPE = new DomEventType<DragEnterHandler>(BrowserEvents.DRAGENTER, new DragEnterEvent());

  DomEventType<DragEnterHandler> getAssociatedType() {
    return TYPE;
  }

  DragEnterEvent();

  void dispatch(DragEnterHandler handler) {
    handler.onDragEnter(this);
  }
}
