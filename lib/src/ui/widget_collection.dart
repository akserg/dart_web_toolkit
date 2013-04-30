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
class WidgetCollection extends Iterable<Widget> {

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
  RemoveIterator<Widget> get iterator {
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
  
  
  //**********************
  int get length { return _size;}
  bool get isEmpty { return _size == 0;}
  Widget get first { throw new UnsupportedError("");}
  Widget get last { throw new UnsupportedError("");}
  Widget get single { throw new UnsupportedError("");}
  Iterable map(f(Widget element)) { throw new UnsupportedError("");}
  Iterable<Widget> where(bool f(Widget element)) { throw new UnsupportedError("");}
  Iterable expand(Iterable f(Widget element)) { throw new UnsupportedError("");}
  void forEach(void f(Widget element)) { 
    for (int i = 0; i < _size; ++i) {
      f(_array[i]);
    }
  }
  Widget reduce(Widget combine(Widget value, Widget element)) { throw new UnsupportedError("");}
  dynamic fold(var initialValue, dynamic combine(var previousValue, Widget element)) { throw new UnsupportedError("");}
  bool every(bool f(Widget element)) { throw new UnsupportedError("");}
  bool any(bool f(Widget element)) { throw new UnsupportedError("");}
  List<Widget> toList({ bool growable: true }) { throw new UnsupportedError("");}
  Set<Widget> toSet() { throw new UnsupportedError("");}
  Iterable<Widget> take(int n) { throw new UnsupportedError("");}
  Iterable<Widget> takeWhile(bool test(Widget value)) { throw new UnsupportedError("");}
  Iterable<Widget> skip(int n) { throw new UnsupportedError("");}
  Iterable<Widget> skipWhile(bool test(Widget value)) { throw new UnsupportedError("");}
  Widget firstWhere(bool test(Widget value), { Widget orElse() }) { throw new UnsupportedError("");}
  Widget lastWhere(bool test(Widget value), {Widget orElse()}) { throw new UnsupportedError("");}
  Widget singleWhere(bool test(Widget value)) { throw new UnsupportedError("");}
  Widget elementAt(int index) { throw new UnsupportedError("");}
  
}

class WidgetIterator implements RemoveIterator<Widget> {

  WidgetCollection _widgetCollection;

  WidgetIterator(this._widgetCollection);

  int index = -1;

  //***************************
  // Implementation of Iterator
  //***************************

  bool moveNext() {
    return index < (_widgetCollection._size - 1);
  }

  Widget get current => _getCurrent();
  
  Widget _getCurrent() {
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