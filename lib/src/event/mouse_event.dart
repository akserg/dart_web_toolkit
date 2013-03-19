//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Abstract class representing mouse events.
 *
 * @param <H> handler type
 *
 */
abstract class MouseEvent extends DomEvent {

  /**
   * Cast native event to [MouseEvent].
   */
  dart_html.MouseEvent getMouseEvent() {
    if (getNativeEvent() is dart_html.MouseEvent) {
      return getNativeEvent() as dart_html.MouseEvent;
    }
    throw new Exception("Native event is not subtype of MouseEvent");
  }

  /**
   * Is <code>alt</code> key down.
   *
   * @return whether the alt key is down
   */
  bool isAltKeyDown() {
    return getMouseEvent().altKey;
  }

  /**
   * Is <code>control</code> key down.
   *
   * @return whether the control key is down
   */
  bool isControlKeyDown() {
    return getMouseEvent().ctrlKey;
  }

  /**
   * Is <code>meta</code> key down.
   *
   * @return whether the meta key is down
   */
  bool isMetaKeyDown() {
    return getMouseEvent().metaKey;
  }

  /**
   * Is <code>shift</code> key down.
   *
   * @return whether the shift key is down
   */
  bool isShiftKeyDown() {
    return getMouseEvent().shiftKey;
  }

  /**
   * Gets the mouse x-position within the browser window's client area.
   *
   * @return the mouse x-position
   */
  int getClientX() {
    return getMouseEvent().client.x;
  }

  /**
   * Gets the mouse y-position within the browser window's client area.
   *
   * @return the mouse y-position
   */
  int getClientY() {
    return getMouseEvent().client.y;
  }

  /**
   * Gets the button value. Compare it to
   * {@link com.google.gwt.dom.client.NativeEvent#BUTTON_LEFT},
   * {@link com.google.gwt.dom.client.NativeEvent#BUTTON_RIGHT},
   * {@link com.google.gwt.dom.client.NativeEvent#BUTTON_MIDDLE}
   *
   * @return the button value
   */
  int getNativeButton() {
    return getMouseEvent().button;
  }

  /**
   * Gets the mouse x-position relative to a given element.
   *
   * @param target the element whose coordinate system is to be used
   * @return the relative x-position
   */
  int getRelativeX(dart_html.Element target) {
    return getMouseEvent().client.x - Dom.getAbsoluteLeft(target) + target.scrollLeft + target.document.documentElement.scrollLeft;
  }

  /**
   * Gets the mouse y-position relative to a given element.
   *
   * @param target the element whose coordinate system is to be used
   * @return the relative y-position
   */
  int getRelativeY(dart_html.Element target) {
    return getMouseEvent().client.y - Dom.getAbsoluteTop(target) + target.scrollTop + target.document.documentElement.scrollTop;
  }

  /**
   * Gets the mouse x-position on the user's display.
   *
   * @return the mouse x-position
   */
  int getScreenX() {
    return getMouseEvent().screen.x;
  }

  /**
   * Gets the mouse y-position on the user's display.
   *
   * @return the mouse y-position
   */
  int getScreenY() {
    return getMouseEvent().screen.y;
  }

  /**
   * Gets the mouse x-position relative to the event's current target element.
   *
   * @return the relative x-position
   */
  int getX() {
    dart_html.Element relativeElem = getRelativeElement();
    if (relativeElem != null) {
      return getRelativeX(relativeElem);
    }
    return getClientX();
  }

  /**
   * Gets the mouse y-position relative to the event's current target element.
   *
   * @return the relative y-position
   */
  int getY() {
    dart_html.Element relativeElem = getRelativeElement();
    if (relativeElem != null) {
      return getRelativeY(relativeElem);
    }
    return getClientY();
  }
}
