//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implemented by displays that can be given accept an {@link IsWidget}
 * to show.
 */
abstract class AcceptsOneWidget {

  /**
   * Set the only widget of the receiver, replacing the previous
   * widget if there was one.
   *
   * @param w the widget, or <code>null</code> to remove the widget
   *
   * @see SimplePanel
   */
  void setWidgetIsWidget(IsWidget w);
}
