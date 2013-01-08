//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a native load event.
 */
class LoadEvent extends DomEvent {

  /**
   * The event type.
   */
  static DomEventType<LoadHandler> TYPE = new DomEventType<LoadHandler>(BrowserEvents.LOAD, new LoadEvent());

  DomEventType<LoadHandler> getAssociatedType() {
    return TYPE;
  }

  LoadEvent();

  void dispatch(LoadHandler handler) {
    handler.onLoad(this);
  }
}
