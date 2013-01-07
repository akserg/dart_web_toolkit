//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Base class for Key events. The native keyboard events are somewhat a mess
 * (http://www.quirksmode.org/js/keys.html), we do some trivial normalization
 * here, but do not attempt any complex patching, so user be warned.
 *
 * @param <H> The event handler type
 */
abstract class KeyEvent extends DomEvent {

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
   * Is the <code>alt</code> key down?
   *
   * @return whether the alt key is down
   */
  bool isAltKeyDown() {
    return getKeyboardEvent().altKey;
  }

  /**
   * Does this event have any modifier keys down? Specifically. is the control,
   * meta, shift, or alt key currently pressed?
   *
   * @return whether this event have any modifier key down
   */
  bool isAnyModifierKeyDown() {
    return isControlKeyDown() || isShiftKeyDown() || isMetaKeyDown() || isAltKeyDown();
  }

  /**
   * Is the <code>control</code> key down?
   *
   * @return whether the control key is down
   */
  bool isControlKeyDown() {
    return getKeyboardEvent().ctrlKey;
  }

  /**
   * Is the <code>meta</code> key down?
   *
   * @return whether the meta key is down
   */
  bool isMetaKeyDown() {
    return getKeyboardEvent().metaKey;
  }

  /**
   * Is the <code>shift</code> key down?
   *
   * @return whether the shift key is down
   */
  bool isShiftKeyDown() {
    return getKeyboardEvent().shiftKey;
  }
}
