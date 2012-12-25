//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Adapts the {@link TakesValue} interface to the Editor framework.
 * 
 * @param <T> the type of value to be edited
 */
class TakesValueEditor<T> implements LeafValueEditor<T> {
 
  final TakesValue<T> _peer;

  /**
   * Returns a new ValueEditor that modifies the given {@link TakesValue} peer
   * instance.
   * 
   * @param peer a {@link TakesValue} instance
   */
  TakesValueEditor(this._peer);
  
  //*****************************
  // Implementation of TakesValue
  //*****************************

  /**
   * Returns the current value.
   * 
   * @return the value as an object of type V
   * @see #setValue
   */
  T getValue() {
    return _peer.getValue();
  }

  /**
   * Sets the value.
   * Fires [ValueChangeEvent] when
   * fireEvents is true and the new value does not equal the existing value.
   *
   * @param value a value object of type V
   * @see #getValue()
   * @param fireEvents fire events if true and value is new
   */
  void setValue(T val, [bool fireEvents = false]) {
    _peer.setValue(val);
  }
}
