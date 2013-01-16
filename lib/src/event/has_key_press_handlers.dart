//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface provides registration for
 * {@link KeyPressHandler} instances.
 */
abstract class HasKeyPressHandlers extends HasHandlers {
  /**
   * Adds a {@link KeyPressEvent} handler.
   *
   * @param handler the key press handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addKeyPressHandler(KeyPressHandler handler);
}
