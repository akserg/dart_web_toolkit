//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link MouseOutEvent} events.
 */
abstract class MouseOutHandler extends EventHandler {

  /**
   * Called when MouseOutEvent is fired.
   *
   * @param event the {@link MouseOutEvent} that was fired
   */
  void onMouseOut(MouseOutEvent event);
}
