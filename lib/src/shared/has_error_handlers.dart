//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link ErrorHandler} instances.
 */
abstract class HasErrorHandlers extends HasHandlers {
  /**
   * Adds an {@link ErrorEvent} handler.
   *
   * @param handler the error handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addErrorHandler(ErrorHandler handler);
}
