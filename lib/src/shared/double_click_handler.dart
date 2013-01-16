//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DoubleClickEvent} events.
 */
abstract class DoubleClickHandler extends EventHandler {

  /**
   * Called when a {@link DoubleClickEvent} is fired.
   *
   * @param event the {@link DoubleClickEvent} that was fired
   */
  void onDoubleClick(DoubleClickEvent event);
}
