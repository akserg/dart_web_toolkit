//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

class PanelIterator implements Iterator<Widget> {

  Widget returned = null;
  SimplePanel _panel;

  PanelIterator(this._panel);

  /**
   * Returns whether the [Iterator] has elements left.
   */
  bool get hasNext => _panel.widget != null;

  /**
   * Gets the next element in the iteration. Throws a
   * [StateError] if no element is left.
   */
  Widget next() {
    if (_panel.widget == null) {
      throw new StateError("No Such Element found");
    }
    return (returned = _panel.widget);
  }

  remove() {
    if (returned != null) {
      _panel.remove(returned);
    }
  }
}

