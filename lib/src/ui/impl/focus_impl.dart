//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Interface for creating and manipulating focusable elements
 * that aren't naturally focusable in all browsers, such as DIVs.
 */
abstract class FocusImpl {

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

  static FocusImpl implPanel;

  /**
   * This instance may not be a {@link FocusImplStandard}, because that special
   * case is only needed for things that aren't naturally focusable on some
   * browsers, such as DIVs. This exact class works for truly focusable widgets
   * on those browsers.
   *
   * The compiler will optimize out the conditional.
   */
  static FocusImpl implWidget;

  /**
   * Return instance of [FocusImpl] depends on broswer.
   */
  static FocusImpl getFocusImplForPanel() {
    if (implPanel == null) {
      implPanel = new FocusImplDefault();
    }
    return implPanel;
  }

  /**
   * Returns the focus implementation class for manipulating focusable elements
   * that are naturally focusable in all browsers, such as text boxes.
   */
  static FocusImpl getFocusImplForWidget() {
    if (implWidget == null) {
      implWidget = new FocusImplDefault(); //(implPanel is FocusImplStandard) ? new FocusImpl() : implPanel;
    }
    return implWidget;
  }
}
