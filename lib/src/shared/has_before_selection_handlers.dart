//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface is a public source of
 * {@link BeforeSelectionEvent} events.
 * 
 * @param <T> the type about to be selected
 */
abstract class HasBeforeSelectionHandlers<T> extends HasHandlers {
  
  /**
   * Adds a {@link BeforeSelectionEvent} handler.
   * 
   * @param handler the handler
   * @return the registration for the event
   */
  HandlerRegistration addBeforeSelectionHandler(BeforeSelectionHandler<T> handler);
}
