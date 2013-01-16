//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link MouseDownEvent} events.
 */
class MouseDownHandlerAdapter extends EventHandlerAdapter implements MouseDownHandler {

  MouseDownHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when MouseDown is fired.
   *
   * @param event the {@link MouseDownEvent} that was fired
   */
  void onMouseDown(MouseDownEvent event) {
    callback(event);
  }

}
