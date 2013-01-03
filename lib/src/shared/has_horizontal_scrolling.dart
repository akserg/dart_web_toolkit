//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Implemented by widgets that support horizontal scrolling.
 */
abstract class HasHorizontalScrolling {
  
  /**
   * Gets the horizontal scroll position.
   * 
   * @return the horizontal scroll position, in pixels
   */
  int getHorizontalScrollPosition();

  /**
   * Get the maximum position of horizontal scrolling. This is usually the
   * <code>scrollWidth - clientWidth</code>.
   * 
   * @return the maximum horizontal scroll position
   */
  int getMaximumHorizontalScrollPosition();

  /**
   * Get the minimum position of horizontal scrolling.
   * 
   * @return the minimum horizontal scroll position
   */
  int getMinimumHorizontalScrollPosition();

  /**
   * Sets the horizontal scroll position.
   * 
   * @param position the new horizontal scroll position, in pixels
   */
  void setHorizontalScrollPosition(int position);
}
