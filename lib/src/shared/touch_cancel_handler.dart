//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link TouchCancelEvent} events.
 */
class TouchCancelHandler extends DomEventHandler {

  TouchCancelHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when TouchCancelEvent is fired.
   *
   * @param event the {@link TouchCancelEvent} that was fired
   */
  void onTouchCancel(TouchCancelEvent event) {
    onDomEventHandler(event);
  }
  
}
