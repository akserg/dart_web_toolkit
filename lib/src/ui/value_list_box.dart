//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implementation of {@link HasConstrainedValue} based on a
 * {@link com.google.gwt.dom.client.SelectElement}.
 * <p>
 * A {@link Renderer Renderer<T>} is used to get user-presentable strings to
 * display in the select element.
 * 
 * @param <T> the value type
 */
class ValueListBox<T> extends Composite implements HasConstrainedValue<T>, IsEditor<TakesValueEditor<T>> {

  final List<T> _values = new List<T>();
  final Map<Object, int> _valueKeyToIndex = new Map<Object, int>();
  final Renderer<T> _renderer;
  ProvidesKey<T> _keyProvider;

  TakesValueEditor<T> _editor;
  T _value;

  ValueListBox(this._renderer, [ProvidesKey<T> keyProvider = null]) {
    if (keyProvider == null) {
      this._keyProvider = new SimpleKeyProvider<T>();
    } else {
      this._keyProvider = keyProvider;
    }
    initWidget(new ListBox());

    _getListBox().addChangeHandler(new ChangeHandlerAdapter((ChangeEvent evt){
        int selectedIndex = _getListBox().getSelectedIndex();

        if (selectedIndex < 0) {
          return; // Not sure why this happens during addValue
        }
        T newValue = _values[selectedIndex];
        setValue(newValue, true);
    }));
  }

  HandlerRegistration addValueChangeHandler(ValueChangeHandler<T> handler) {
    return addHandler(handler, ValueChangeEvent.TYPE);
  }

  /**
   * Returns a {@link TakesValueEditor} backed by the ValueListBox.
   */
  TakesValueEditor<T> asEditor() {
    if (_editor == null) {
      _editor = new TakesValueEditor.of(this);
    }
    return _editor;
  }

  T getValue() {
    return _value;
  }

  void setAcceptableValues(Iterable<T> newValues) {
    _values.clear();
    _valueKeyToIndex.clear();
    ListBox listBox = _getListBox();
    listBox.clear();

    for (T nextNewValue in newValues) {
      _addValue(nextNewValue);
    }

    _updateListBox();
  }

  /**
   * Set the value and display it in the select element. Add the value to the
   * acceptable set if it is not already there.
   */
  void setValue(T value, [bool fireEvents = false]) {
    if (value == this._value || (this._value != null && this._value == value)) {
      return;
    }

    T before = this._value;
    this._value = value;
    _updateListBox();

    if (fireEvents) {
      ValueChangeEvent.fireIfNotEqual(this, before, value);
    }
  }

  void _addValue(T value) {
    Object key = _keyProvider.getKey(value);
    if (_valueKeyToIndex.containsKey(key)) {
      throw new Exception("Duplicate value: $value");
    }

    _valueKeyToIndex[key] = _values.length;
    _values.add(value);
    _getListBox().addItem(_renderer.render(value));
    assert (_values.length == _getListBox().getItemCount());
  }

  ListBox _getListBox() {
    return getWidget() as ListBox;
  }

  void _updateListBox() {
    if (_value != null) {
      Object key = _keyProvider.getKey(_value);
      int index = _valueKeyToIndex[key];
      if (index == null) {
        _addValue(_value);
      }
  
      index = _valueKeyToIndex[key];
      _getListBox().setSelectedIndex(index);
    } else {
      _getListBox().setSelectedIndex(-1);
    }
  }
}
