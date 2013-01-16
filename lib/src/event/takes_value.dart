//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Implemented by objects that hold a value.
 *
 * @param <V> value type
 */
abstract class TakesValue<V> {

  /**
   * Sets the value.
   * Fires [ValueChangeEvent] when
   * fireEvents is true and the new value does not equal the existing value.
   *
   * @param value a value object of type V
   * @see #getValue()
   * @param fireEvents fire events if true and value is new
   */
  void setValue(V val, [bool fireEvents = false]);

  /**
   * Returns the current value.
   *
   * @return the value as an object of type V
   * @see #setValue
   */
  V getValue();
}
