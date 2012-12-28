//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native mouse out event.
 */
class MouseOutEvent extends DomEvent {
  /**
   * The event type.
   */
  static DomEventType<MouseOutHandler> TYPE = new DomEventType<MouseOutHandler>(BrowserEvents.MOUSEOUT, new MouseOutEvent());

  DomEventType<MouseOutHandler> getAssociatedType() {
    return TYPE;
  }

  MouseOutEvent();

  void dispatch(MouseOutHandler handler) {
    handler.onMouseOut(this);
  }
}
