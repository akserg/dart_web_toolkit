//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native mouse wheel event.
 */
class MouseWheelEvent extends MouseEvent {

  /**
   * The event type.
   */
  static DomEventType<MouseWheelHandler> TYPE = new DomEventType<MouseWheelHandler>(BrowserEvents.MOUSEWHEEL, new MouseWheelEvent());

  DomEventType<MouseWheelHandler> getAssociatedType() {
    return TYPE;
  }

  MouseWheelEvent();

  void dispatch(MouseWheelHandler handler) {
    handler.onMouseWheel(this);
  }
  
  /**
   * Cast native event to [WheelEvent].
   */
  dart_html.WheelEvent getWheelEvent() {
    if (getNativeEvent() is dart_html.WheelEvent) {
      return getNativeEvent() as dart_html.WheelEvent;
    } 
    throw new Exception("Native event is not subtype of WheelEvent");
  }
  
  /**
   * Get the change in the mouse wheel position along the Y-axis; positive if
   * the mouse wheel is moving north (toward the top of the screen) or negative
   * if the mouse wheel is moving south (toward the bottom of the screen).
   * 
   * Note that delta values are not normalized across browsers or OSes.
   * 
   * @return the delta of the mouse wheel along the y axis
   */
  int getDeltaY() {
    return getWheelEvent().deltaY;
  }

  /**
   * Convenience method that returns <code>true</code> if {@link #getDeltaY()}
   * is a negative value (ie, the velocity is directed toward the top of the
   * screen).
   * 
   * @return true if the velocity is directed toward the top of the screen
   */
  bool isNorth() {
    return getDeltaY() < 0;
  }

  /**
   * Convenience method that returns <code>true</code> if {@link #getDeltaY()}
   * is a positive value (ie, the velocity is directed toward the bottom of the
   * screen).
   * 
   * @return true if the velocity is directed toward the bottom of the screen
   */
  bool isSouth() {
    return getDeltaY() > 0;
  }
}
