//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Abstract class representing position events such as mouse or touch events.
 *
 * @param <H> handler type
 *
 */
abstract class HumanInputEvent extends DomEvent {

  /**
   * Cast native event to [KeyboardEvent].
   */
  dart_html.KeyboardEvent getKeyboardEvent() {
    if (getNativeEvent() is dart_html.KeyboardEvent) {
      return getNativeEvent() as dart_html.KeyboardEvent;
    }
    throw new Exception("Native event is not subtype of KeyboardEvent");
  }

  /**
   * Is <code>alt</code> key down.
   *
   * @return whether the alt key is down
   */
  bool isAltKeyDown() {
    return getKeyboardEvent().altKey;
  }

  /**
   * Is <code>control</code> key down.
   *
   * @return whether the control key is down
   */
  bool isControlKeyDown() {
    return getKeyboardEvent().ctrlKey;
  }

  /**
   * Is <code>meta</code> key down.
   *
   * @return whether the meta key is down
   */
  bool isMetaKeyDown() {
    return getKeyboardEvent().metaKey;
  }

  /**
   * Is <code>shift</code> key down.
   *
   * @return whether the shift key is down
   */
  bool isShiftKeyDown() {
    return getKeyboardEvent().shiftKey;
  }
}
