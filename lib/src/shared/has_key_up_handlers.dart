//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link KeyUpHandler} instances.
 */
abstract class HasKeyUpHandlers extends HasHandlers {

  /**
   * Adds a {@link KeyUpEvent} handler.
   *
   * @param handler the key up handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addKeyUpHandler(KeyUpHandler handler);
}
