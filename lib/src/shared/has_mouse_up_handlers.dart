//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link MouseUpHandler} instances.
 */
abstract class HasMouseUpHandlers extends HasHandlers {
  /**
   * Adds a {@link MouseUpEvent} handler.
   *
   * @param handler the mouse up handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addMouseUpHandler(MouseUpHandler handler);
}
