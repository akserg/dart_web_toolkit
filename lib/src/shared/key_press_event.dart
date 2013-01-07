//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native key press event.
 */
class KeyPressEvent extends KeyCodeEvent {

  /**
   * The event type.
   */
  static DomEventType<KeyPressHandler> TYPE = new DomEventType<KeyPressHandler>(BrowserEvents.KEYPRESS, new KeyPressEvent());

  DomEventType<KeyPressHandler> getAssociatedType() {
    return TYPE;
  }

  KeyPressEvent();

  void dispatch(KeyPressHandler handler) {
    handler.onKeyPress(this);
  }

  /**
   * Gets the Unicode char code (code point) for this event.
   *
   * @return the Unicode char code
   */
  int getUnicodeCharCode() {
    return getKeyboardEvent().charCode;
  }
}
