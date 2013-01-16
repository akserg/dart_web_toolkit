//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native gesture change event.
 */
class GestureChangeEvent extends DomEvent {
  
  /**
   * The event type.
   */
  static DomEventType<GestureChangeHandler> TYPE = new DomEventType<GestureChangeHandler>(BrowserEvents.GESTURECHANGE, new GestureChangeEvent());

  DomEventType<GestureChangeHandler> getAssociatedType() {
    return TYPE;
  }

  GestureChangeEvent();

  void dispatch(GestureChangeHandler handler) {
    handler.onGestureChange(this);
  }
  
  double getRotation() {
    //return getNativeEvent().rotation;
    throw new Exception("Not implemented yet");
  }

  double getScale() {
    //return getNativeEvent().scale;
    throw new Exception("Not implemented yet");
  }
}
