//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native error event.
 */
class ErrorEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<ErrorHandler> TYPE = new DomEventType<ErrorHandler>(BrowserEvents.LOAD, new ErrorEvent());

  DomEventType<ErrorHandler> getAssociatedType() {
    return TYPE;
  }

  ErrorEvent();

  void dispatch(ErrorHandler handler) {
    handler.onError(this);
  }
}
