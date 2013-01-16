//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native gesture end event.
 */
class GestureEndEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<GestureEndHandler> TYPE = new DomEventType<GestureEndHandler>(BrowserEvents.GESTUREEND, new GestureEndEvent());

  DomEventType<GestureEndHandler> getAssociatedType() {
    return TYPE;
  }

  GestureEndEvent();

  void dispatch(GestureEndHandler handler) {
    handler.onGestureEnd(this);
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
