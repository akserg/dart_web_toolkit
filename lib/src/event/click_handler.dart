//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler for {@link ClickEvent} events.
 */
abstract class ClickHandler extends EventHandler {

  /**
   * Called when a native click event is fired.
   *
   * @param event the {@link ClickEvent} that was fired
   */
  void onClick(ClickEvent event);
}
