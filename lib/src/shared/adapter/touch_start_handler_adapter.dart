//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link TouchStartEvent} events.
 */
class TouchStartHandlerAdapter extends EventHandlerAdapter implements TouchStartHandler {

  TouchStartHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when TouchStartEvent is fired.
   *
   * @param event the {@link TouchStartEvent} that was fired
   */
  void onTouchStart(TouchStartEvent event) {
    callback(event);
  }

}
