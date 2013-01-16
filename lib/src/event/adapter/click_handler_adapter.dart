//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler for {@link ClickEvent} events.
 */
class ClickHandlerAdapter extends EventHandlerAdapter implements ClickHandler {

  ClickHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a native click event is fired.
   *
   * @param event the {@link ClickEvent} that was fired
   */
  void onClick(ClickEvent event) {
    callback(event);
  }
}
