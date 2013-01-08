//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link MouseDownHandler} instances.
 */
abstract class HasMouseDownHandlers extends HasHandlers {

  /**
   * Adds a {@link MouseDownEvent} handler.
   *
   * @param handler the mouse down handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addMouseDownHandler(MouseDownHandler handler);
}
