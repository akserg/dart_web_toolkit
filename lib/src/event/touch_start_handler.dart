//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link TouchStartEvent} events.
 */
abstract class TouchStartHandler extends EventHandler {

  /**
   * Called when TouchStartEvent is fired.
   *
   * @param event the {@link TouchStartEvent} that was fired
   */
  void onTouchStart(TouchStartEvent event);

}
