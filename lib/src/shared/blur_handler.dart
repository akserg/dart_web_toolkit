//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link BlurEvent} events.
 */
abstract class BlurHandler extends EventHandler {

  /**
   * Called when BlurEvent is fired.
   *
   * @param event the {@link BlurEvent} that was fired
   */
  void onBlur(BlurEvent event);
}
