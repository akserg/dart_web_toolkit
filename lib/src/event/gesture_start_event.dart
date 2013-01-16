//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native gesture start event.
 */
class GestureStartEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<GestureStartHandler> TYPE = new DomEventType<GestureStartHandler>(BrowserEvents.GESTURESTART, new GestureStartEvent());

  DomEventType<GestureStartHandler> getAssociatedType() {
    return TYPE;
  }

  GestureStartEvent();

  void dispatch(GestureStartHandler handler) {
    handler.onGestureStart(this);
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
