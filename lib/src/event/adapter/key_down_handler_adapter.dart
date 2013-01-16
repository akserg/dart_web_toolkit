//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link KeyDownEvent} events.
 */
class KeyDownHandlerAdapter extends EventHandlerAdapter implements KeyDownHandler {

  KeyDownHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when {@link KeyDownEvent} is fired.
   *
   * @param event the {@link KeyDownEvent} that was fired
   */
  void onKeyDown(KeyDownEvent event) {
    callback(event);
  }
}
