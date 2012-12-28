//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link TouchMoveEvent} events.
 */
class TouchMoveHandler extends DomEventHandler {

  TouchMoveHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when TouchMoveEvent is fired.
   *
   * @param event the {@link TouchMoveEvent} that was fired
   */
  void onTouchMove(TouchMoveEvent event) {
    onDomEventHandler(event);
  }
  
}
