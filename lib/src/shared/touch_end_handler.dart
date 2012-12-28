//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link TouchEndEvent} events.
 */
class TouchEndHandler extends DomEventHandler {

  TouchEndHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when TouchEndEvent is fired.
   *
   * @param event the {@link TouchEndEvent} that was fired
   */
  void onTouchEnd(TouchEndEvent event) {
    onDomEventHandler(event);
  }
  
}
