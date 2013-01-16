//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link MouseMoveEvent} events.
 */
abstract class MouseMoveHandler extends EventHandler {

  /**
   * Called when MouseMoveEvent is fired.
   *
   * @param event the {@link MouseMoveEvent} that was fired
   */
  void onMouseMove(MouseMoveEvent event);

}
