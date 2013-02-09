//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler for {@link CloseEvent} events.
 */
class CloseHandlerAdapter extends EventHandlerAdapter implements CloseHandler {

  CloseHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a close event is fired.
   *
   * @param event the {@link CloseEvent} that was fired
   */
  void onClose(CloseEvent event) {
    callback(event);
  }
}
