//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link MouseWheelEvent} events.
 */
class MouseWheelHandler extends DomEventHandler {

  MouseWheelHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when MouseWheelEvent is fired.
   * 
   * @param event the {@link MouseWheelEvent} that was fired
   */
  void onMouseWheel(MouseWheelEvent event) {
    onDomEventHandler(event);
  }
  
}
