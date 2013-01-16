//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface provides registration for
 * {@link MouseOutHandler} instances.
 */
abstract class HasMouseOutHandlers extends HasHandlers {
  /**
   * Adds a {@link MouseOutEvent} handler.
   *
   * @param handler the mouse out handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addMouseOutHandler(MouseOutHandler handler);
}
