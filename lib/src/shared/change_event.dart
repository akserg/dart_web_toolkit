//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native change event.
 */
class ChangeEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<ChangeHandler> TYPE = new DomEventType<ChangeHandler>(BrowserEvents.CHANGE, new ChangeEvent());

  /**
   * Gets the event type associated with change events.
   *
   * @return the handler type
   */
  DomEventType<ChangeHandler> getAssociatedType() {
    return TYPE;
  }

  ChangeEvent();

  void dispatch(ChangeHandler handler) {
    handler.onChange(this);
  }
}
