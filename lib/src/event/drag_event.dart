//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native drag event.
 */
class DragEvent extends DragDropEventBase {
  
  /**
   * The event type.
   */
  static DomEventType<DragHandler> TYPE = new DomEventType<DragHandler>(BrowserEvents.DRAG, new DragEvent());

  DomEventType<DragHandler> getAssociatedType() {
    return TYPE;
  }

  DragEvent();

  void dispatch(DragHandler handler) {
    handler.onDrag(this);
  }
}
