//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Adapts the {@link ValueBoxBase} interface to the Editor framework. This
 * adapter uses {@link ValueBoxBase#getValueOrThrow()} to report parse errors to
 * the Editor framework.
 *
 * @param <T> the type of value to be edited
 */
class ValueBoxEditor<T> extends TakesValueEditor<T> implements HasEditorDelegate<T> {
  /**
   * Returns a new TakesValueEditor that adapts a {@link ValueBoxBase}
   * instance.
   *
   * @param valueBox a {@link ValueBoxBase} instance to adapt
   * @return a ValueBoxEditor instance of the same type as the
   *   adapted {@link ValueBoxBase} instance
   */
  factory ValueBoxEditor.of(ValueBoxBase valueBox) {
    return new ValueBoxEditor(valueBox);
  }

  EditorDelegate<T> _delegate;
  ValueBoxBase<T> _peer;
  T _value;

  /**
   * Constructs a new ValueBoxEditor that adapts a {@link ValueBoxBase} peer
   * instance.
   *
   * @param peer a {@link ValueBoxBase} instance of type T
   */
  ValueBoxEditor(ValueBoxBase peer) : super(peer) {
    this._peer = peer;
  }

  /**
   * Returns the {@link EditorDelegate} for this instance.
   *
   * @return an {@link EditorDelegate}, or {@code null}
   * @see #setDelegate(EditorDelegate)
   */
  EditorDelegate<T> getDelegate() {
    return _delegate;
  }

  /**
   * Calls {@link ValueBoxBase#getValueOrThrow()}. If a {@link ParseException}
   * is thrown, it will be available through
   * {@link com.google.gwt.editor.client.EditorError#getUserData()
   * EditorError.getUserData()}.
   *
   * @return a value of type T
   * @see #setValue(Object)
   */
  T getValue() {
    try {
      _value = _peer.getValueOrThrow();
    } on Exception catch (e) {
      // TODO i18n
      getDelegate().recordError("Bad value (${_peer.text})", _peer.text, e);
    }
    return _value;
  }

  /**
   * Sets the {@link EditorDelegate} for this instance. This method is only
   * called by the driver.
   *
   * @param delegate an {@link EditorDelegate}, or {@code null}
   * @see #getDelegate()
   */
  void setDelegate(EditorDelegate<T> delegate) {
    this._delegate = delegate;
  }

  void setValue(T value, [bool fireEvents = false]) {
    _peer.setValue(this._value = value);
  }
}
