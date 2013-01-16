//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link MouseOverEvent} events.
 */
abstract class MouseOverHandler extends EventHandler {

  /**
   * Called when MouseOverEvent is fired.
   *
   * @param event the {@link MouseOverEvent} that was fired
   */
  void onMouseOver(MouseOverEvent event);
}
