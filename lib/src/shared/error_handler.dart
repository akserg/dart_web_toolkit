//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link ErrorEvent} events.
 */
class ErrorHandler extends DomEventHandler {

  ErrorHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when ErrorEvent is fired.
   *
   * @param event the {@link ErrorEvent} that was fired
   */
  void onError(ErrorEvent event) {
    onDomEventHandler(event);
  }
}
