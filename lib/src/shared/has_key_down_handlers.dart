//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link KeyDownHandler} instances.
 */
abstract class HasKeyDownHandlers extends HasHandlers {
  /**
   * Adds a {@link KeyDownEvent} handler.
   *
   * @param handler the key down handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addKeyDownHandler(KeyDownHandler handler);
}
