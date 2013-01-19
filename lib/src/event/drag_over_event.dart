//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native drag over event.
 */
class DragOverEvent extends DragDropEventBase {

  /**
   * The event type.
   */
  static DomEventType<DragOverHandler> TYPE = new DomEventType<DragOverHandler>(BrowserEvents.DRAGOVER, new DragOverEvent());

  DomEventType<DragOverHandler> getAssociatedType() {
    return TYPE;
  }

  DragOverEvent();

  void dispatch(DragOverHandler handler) {
    handler.onDragOver(this);
  }
}
