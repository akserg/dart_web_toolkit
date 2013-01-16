//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link LoadEvent} events.
 */
abstract class LoadHandler extends EventHandler {

  /**
   * Called when LoadEvent is fired.
   *
   * @param event the {@link LoadEvent} that was fired
   */
  void onLoad(LoadEvent event);
}
