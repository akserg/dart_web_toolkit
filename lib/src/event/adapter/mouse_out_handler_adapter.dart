//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link MouseOutEvent} events.
 */
class MouseOutHandlerAdapter extends EventHandlerAdapter implements MouseOutHandler {

  MouseOutHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when MouseOutEvent is fired.
   *
   * @param event the {@link MouseOutEvent} that was fired
   */
  void onMouseOut(MouseOutEvent event) {
    callback(event);
  }
}
