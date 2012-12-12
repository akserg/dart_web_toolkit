//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_ui;

/**
 * Interface for creating and manipulating focusable elements
 * that aren't naturally focusable in all browsers, such as DIVs.
 */
abstract class FocusHelper {

  /**
   * Remove focus from [Element].
   */
  void blur(dart_html.Element elem);

  /**
   * Create focusable element.
   */
  dart_html.Element createFocusable();

  /**
   * Set focus on [Element].
   */
  void focus(dart_html.Element elem);

  /**
   * Return [Element] tab index.
   */
  int getTabIndex(dart_html.Element elem);

  /**
   * Set [Element] tab [index].
   */
  void setTabIndex(dart_html.Element elem, int index);

  /**
   * Create instance of [FocusHelper] depends on broswer.
   */
  factory FocusHelper.browserDependent() {
    return new FocusHelperDefault();
  }
}
