//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface provides registration for
 * {@link FocusHandler} instances.
 */
abstract class HasFocusHandlers extends HasHandlers {

  /**
   * Adds a {@link FocusEvent} handler.
   *
   * @param handler the focus handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addFocusHandler(FocusHandler handler);
}
