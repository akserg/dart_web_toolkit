//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native drag end event.
 */
class DragEndEvent extends DragDropEventBase {

  /**
   * The event type.
   */
  static DomEventType<DragEndHandler> TYPE = new DomEventType<DragEndHandler>(BrowserEvents.DRAGEND, new DragEndEvent());

  DomEventType<DragEndHandler> getAssociatedType() {
    return TYPE;
  }

  DragEndEvent();

  void dispatch(DragEndHandler handler) {
    handler.onDragEnd(this);
  }
}
