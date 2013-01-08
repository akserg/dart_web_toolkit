//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link TouchCancelHandler} instances.
 */
abstract class HasTouchCancelHandlers extends HasHandlers {
  /**
   * Adds a {@link TouchCancelEvent} handler.
   *
   * @param handler the touch cancel handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addTouchCancelHandler(TouchCancelHandler handler);
}
