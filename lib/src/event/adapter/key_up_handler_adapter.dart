//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link KeyUpEvent} events.
 */
class KeyUpHandlerAdapter extends EventHandlerAdapter implements KeyUpHandler {

  KeyUpHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when KeyUpEvent is fired.
   *
   * @param event the {@link KeyUpEvent} that was fired
   */
  void onKeyUp(KeyUpEvent event) {
    callback(event);
  }
}
