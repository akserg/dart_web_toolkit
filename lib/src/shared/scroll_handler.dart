//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link ScrollEvent} events.
 */
abstract class ScrollHandler extends EventHandler {

  /**
   * Called when ScrollEvent is fired.
   *
   * @param event the {@link ScrollEvent} that was fired
   */
  void onScroll(ScrollEvent event);
}
