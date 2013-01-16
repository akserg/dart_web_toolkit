//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface is a public source of
 * {@link SelectionEvent} events.
 *
 * @param <T> the type being selected
 */
abstract class HasSelectionHandlers<T> extends HasHandlers {
  /**
   * Adds a {@link SelectionEvent} handler.
   *
   * @param handler the handler
   * @return the registration for the event
   */
  HandlerRegistration addSelectionHandler(SelectionHandler<T> handler);
}
