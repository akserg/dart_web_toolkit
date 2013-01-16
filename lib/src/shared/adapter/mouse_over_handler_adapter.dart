//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link MouseOverEvent} events.
 */
class MouseOverHandlerAdapter extends EventHandlerAdapter implements MouseOverHandler {

  MouseOverHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when MouseOverEvent is fired.
   *
   * @param event the {@link MouseOverEvent} that was fired
   */
  void onMouseOver(MouseOverEvent event) {
    callback(event);
  }
}
