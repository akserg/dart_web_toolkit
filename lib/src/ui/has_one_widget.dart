//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implemented by panels that have only one widget.
 *
 * @see SimplePanel
 */
abstract class HasOneWidget extends AcceptsOneWidget {

  /**
   * Gets the panel's child widget.
   *
   * @return the child widget, or <code>null</code> if none is present
   */
  Widget getWidget();

  /**
   * Sets this panel's widget. Any existing child widget will be removed.
   *
   * @param w the panel's new widget, or <code>null</code> to clear the panel
   */
  void setWidget(Widget w);
}
