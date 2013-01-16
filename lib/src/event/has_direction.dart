//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * A widget that implements this interface has the ability to override
 * the document directionality for its root element.
 *
 * Widgets that implement this interface should be leaf widgets. More
 * specifically, they should not implement the
 * {@link com.google.gwt.user.client.ui.HasWidgets} interface.
 */
abstract class HasDirection {

  /**
   * Sets the directionality for a widget.
   *
   * @param value <code>RTL</code> if the directionality should be set to right-to-left,
   *                  <code>LTR</code> if the directionality should be set to left-to-right
   *                  <code>DEFAULT</code> if the directionality should not be explicitly set
   */
  void set direction(String value);

  /**
   * Gets the directionality of the widget.
   *
   * @return <code>RTL</code> if the directionality is right-to-left,
   *         <code>LTR</code> if the directionality is left-to-right, or
   *         <code>DEFAULT</code> if the directionality is not explicitly specified
   */
  String get direction;
}