//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link LoadHandler} instances.
 */
abstract class HasLoadHandlers extends HasHandlers {
  /**
   * Adds a {@link LoadEvent} handler.
   *
   * @param handler the load handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addLoadHandler(LoadHandler handler);
}
