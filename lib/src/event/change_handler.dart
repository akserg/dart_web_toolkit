//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler for {@link ChangeEvent} events.
 */
abstract class ChangeHandler extends EventHandler {

  /**
   * Called when a change event is fired.
   *
   * @param event the {@link ChangeEvent} that was fired
   */
  void onChange(ChangeEvent event);
}
