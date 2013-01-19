//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implemented by [IndexedPanel]s that also allow insertions.
 */
abstract class InsertPanel extends IndexedPanel {
  /**
   * Adds a child widget to this panel.
   *
   * @param w the child widget to be added
   */
  void add(Widget w);

  /**
   * Inserts a child widget before the specified index. If the widget is already
   * a child of this panel, it will be moved to the specified index.
   *
   * @param w the child widget to be inserted
   * @param beforeIndex the index before which it will be inserted
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  void insert(Widget w, int beforeIndex);
}

/**
 * Extends this interface with convenience methods to handle [IsWidget].
 */
abstract class InsertPanelForIsWidget implements InsertPanel, IndexedPanelForIsWidget {

  void addIsWidget(IsWidget w);

  void insertIsWidget(IsWidget w, int beforeIndex);
}