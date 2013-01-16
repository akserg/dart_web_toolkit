//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native key down event.
 */
class KeyDownEvent extends KeyCodeEvent {

  /**
   * The event type.
   */
  static DomEventType<KeyDownHandler> TYPE = new DomEventType<KeyDownHandler>(BrowserEvents.KEYDOWN, new KeyDownEvent());

  DomEventType<KeyDownHandler> getAssociatedType() {
    return TYPE;
  }

  KeyDownEvent();

  void dispatch(KeyDownHandler handler) {
    handler.onKeyDown(this);
  }
}
