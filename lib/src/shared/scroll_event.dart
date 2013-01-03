//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native scroll event.
 */
class ScrollEvent extends DomEvent {
  
  /**
   * The event type.
   */
  static DomEventType<ScrollHandler> TYPE = new DomEventType<ScrollHandler>(BrowserEvents.SCROLL, new ScrollEvent());

  DomEventType<ScrollHandler> getAssociatedType() {
    return TYPE;
  }

  ScrollEvent();

  void dispatch(ScrollHandler handler) {
    handler.onScroll(this);
  }
}
