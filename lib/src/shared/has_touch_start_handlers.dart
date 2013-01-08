//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link TouchStartHandler} instances.
 */
abstract class HasTouchStartHandlers extends HasHandlers {
  /**
   * Adds a {@link TouchStartEvent} handler.
   *
   * @param handler the touch start handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addTouchStartHandler(TouchStartHandler handler);
}
