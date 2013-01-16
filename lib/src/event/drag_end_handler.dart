//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragEndEvent} events.
 */
abstract class DragEndHandler extends EventHandler {

  /**
   * Called when a {@link DragEndEvent} is fired.
   *
   * @param event the {@link DragEndEvent} that was fired
   */
  void onDragEnd(DragEndEvent event);
}
