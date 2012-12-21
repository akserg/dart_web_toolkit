//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface provides registration for
 * {@link ChangeHandler} instances.
 */
abstract class HasChangeHandlers extends HasHandlers {

  /**
   * Adds a {@link ChangeEvent} handler.
   *
   * @param handler the change handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addChangeHandler(ChangeHandler handler);
}
