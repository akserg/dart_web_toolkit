//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface provides registration for
 * {@link MouseMoveHandler} instances.
 */
abstract class HasMouseMoveHandlers extends HasHandlers {
  /**
   * Adds a {@link MouseMoveEvent} handler.
   *
   * @param handler the mouse move handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler);
}
