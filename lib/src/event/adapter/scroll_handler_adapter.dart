//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link ScrollEvent} events.
 */
class ScrollHandlerAdapter extends EventHandlerAdapter implements ScrollHandler {

  ScrollHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when ScrollEvent is fired.
   *
   * @param event the {@link ScrollEvent} that was fired
   */
  void onScroll(ScrollEvent event) {
    callback(event);
  }
}
