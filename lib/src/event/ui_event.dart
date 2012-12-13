//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

class UiEvent extends DwtEvent {

  dart_html.UIEvent uiEvent;

  /**
   * The event type.
   */
  static EventType<DomEventHandler> TYPE = new EventType<DomEventHandler>();

  EventType<DomEventHandler> getAssociatedType() {
    return TYPE;
  }

  UiEvent(this.uiEvent);

  /**
   * Implemented by subclasses to to invoke their handlers in a type safe
   * manner. Intended to be called by [EventBus#fireEvent(Event)] or
   * [EventBus#fireEventFromSource(Event, Object)].
   *
   * @param handler handler
   * @see EventBus#dispatchEvent(Event, Object)
   */
  void dispatch(DomEventHandler handler) {
    //handler.onClick(this);
    handler.onDomEventHandler(this);
  }
}
