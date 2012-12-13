//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

class ClickEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<ClickHandler> TYPE = new DomEventType<ClickHandler>(BrowserEvents.CLICK, new ClickEvent());

  DomEventType<ClickHandler> getAssociatedType() {
    return TYPE;
  }

  ClickEvent();
  
  void dispatch(ClickHandler handler) {
    handler.onClick(this);
  }
}
