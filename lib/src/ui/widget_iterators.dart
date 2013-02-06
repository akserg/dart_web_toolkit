//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A collection of convenience factories for creating iterators for widgets.
 * This mostly helps developers support {@link HasWidgets} without having to
 * implement their own {@link Iterator}.
 */
class WidgetIterators {

  /**
   * Wraps an array of widgets to be returned during iteration.
   * <code>null</code> is allowed in the array and will be skipped during
   * iteration.
   *
   * @param container the container of the widgets in <code>contained</code>
   * @param contained the array of widgets
   * @return the iterator
   */
  static Iterator<Widget> createWidgetIterator(HasWidgets container, List<Widget> contained) {
    return new _WidgetsIterator(container, contained);
  }
}


class _WidgetsIterator implements Iterator {

  HasWidgets _container;
  List<Widget> _contained;

  int index = -1, last = -1;
  bool widgetsWasCopied = false;
  List<Widget> widgets;

  static List _copyWidgetArray(List widgets) {
    List clone = new List(widgets.length);
    clone.addAll(widgets);
    return clone;
  }

  _WidgetsIterator(this._container, this._contained) {
    widgets = _contained;
    _gotoNextIndex();
  }

  void _gotoNextIndex() {
    ++index;
    while (index < _contained.length) {
      if (_contained[index] != null) {
        return;
      }
      ++index;
    }
  }

  bool _hasNext() {
    return (index < _contained.length);
  }

  Widget _next() {
    if (!_hasNext()) {
      throw new Exception("NoSuchElement");
    }
    last = index;
    Widget w = _contained[index];
    _gotoNextIndex();
    return w;
  }

  void remove() {
    if (last < 0) {
      throw new Exception("IllegalState");
    }

    if (!widgetsWasCopied) {
      widgets = _copyWidgetArray(widgets);
      widgetsWasCopied = true;
    }

    _container.remove(_contained[last]);
    last = -1;
  }

  /**
   * Moves to the next element. Returns true if [current] contains the next
   * element. Returns false, if no element was left.
   *
   * It is safe to invoke [moveNext] even when the iterator is already
   * positioned after the last element. In this case [moveNext] has no effect.
   */
  bool moveNext() {
    bool result = _hasNext();
    if (result) {
      _next();
    }
    return result;
  }

  /**
   * Returns the current element.
   *
   * Return [:null:] if the iterator has not yet been moved to the first
   * element, or if the iterator has been moved after the last element of the
   * [Iterable].
   */
  Widget get current {
    return _contained[index];
  }
}