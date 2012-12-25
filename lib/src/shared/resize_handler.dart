//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler for {@link ResizeEvent} events.
 */
abstract class ResizeHandler extends EventHandler {
  /**
   * Fired when the widget is resized.
   *
   * @param event the event
   */
  void onResize(ResizeEvent event);
}
