//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link ScrollEvent} events.
 */
class ScrollHandler extends DomEventHandler {
  
  ScrollHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when ScrollEvent is fired.
   * 
   * @param event the {@link ScrollEvent} that was fired
   */
  void onScroll(ScrollEvent event) {
    onDomEventHandler(event);
  }
}
