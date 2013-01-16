//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link ErrorEvent} events.
 */
abstract class ErrorHandler extends EventHandler {

  /**
   * Called when ErrorEvent is fired.
   *
   * @param event the {@link ErrorEvent} that was fired
   */
  void onError(ErrorEvent event);
}
