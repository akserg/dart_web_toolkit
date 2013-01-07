//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link BlurHandler} instances.
 */
abstract class HasBlurHandlers extends HasHandlers {
  /**
   * Adds a {@link BlurEvent} handler.
   *
   * @param handler the blur handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addBlurHandler(BlurHandler handler);
}
