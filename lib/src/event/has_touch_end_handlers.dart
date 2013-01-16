//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface provides registration for
 * {@link TouchEndHandler} instances.
 */
abstract class HasTouchEndHandlers extends HasHandlers {
  /**
   * Adds a {@link TouchEndEvent} handler.
   *
   * @param handler the touch end handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addTouchEndHandler(TouchEndHandler handler);
}
