//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * An object that implements this interface has a collection of event handlers
 * associated with it.
 */
abstract class HasHandlers {

  /**
   * Fires the given event to the handlers listening to the event's type.
   *
   * Any exceptions thrown by handlers will be bundled into a
   * [UmbrellaException] and then re-thrown after all handlers have
   * completed. An exception thrown by a handler will not prevent other handlers
   * from executing.
   * 
   * @param event the event
   */
  void fireEvent(DwtEvent event);
}
