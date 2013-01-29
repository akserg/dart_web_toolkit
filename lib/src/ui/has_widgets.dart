//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that implements this interface contains [Widget] and can enumerate
 * them.
 */
abstract class HasWidgets{

  /**
   * Adds a child widget.
   *
   * @param w the widget to be added
   * @throws UnsupportedOperationException if this method is not supported (most
   *           often this means that a specific overload must be called)
   */
  void add(Widget w);

  /**
   * Removes all child widgets.
   */
  void clear();

  /**
   * Removes a child widget.
   *
   * @param w the widget to be removed
   * @return <code>true</code> if the widget was present
   */
  bool remove(Widget w);
  
  /**
   * Returns an [Iterator] that iterates over this [Iterable] object.
   */
  Iterator<Widget> iterator();
}

/**
 * Extends this interface with convenience methods to handle [IsWidget].
 */
abstract class HasWidgetsForIsWidget implements HasWidgets {

  void addIsWidget(IsWidget w);

  bool removeIsWidget(IsWidget w);
}