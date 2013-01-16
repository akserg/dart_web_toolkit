//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link DragEvent} events.
 */
abstract class DragHandler extends EventHandler {

  /**
   * Called when a {@link DragEvent} is fired.
   *
   * @param event the {@link DragEvent} that was fired
   */
  void onDrag(DragEvent event);
}
