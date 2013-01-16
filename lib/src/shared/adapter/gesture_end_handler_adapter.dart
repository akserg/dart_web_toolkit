//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link GestureEndEvent} events.
 */
class GestureEndHandlerAdapter extends EventHandlerAdapter implements GestureEndHandler {

  GestureEndHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when GestureEndEvent is fired.
   *
   * @param event the {@link GestureEndEvent} that was fired
   */
  void onGestureEnd(GestureEndEvent event) {
    callback(event);
  }
}
