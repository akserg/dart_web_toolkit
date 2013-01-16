//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DragOverEvent} events.
 */
abstract class DragOverHandler extends EventHandler {

  /**
   * Called when a {@link DragOverEvent} is fired.
   *
   * @param event the {@link DragOverEvent} that was fired
   */
  void onDragOver(DragOverEvent event);
}
