//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that formats its child widgets using the default HTML layout
 * behavior.
 *
 * <p>
 * <img class='gallery' src='doc-files/FlowPanel.png'/>
 * </p>
 */
class FlowPanel extends ComplexPanel implements InsertPanelForIsWidget {

  /**
   * Creates an empty flow panel.
   */
  FlowPanel() {
    setElement(new dart_html.DivElement());
  }

  /**
   * Adds a new child widget to the panel.
   *
   * @param w the widget to be added
   */
  void add(Widget w) {
    addWidget(w, getElement());
  }

  void clear() {
    try {
      doLogicalClear();
    } finally {
      // Remove all existing child nodes.
      for (dart_html.Element element in getElement().children) {
        element.remove();
      }
    }
  }

  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertAt(asWidgetOrNull(w), beforeIndex);
  }

  /**
   * Inserts a widget before the specified index.
   *
   * @param w the widget to be inserted
   * @param beforeIndex the index before which it will be inserted
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  void insertAt(Widget w, int beforeIndex) {
    insert(w, getElement(), beforeIndex, true);
  }
}
