//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Adapts the HasText interface to the Editor framework.
 */
class HasTextEditor implements LeafValueEditor<String> {
  
  /**
   * Returns a new ValueEditor that that modifies the given {@link HasText} peer
   * instance.
   * 
   * @param peer a {@link HasText} instance
   * @return a HasTextEditor instance
   */
  factory HasTextEditor.of(HasText peer) {
    return new HasTextEditor(peer);
  }

  HasText _peer;

  /**
   * Constructs a new HasTextEditor that that modifies the given {@link HasText}
   * peer instance.
   * 
   * @param peer a {@link HasText} instance
   */
  HasTextEditor(HasText peer) {
    this._peer = peer;
  }

  /**
   * Returns the current value.
   * 
   * @return the value as an object of type V
   * @see #setValue
   */
  String getValue() {
    return _peer.text;
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
  void setValue(String value, [bool fireEvents = false]) {
    _peer.text = value;
  }
}
