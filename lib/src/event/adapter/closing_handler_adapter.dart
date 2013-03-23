//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler for {@link CloseEvent} events.
 */
class ClosingHandlerAdapter extends EventHandlerAdapter implements ClosingHandler {

  ClosingHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Fired just before the browser window closes or navigates to a different
   * site. No user-interface may be displayed during shutdown.
   * 
   * @param event the event
   */
  void onWindowClosing(ClosingEvent event) {
    callback(event);
  }
}
