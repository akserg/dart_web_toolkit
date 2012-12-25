//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface is a public source of
 * {@link ResizeEvent} events.
 */
abstract class HasResizeHandlers extends HasHandlers {

  /**
   * Adds a {@link ResizeEvent} handler.
   *
   * @param handler the handler
   * @return the handler registration
   */
  HandlerRegistration addResizeHandler(ResizeHandler handler);
}
