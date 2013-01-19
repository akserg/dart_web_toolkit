//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native drag leave event.
 */
class DragLeaveEvent extends DragDropEventBase {

  /**
   * The event type.
   */
  static DomEventType<DragLeaveHandler> TYPE = new DomEventType<DragLeaveHandler>(BrowserEvents.DRAGLEAVE, new DragLeaveEvent());

  DomEventType<DragLeaveHandler> getAssociatedType() {
    return TYPE;
  }

  DragLeaveEvent();

  void dispatch(DragLeaveHandler handler) {
    handler.onDragLeave(this);
  }
}
