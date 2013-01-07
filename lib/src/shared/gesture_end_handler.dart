//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link GestureEndEvent} events.
 */
class GestureEndHandler extends DomEventHandler {

  GestureEndHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when GestureEndEvent is fired.
   *
   * @param event the {@link GestureEndEvent} that was fired
   */
  void onGestureEnd(GestureEndEvent event) {
    onDomEventHandler(event);
  }
}
