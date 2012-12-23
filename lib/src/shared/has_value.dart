//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Extends {@link TakesValue} to allow the value to be pulled back out, and to
 * throw {@link com.google.gwt.event.logical.shared.ValueChangeEvent
 * ValueChangeEvent} events.
 * <p>
 * An object that implements this interface should be a user input widget, where
 * the user and programmer can both set and get the object's value. It is
 * intended to provide a unified interface to widgets with "atomic" values, like
 * Strings and Dates.
 *
 * @param <T> the type of value
 */
abstract class HasValue<T> implements TakesValue<T>, HasValueChangeHandlers<T> {
  /**
   * Sets the value.
   * Fires [ValueChangeEvent] when
   * fireEvents is true and the new value does not equal the existing value.
   *
   * @param value a value object of type V
   * @see #getValue()
   * @param fireEvents fire events if true and value is new
   */
  void setValue(T val, [bool fireEvents = false]);

  /**
   * Returns the current value.
   * 
   * @return the value as an object of type V
   * @see #setValue
   */
  T getValue();
}
