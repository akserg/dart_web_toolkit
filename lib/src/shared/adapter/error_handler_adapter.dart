//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link ErrorEvent} events.
 */
class ErrorHandlerAdapter extends EventHandlerAdapter implements ErrorHandler {

  ErrorHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when ErrorEvent is fired.
   *
   * @param event the {@link ErrorEvent} that was fired
   */
  void onError(ErrorEvent event) {
    callback(event);
  }
}
