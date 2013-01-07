//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native key up event.
 */
class KeyUpEvent extends KeyCodeEvent {

  /**
   * The event type.
   */
  static DomEventType<KeyUpHandler> TYPE = new DomEventType<KeyUpHandler>(BrowserEvents.KEYUP, new KeyUpEvent());

  DomEventType<KeyUpHandler> getAssociatedType() {
    return TYPE;
  }

  KeyUpEvent();

  void dispatch(KeyUpHandler handler) {
    handler.onKeyUp(this);
  }
}
