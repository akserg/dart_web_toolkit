//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

class ClickEvent extends UiEvent {

  /**
   * The event type.
   */
  static EventType<ClickHandler> TYPE = new EventType<ClickHandler>();

  EventType<ClickHandler> getAssociatedType() {
    return TYPE;
  }

  ClickEvent(dart_html.UIEvent uiEvent) : super (uiEvent);
}
