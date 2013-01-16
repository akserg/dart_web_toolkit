//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragOverEvent} events.
 */
class DragOverHandlerAdapter extends EventHandlerAdapter implements DragOverHandler {

  DragOverHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DragOverEvent} is fired.
   *
   * @param event the {@link DragOverEvent} that was fired
   */
  void onDragOver(DragOverEvent event) {
    callback(event);
  }
}
