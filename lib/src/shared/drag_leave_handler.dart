//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DragLeaveEvent} events.
 */
abstract class DragLeaveHandler extends EventHandler {

  /**
   * Called when a {@link DragLeaveEvent} is fired.
   *
   * @param event the {@link DragLeaveEvent} that was fired
   */
  void onDragLeave(DragLeaveEvent event);
}
