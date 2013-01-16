//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface provides registration for
 * {@link TouchMoveHandler} instances.
 */
abstract class HasTouchMoveHandlers extends HasHandlers {
  /**
   * Adds a {@link TouchMoveEvent} handler.
   *
   * @param handler the touch move handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addTouchMoveHandler(TouchMoveHandler handler);
}
