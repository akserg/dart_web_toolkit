//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link TouchMoveEvent} events.
 */
abstract class TouchMoveHandler extends EventHandler {

  /**
   * Called when TouchMoveEvent is fired.
   *
   * @param event the {@link TouchMoveEvent} that was fired
   */
  void onTouchMove(TouchMoveEvent event);

}
