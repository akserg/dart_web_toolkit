//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a native mouse over event.
 */
class MouseOverEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<MouseOverHandler> TYPE = new DomEventType<MouseOverHandler>(BrowserEvents.MOUSEOVER, new MouseOverEvent());

  DomEventType<MouseOverHandler> getAssociatedType() {
    return TYPE;
  }

  MouseOverEvent();

  void dispatch(MouseOverHandler handler) {
    handler.onMouseOver(this);
  }
}
