//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragEvent} events.
 */
class DragHandlerAdapter extends EventHandlerAdapter implements DragHandler {

  DragHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DragEvent} is fired.
   *
   * @param event the {@link DragEvent} that was fired
   */
  void onDrag(DragEvent event) {
    callback(event);
  }
}
