//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface is a public source of
 * {@link ValueChangeEvent} events.
 * 
 * @param <T> the value about to be changed
 */
abstract class HasValueChangeHandlers<T> extends HasHandlers {
  
  /**
   * Adds a {@link ValueChangeEvent} handler.
   * 
   * @param handler the handler
   * @return the registration for the event
   */
  HandlerRegistration addValueChangeHandler(ValueChangeHandler<T> handler);
}
