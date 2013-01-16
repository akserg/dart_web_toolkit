//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link GestureStartEvent} events.
 */
class GestureStartHandlerAdapter extends EventHandlerAdapter implements GestureStartHandler {

  GestureStartHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when GestureStartEvent is fired.
   *
   * @param event the {@link GestureStartEvent} that was fired
   */
  void onGestureStart(GestureStartEvent event) {
    callback(event);
  }
}
