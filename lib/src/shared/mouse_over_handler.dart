//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link MouseOverEvent} events.
 */
class MouseOverHandler extends DomEventHandler {
  
  MouseOverHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when MouseOverEvent is fired.
   * 
   * @param event the {@link MouseOverEvent} that was fired
   */
  void onMouseOver(MouseOverEvent event) {
    onDomEventHandler(event);
  }
}
