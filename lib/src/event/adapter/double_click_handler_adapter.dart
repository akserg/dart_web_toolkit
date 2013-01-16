//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DoubleClickEvent} events.
 */
class DoubleClickHandlerAdapter extends EventHandlerAdapter implements DoubleClickHandler {

  DoubleClickHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DoubleClickEvent} is fired.
   *
   * @param event the {@link DoubleClickEvent} that was fired
   */
  void onDoubleClick(DoubleClickEvent event) {
    callback(event);
  }
}
