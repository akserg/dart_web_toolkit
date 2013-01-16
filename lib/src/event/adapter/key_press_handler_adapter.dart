//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link KeyPressEvent} events.
 */
class KeyPressHandlerAdapter extends EventHandlerAdapter implements KeyPressHandler {

  KeyPressHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when KeyPressEvent is fired.
   *
   * @param event the {@link KeyPressEvent} that was fired
   */
  void onKeyPress(KeyPressEvent event) {
    callback(event);
  }
}
