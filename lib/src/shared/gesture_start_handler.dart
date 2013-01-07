//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link GestureStartEvent} events.
 */
class GestureStartHandler extends DomEventHandler {

  GestureStartHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when GestureStartEvent is fired.
   *
   * @param event the {@link GestureStartEvent} that was fired
   */
  void onGestureStart(GestureStartEvent event) {
    onDomEventHandler(event);
  }
}
