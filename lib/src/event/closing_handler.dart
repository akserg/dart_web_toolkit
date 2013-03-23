//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * HHandler for {@link Window.ClosingEvent} events.
 */
abstract class ClosingHandler extends EventHandler {

  /**
   * Fired just before the browser window closes or navigates to a different
   * site. No user-interface may be displayed during shutdown.
   * 
   * @param event the event
   */
  void onWindowClosing(ClosingEvent event);
}
