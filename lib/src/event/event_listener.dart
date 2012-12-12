//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob UI library.
 */
part of dart_mob_event;

/**
 * Receives low-level browser events. The implementer registers for DOM events
 * using [DOM#setEventListener(Element, EventListener)].
 * 
 * Only subclasses of [Widget] should attempt to listen to browser events.
 */
abstract class EventListener {

  /**
   * Fired whenever a browser event is received.
   * 
   * @param event the event received
   */
  void onBrowserEvent(html.Event event);
}
