//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link OpenEvent} events.
 *
 * @param <T> the type being opened
 */
abstract class OpenHandler<T> extends EventHandler {

  /**
   * Called when {@link OpenEvent} is fired.
   *
   * @param event the {@link OpenEvent} that was fired
   */
  void onOpen(OpenEvent<T> event);
}
