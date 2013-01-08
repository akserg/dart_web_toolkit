//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link MouseWheelHandler} instances.
 */
abstract class HasMouseWheelHandlers extends HasHandlers {
  /**
   * Adds a {@link MouseWheelEvent} handler.
   *
   * @param handler the mouse wheel handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler);
}
