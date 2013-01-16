//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link MouseWheelEvent} events.
 */
abstract class MouseWheelHandler extends EventHandler {

  /**
   * Called when MouseWheelEvent is fired.
   *
   * @param event the {@link MouseWheelEvent} that was fired
   */
  void onMouseWheel(MouseWheelEvent event);

}
