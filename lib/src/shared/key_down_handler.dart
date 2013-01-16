//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link KeyDownEvent} events.
 */
abstract class KeyDownHandler extends EventHandler {

  /**
   * Called when {@link KeyDownEvent} is fired.
   *
   * @param event the {@link KeyDownEvent} that was fired
   */
  void onKeyDown(KeyDownEvent event);
}
