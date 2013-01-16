//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link TouchCancelEvent} events.
 */
class TouchCancelHandlerAdapter extends EventHandlerAdapter implements TouchCancelHandler {

  TouchCancelHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when TouchCancelEvent is fired.
   *
   * @param event the {@link TouchCancelEvent} that was fired
   */
  void onTouchCancel(TouchCancelEvent event) {
    callback(event);
  }

}
