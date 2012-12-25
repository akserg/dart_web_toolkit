//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple collection of widgets to be used by
 * {@link com.google.gwt.user.client.ui.Panel panels} and
 * {@link com.google.gwt.user.client.ui.Composite composites}.
 * 
 * <p>
 * The main purpose of this specialized collection is to implement
 * {@link java.util.Iterator#remove()} in a way that delegates removal to its
 * panel. This makes it much easier for the panel to implement an
 * {@link com.google.gwt.user.client.ui.HasWidgets#iterator() iterator} that
 * supports removal of widgets.
 * </p>
 */
class WidgetCollection implements Iterable<Widget> {
  
  static int _INITIAL_SIZE = 4;

  List<Widget> _array;
  HasWidgets _parent;
  int _size = 0;

  /**
   * Constructs a new widget collection.
   * 
   * @param _parent the container whose {@link HasWidgets#remove(Widget)} will be
   *          delegated to by the iterator's {@link Iterator#remove()} method.
   */
  WidgetCollection(this._parent) {
    this._parent = _parent;
    _array = new List<Widget>(_INITIAL_SIZE);
  }

  /**
   * Adds a widget to the end of this collection.
   * 
   * @param w the widget to be added
   */
  void add(Widget w) {
    insert(w, _size);
  }

  /**
   * Determines whether a given widget is contained in this collection.
   * 
   * @param w the widget to be searched for
   * @return <code>true</code> if the widget is present
   */
  bool contains(Widget w) {
    return (indexOf(w) != -1);
  }

  /**
   * Gets the widget at the given index.
   * 
   * @param index the index to be retrieved
   * @return the widget at the specified index
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  Widget get(int index) {
    if ((index < 0) || (index >= _size)) {
      throw new Exception("IndexOutOfBoundsException");
    }

    return _array[index];
  }

  /**
   * Gets the index of the specified index.
   * 
   * @param w the widget to be found
   * @return the index of the specified widget, or <code>-1</code> if it is
   *         not found
   */
  int indexOf(Widget w) {
    for (int i = 0; i < _size; ++i) {
      if (_array[i] == w) {
        return i;
      }
    }

    return -1;
  }

  /**
   * Inserts a widget before the specified index.
   * 
   * @param w the widget to be inserted
   * @param beforeIndex the index before which the widget will be inserted
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  void insert(Widget w, int beforeIndex) {
    if ((beforeIndex < 0) || (beforeIndex > _size)) {
      throw new Exception("IndexOutOfBoundsException");
    }

    // Realloc _array if necessary (doubling).
    if (_size == _array.length) {
      List<Widget> newArray = new List<Widget>(_array.length * 2);
      for (int i = 0; i < _array.length; ++i) {
        newArray[i] = _array[i];
      }
      _array = newArray;
    }

    ++_size;

    // Move all widgets after 'beforeIndex' back a slot.
    for (int i = _size - 1; i > beforeIndex; --i) {
      _array[i] = _array[i - 1];
    }

    _array[beforeIndex] = w;
  }

  /**
   * Gets an iterator on this widget collection. This iterator is guaranteed to
   * implement remove() in terms of its containing {@link HasWidgets}.
   * 
   * @return an iterator
   */
  RemoveIterator<Widget> iterator() {
    return new WidgetIterator(this);
  }

  /**
   * Removes the widget at the specified index.
   * 
   * @param index the index of the widget to be removed
   * @throws IndexOutOfBoundsException if <code>index</code> is out of range
   */
  void remove(int index) {
    if ((index < 0) || (index >= _size)) {
      throw new Exception("IndexOutOfBounds");
    }

    --_size;
    for (int i = index; i < _size; ++i) {
      _array[i] = _array[i + 1];
    }

    _array[_size] = null;
  }

  /**
   * Removes the specified widget.
   * 
   * @param w the widget to be removed
   * @throws NoSuchElementException if the widget is not present
   */
  void removeWidget(Widget w) {
    int index = indexOf(w);
    if (index == -1) {
      throw new Exception("NoSuchElement");
    }

    remove(index);
  }

  /**
   * Gets the number of widgets in this collection.
   * 
   * @return the number of widgets
   */
  int size() {
    return _size;
  }
}

class WidgetIterator implements RemoveIterator<Widget> {

  WidgetCollection _widgetCollection;
  
  WidgetIterator(this._widgetCollection);
  
  int index = -1;
  
  //***************************
  // Implementation of Iterator
  //***************************

  bool get hasNext => index < (_widgetCollection._size - 1);

  Widget next() {
    if (index >= _widgetCollection._size) {
      throw new Exception("NoSuchElement");
    }
    return _widgetCollection._array[++index];
  }

  //*********************************
  // Implementation of RemoveIterator
  //*********************************
  
  void remove() {
    if ((index < 0) || (index >= _widgetCollection._size)) {
      throw new Exception("IllegalState");
    }
    _widgetCollection._parent.remove(_widgetCollection._array[index--]);
  }
}