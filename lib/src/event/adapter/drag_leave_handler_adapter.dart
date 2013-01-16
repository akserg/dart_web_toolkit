//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragLeaveEvent} events.
 */
class DragLeaveHandlerAdapter extends EventHandlerAdapter implements DragLeaveHandler {

  DragLeaveHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DragLeaveEvent} is fired.
   *
   * @param event the {@link DragLeaveEvent} that was fired
   */
  void onDragLeave(DragLeaveEvent event) {
    callback(event);
  }
}
