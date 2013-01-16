//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native drag start event.
 */
class DragStartEvent extends DragDropEventBase {
  
  /**
   * The event type.
   */
  static DomEventType<DragStartHandler> TYPE = new DomEventType<DragStartHandler>(BrowserEvents.DRAGSTART, new DragStartEvent());

  DomEventType<DragStartHandler> getAssociatedType() {
    return TYPE;
  }

  DragStartEvent();

  void dispatch(DragStartHandler handler) {
    handler.onDragStart(this);
  }
  
}
