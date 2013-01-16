//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragStartEvent} events.
 */
class DragStartHandlerAdapter extends EventHandlerAdapter implements DragStartHandler {

  DragStartHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DragStartEvent} is fired.
   *
   * @param event the {@link DragStartEvent} that was fired
   */
  void onDragStart(DragStartEvent event) {
    callback(event);
  }
}
