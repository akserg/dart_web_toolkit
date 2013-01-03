//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Implemented by widgets that support vertical scrolling.
 */
abstract class HasVerticalScrolling {
  /**
   * Get the maximum position of vertical scrolling. This is usually the
   * <code>scrollHeight - clientHeight</code>.
   * 
   * @return the maximum vertical scroll position
   */
  int getMaximumVerticalScrollPosition();

  /**
   * Get the minimum position of vertical scrolling.
   * 
   * @return the minimum vertical scroll position
   */
  int getMinimumVerticalScrollPosition();

  /**
   * Gets the vertical scroll position.
   * 
   * @return the vertical scroll position, in pixels
   */
  int getVerticalScrollPosition();

  /**
   * Sets the vertical scroll position.
   * 
   * @param position the new vertical scroll position, in pixels
   */
  void setVerticalScrollPosition(int position);
}
