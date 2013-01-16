//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DropEvent} events.
 */
abstract class DropHandler extends EventHandler {

  /**
   * Called when a {@link DropEvent} is fired.
   *
   * @param event the {@link DropEvent} that was fired
   */
  void onDrop(DropEvent event);

}
