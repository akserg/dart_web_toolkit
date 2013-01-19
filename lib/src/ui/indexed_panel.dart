//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implemented by panels that impose an explicit ordering on their children.
 *
 * @see InsertPanel
 */
abstract class IndexedPanel {

  /**
   * Gets the child widget at the specified index.
   *
   * @param index the child widget's index
   * @return the child widget
   */
  Widget getWidget(int index);

  /**
   * Gets the number of child widgets in this panel.
   *
   * @return the number of children
   */
  int getWidgetCount();

  /**
   * Gets the index of the specified child widget.
   *
   * @param child the widget to be found
   * @return the widget's index, or <code>-1</code> if it is not a child of this
   *         panel
   */
  int getWidgetIndex(Widget child);

  /**
   * Removes the widget at the specified index.
   *
   * @param index the index of the widget to be removed
   * @return <code>false</code> if the widget is not present
   */
  bool removeAt(int index);
}

/**
 * Extends this interface with convenience methods to handle {@link IsWidget}.
 */
abstract class IndexedPanelForIsWidget extends IndexedPanel {

  int getWidgetIndexIsWidget(IsWidget child);
}