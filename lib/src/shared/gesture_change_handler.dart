//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link GestureChangeEvent} events.
 */
abstract class GestureChangeHandler extends EventHandler {

  /**
   * Called when GestureChangeEvent is fired.
   *
   * @param event the {@link GestureChangeEvent} that was fired
   */
  void onGestureChange(GestureChangeEvent event);

}
