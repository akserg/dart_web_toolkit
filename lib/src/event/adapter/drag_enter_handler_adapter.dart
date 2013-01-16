//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragEnterEvent} events.
 */
class DragEnterHandlerAdapter extends EventHandlerAdapter implements DragEnterHandler {

  DragEnterHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DragEnterEvent} is fired.
   *
   * @param event the {@link DragEnterEvent} that was fired
   */
  void onDragEnter(DragEnterEvent event) {
    callback(event);
  }
}
