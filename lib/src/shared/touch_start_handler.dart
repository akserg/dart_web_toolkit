//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link TouchStartEvent} events.
 */
class TouchStartHandler extends DomEventHandler {

  TouchStartHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when TouchStartEvent is fired.
   *
   * @param event the {@link TouchStartEvent} that was fired
   */
  void onTouchStart(TouchStartEvent event) {
    onDomEventHandler(event);
  }
  
}
