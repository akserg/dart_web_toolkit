//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link CloseEvent} events.
 * 
 * @param <T> the type being closed
 */
abstract class CloseHandler<T> extends EventHandler {
  
  /**
   * Called when {@link CloseEvent} is fired.
   * 
   * @param event the {@link CloseEvent} that was fired
   */
  void onClose(CloseEvent<T> event);
}
