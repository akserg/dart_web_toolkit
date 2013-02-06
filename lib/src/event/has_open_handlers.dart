//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface is a public source of
 * {@link OpenEvent} events.
 *
 * @param <T> the type being opened
 */
abstract class HasOpenHandlers<T> extends HasHandlers {
  /**
   * Adds an {@link OpenEvent} handler.
   *
   * @param handler the handler
   * @return the registration for the event
   */
  HandlerRegistration addOpenHandler(OpenHandler<T> handler);
}
