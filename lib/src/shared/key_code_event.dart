//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Key up and key down are both events based upon a given key code.
 *
 * @param <H> handler type
 */
abstract class KeyCodeEvent extends KeyEvent {

  /**
   * Does the key code represent an arrow key?
   *
   * @param keyCode the key code
   * @return if it is an arrow key code
   */
  static bool isArrow(int keyCode) {
    switch (keyCode) {
      case KeyCodes.KEY_DOWN:
      case KeyCodes.KEY_RIGHT:
      case KeyCodes.KEY_UP:
      case KeyCodes.KEY_LEFT:
        return true;
      default:
        return false;
    }
  }

  /**
   * Gets the native key code. These key codes are enumerated in the
   * {@link KeyCodes} class.
   *
   * @return the key code
   */
  int getNativeKeyCode() {
    return getKeyboardEvent().keyCode;
  }

  /**
   * Is this a key down arrow?
   *
   * @return whether this is a down arrow key event
   */
  bool isDownArrow() {
    return getNativeKeyCode() == KeyCodes.KEY_DOWN;
  }

  /**
   * Is this a left arrow?
   *
   * @return whether this is a left arrow key event
   */
  bool isLeftArrow() {
    return getNativeKeyCode() == KeyCodes.KEY_LEFT;
  }

  /**
   * Is this a right arrow?
   *
   * @return whether this is a right arrow key event
   */
  bool isRightArrow() {
    return getNativeKeyCode() == KeyCodes.KEY_RIGHT;
  }

  /**
   * Is this a up arrow?
   *
   * @return whether this is a right arrow key event
   */
  bool isUpArrow() {
    return getNativeKeyCode() == KeyCodes.KEY_UP;
  }

//  String toDebugString() {
//    return super.toDebugString() + "[" + getNativeKeyCode() + "]";
//  }
}

/**
 * Contains the native key codes previously defined in
 * {@link com.google.gwt.user.client.ui.KeyboardListener}. When converting
 * keyboard listener instances, developers can use the following static import
 * to access these constants:
 *
 * <pre> import static com.google.gwt.event.dom.client.KeyCodes.*; </pre>
 *
 * These constants are defined with an int data type in order to be compatible
 * with the constants defined in
 * {@link com.google.gwt.user.client.ui.KeyboardListener}.
 */
class KeyCodes {
  /**
   * Alt key code.
   */
  static const int KEY_ALT = 18;

  /**
   * Backspace key code.
   */
  static const int KEY_BACKSPACE = 8;
  /**
   * Control key code.
   */
  static const int KEY_CTRL = 17;

  /**
   * Delete key code.
   */
  static const int KEY_DELETE = 46;

  /**
   * Down arrow code.
   */
  static const int KEY_DOWN = 40;

  /**
   * End key code.
   */
  static const int KEY_END = 35;

  /**
   * Enter key code.
   */
  static const int KEY_ENTER = 13;
  /**
   * Escape key code.
   */
  static const int KEY_ESCAPE = 27;
  /**
   * Home key code.
   */
  static const int KEY_HOME = 36;
  /**
   * Left key code.
   */
  static const int KEY_LEFT = 37;
  /**
   * Page down key code.
   */
  static const int KEY_PAGEDOWN = 34;
  /**
   * Page up key code.
   */
  static const int KEY_PAGEUP = 33;
  /**
   * Right arrow key code.
   */
  static const int KEY_RIGHT = 39;
  /**
   * Shift key code.
   */
  static const int KEY_SHIFT = 16;

  /**
   * Tab key code.
   */
  static const int KEY_TAB = 9;
  /**
   * Up Arrow key code.
   */
  static const int KEY_UP = 38;
}
