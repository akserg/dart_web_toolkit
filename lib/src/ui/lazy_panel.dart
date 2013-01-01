//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Convenience class to help lazy loading. The bulk of a LazyPanel is not
 * instantiated until {@link #setVisible}(true) or {@link #ensureWidget} is
 * called.
 * <p>
 * <h3>Example</h3> {@example com.google.gwt.examples.LazyPanelExample}
 */
abstract class LazyPanel extends SimplePanel {
  LazyPanel();

  /**
   * Create the widget contained within the {@link LazyPanel}.
   * 
   * @return the lazy widget
   */
  Widget createWidget();

  /**
   * Ensures that the widget has been created by calling {@link #createWidget}
   * if {@link #getWidget} returns <code>null</code>. Typically it is not
   * necessary to call this directly, as it is called as a side effect of a
   * <code>setVisible(true)</code> call.
   */
  void ensureWidget() {
    Widget widget = getWidget();
    if (widget == null) {
      widget = createWidget();
      setWidget(widget);
    }
  }

  /*
   * Sets whether this object is visible. If <code>visible</code> is
   * <code>true</code>, creates the sole child widget if necessary by calling
   * {@link #ensureWidget}.
   * 
   * @param visible <code>true</code> to show the object, <code>false</code> to
   * hide it
   */
  /**
   * Sets whether this object is visible.
   *
   * @param visible <code>true</code> to show the object, <code>false</code> to
   *          hide it
   */
  void set visible(bool visible) {
    if (visible) {
      ensureWidget();
    }
    super.visible = visible;
  }
}
