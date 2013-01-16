//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link TouchEndEvent} events.
 */
class TouchEndHandlerAdapter extends EventHandlerAdapter implements TouchEndHandler {

  TouchEndHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when TouchEndEvent is fired.
   *
   * @param event the {@link TouchEndEvent} that was fired
   */
  void onTouchEnd(TouchEndEvent event) {
    callback(event);
  }

}
