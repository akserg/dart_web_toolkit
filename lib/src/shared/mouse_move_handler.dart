//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link MouseMoveEvent} events.
 */
class MouseMoveHandler extends DomEventHandler {

  MouseMoveHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when MouseMoveEvent is fired.
   * 
   * @param event the {@link MouseMoveEvent} that was fired
   */
  void onMouseMove(MouseMoveEvent event) {
    onDomEventHandler(event);
  }
  
}
