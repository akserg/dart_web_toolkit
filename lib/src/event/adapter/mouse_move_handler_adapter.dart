//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link MouseMoveEvent} events.
 */
class MouseMoveHandlerAdapter extends EventHandlerAdapter implements MouseMoveHandler {

  MouseMoveHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when MouseMoveEvent is fired.
   *
   * @param event the {@link MouseMoveEvent} that was fired
   */
  void onMouseMove(MouseMoveEvent event) {
    callback(event);
  }

}
