//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that displays all of its child widgets in a 'deck', where only one
 * can be visible at a time. It is used by
 * {@link com.google.gwt.user.client.ui.TabLayoutPanel}.
 *
 * <p>
 * This widget will <em>only</em> work in standards mode, which requires that
 * the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 *
 * <p>
 * Once a widget has been added to a DeckPanel, its visibility, width, and
 * height attributes will be manipulated. When the widget is removed from the
 * DeckPanel, it will be visible, and its width and height attributes will be
 * cleared.
 * </p>
 */
class DeckLayoutPanel extends ComplexPanel implements AnimatedLayout, RequiresResize, ProvidesResize, InsertPanelForIsWidget, AcceptsOneWidget {

  int _animationDuration = 0;
  bool _isAnimationVertical = false;
  Widget _hidingWidget;
  Widget _lastVisibleWidget;
  Layout _layout;
  LayoutCommand _layoutCmd;
  Widget _visibleWidget;

  /**
   * Creates an empty deck panel.
   */
  DeckLayoutPanel() : super() {
    setElement(new dart_html.DivElement());
    _layout = new Layout(getElement());
    _layoutCmd = new _DeckAnimateCommand(this, _layout);
  }

  void add(Widget w) {
    insertAt(w, getWidgetCount());
  }

  //*********************************
  // Implementation of AnimatedLayout
  //*********************************

  /**
   * Layout children, animating over the specified period of time.
   *
   * <p>
   * This method provides a callback that will be informed of animation updates.
   * This can be used to create more complex animation effects.
   * </p>
   *
   * @param duration the animation duration, in milliseconds
   * @param callback the animation callback
   */
  void animate(int duration, [LayoutAnimationCallback callback = null]) {
    _layoutCmd.schedule(duration, callback);
  }

  /**
   * Layout children immediately.
   *
   * <p>
   * This is not normally necessary, unless you want to update child widgets'
   * positions explicitly to create a starting point for a subsequent call to
   * {@link #animate(int)}.
   * </p>
   *
   * @see #animate(int)
   * @see #animate(int, Layout.AnimationCallback)
   */
  void forceLayout() {
    _layoutCmd.cancel();
    doBeforeLayout();
    _layout.layout();
    doAfterLayout();
    onResize();
  }

  /**
   * Get the duration of the animated transition between tabs.
   *
   * @return the duration in milliseconds
   */
  int getAnimationDuration() {
    return _animationDuration;
  }

  /**
   * Gets the currently-visible widget.
   *
   * @return the visible widget, or null if not visible
   */
  Widget getVisibleWidget() {
    return _visibleWidget;
  }

  /**
   * Gets the index of the currently-visible widget.
   *
   * @return the visible widget's index
   */
  int getVisibleWidgetIndex() {
    return getWidgetIndex(_visibleWidget);
  }

  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertAt(asWidgetOrNull(w), beforeIndex);
  }

  void insertAt(Widget widget, int beforeIndex) {
    Widget before = (beforeIndex < getWidgetCount()) ? getWidgetAt(beforeIndex)
        : null;
    insertBefore(widget, before);
  }

  /**
   * Insert a widget before the specified widget. If the widget is already a
   * child of this panel, this method behaves as though {@link #remove(Widget)}
   * had already been called.
   *
   * @param widget the widget to be added
   * @param before the widget before which to insert the new child, or
   *          <code>null</code> to append
   */
  void insertBefore(Widget widget, Widget before) {
    assertIsChild(before);

    // Detach new child.
    widget.removeFromParent();

    // Logical attach.
    WidgetCollection children = getChildren();
    if (before == null) {
      children.add(widget);
    } else {
      int index = children.indexOf(before);
      children.insert(widget, index);
    }

    // Physical attach.
    Layer layer = _layout.attachChild(widget.getElement(), before: before == null ? null : before.getElement(), userObject:widget);
    setWidgetVisible(widget, layer, false);
    widget.setLayoutData(layer);

    // Adopt.
    adopt(widget);

    // Update the layout.
    animate(0);
  }

  /**
   * Check whether or not transitions slide in vertically or horizontally.
   * Defaults to horizontally.
   *
   * @return true for vertical transitions, false for horizontal
   */
  bool isAnimationVertical() {
    return _isAnimationVertical;
  }

  /**
   * Set whether or not transitions slide in vertically or horizontally.
   *
   * @param isVertical true for vertical transitions, false for horizontal
   */
  void setAnimationVertical(bool isVertical) {
    this._isAnimationVertical = isVertical;
  }

  //*********************************
  // Implementation of RequiresResize
  //*********************************

  void onResize() {
    for (Widget child in getChildren()) {
      if (child is RequiresResize) {
        (child as RequiresResize).onResize();
      }
    }
  }

  bool remove(Widget w) {
    bool removed = super.remove(w);
    if (removed) {
      Layer layer = w.getLayoutData() as Layer;
      _layout.removeChild(layer);
      w.setLayoutData(null);

      if (_visibleWidget == w) {
        _visibleWidget = null;
      }
      if (_hidingWidget == w) {
        _hidingWidget = null;
      }
      if (_lastVisibleWidget == w) {
        _lastVisibleWidget = null;
      }
    }
    return removed;
  }

  /**
   * Set the duration of the animated transition between tabs.
   *
   * @param duration the duration in milliseconds.
   */
  void setAnimationDuration(int duration) {
    this._animationDuration = duration;
  }

  /**
    * Show the specified widget. If the widget is not a child of this panel, it
    * is added to the end of the panel. If the specified widget is null, the
    * currently-visible widget will be hidden.
    *
    * @param w the widget to show, and add if not a child
    */
  void setWidgetIsWidget(IsWidget w) {
    // Hide the currently visible widget.
    if (w == null) {
      showWidget(null);
      return;
    }

    // Add the widget if it is not already a child.
    if (w.asWidget().getParent() != this) {
      add(w);
    }

    // Show the widget.
    showWidget(w.asWidget());
  }

  /**
   * Shows the widget at the specified index. This causes the currently- visible
   * widget to be hidden.
   *
   * @param index the index of the widget to be shown
   */
  void showWidgetAt(int index) {
    checkIndexBoundsForAccess(index);
    showWidget(getWidgetAt(index));
  }

  /**
   * Shows the widget at the specified index. This causes the currently- visible
   * widget to be hidden.
   *
   * @param widget the widget to be shown
   */
  void showWidget(Widget widget) {
    if (widget == _visibleWidget) {
      return;
    }

    assertIsChild(widget);
    _visibleWidget = widget;
    animate((widget == null) ? 0 : _animationDuration);
  }

  void onAttach() {
    super.onAttach();
    _layout.onAttach();
  }

  void onDetach() {
    super.onDetach();
    _layout.onDetach();
  }

  /**
   * Assert that the specified widget is null or a child of this widget.
   *
   * @param widget the widget to check
   */
  void assertIsChild(Widget widget) {
    assert ((widget == null) || (widget.getParent() == this)); // : "The specified widget is not a child of this panel";
  }

  /**
   * Hide the widget that just slid out of view.
   */
  void doAfterLayout() {
    if (_hidingWidget != null) {
      Layer layer = _hidingWidget.getLayoutData() as Layer;
      setWidgetVisible(_hidingWidget, layer, false);
      _layout.layout();
      _hidingWidget = null;
    }
  }

  /**
   * Initialize the location of the widget that will slide into view.
   */
  void doBeforeLayout() {
    Layer oldLayer = (_lastVisibleWidget == null) ? null : _lastVisibleWidget.getLayoutData() as Layer;
    Layer newLayer = (_visibleWidget == null) ? null : _visibleWidget.getLayoutData() as Layer;

    // Calculate the direction that the new widget will enter.
    int oldIndex = getWidgetIndex(_lastVisibleWidget);
    int newIndex = getWidgetIndex(_visibleWidget);
    double direction = (oldIndex < newIndex) ? 100.0 : -100.0;
    double vDirection = _isAnimationVertical ? direction : 0.0;
    double hDirection = _isAnimationVertical ? 0.0
        : LocaleInfo.getCurrentLocale().isRTL() ? -direction : direction;

    /*
     * Position the old widget in the center of the panel, and the new widget
     * off to one side. If the old widget is the same as the new widget, then
     * skip this step.
     */
    _hidingWidget = null;
    if (_visibleWidget != _lastVisibleWidget) {
      // Position the layers in their start positions.
      if (oldLayer != null) {
        // The old layer starts centered in the panel.
        oldLayer.setTopHeight(0.0, Unit.PCT, 100.0, Unit.PCT);
        oldLayer.setLeftWidth(0.0, Unit.PCT, 100.0, Unit.PCT);
        setWidgetVisible(_lastVisibleWidget, oldLayer, true);
      }
      if (newLayer != null) {
        // The new layer starts off to one side.
        newLayer.setTopHeight(vDirection, Unit.PCT, 100.0, Unit.PCT);
        newLayer.setLeftWidth(hDirection, Unit.PCT, 100.0, Unit.PCT);
        setWidgetVisible(_visibleWidget, newLayer, true);
      }
      _layout.layout();
      _hidingWidget = _lastVisibleWidget;
    }

    // Set the end positions of the layers.
    if (oldLayer != null) {
      // The old layer ends off to one side.
      oldLayer.setTopHeight(-vDirection, Unit.PCT, 100.0, Unit.PCT);
      oldLayer.setLeftWidth(-hDirection, Unit.PCT, 100.0, Unit.PCT);
      setWidgetVisible(_lastVisibleWidget, oldLayer, true);
    }
    if (newLayer != null) {
      // The new layer ends centered in the panel.
      newLayer.setTopHeight(0.0, Unit.PCT, 100.0, Unit.PCT);
      newLayer.setLeftWidth(0.0, Unit.PCT, 100.0, Unit.PCT);
      /*
       * The call to layout() above could have canceled an existing layout
       * animation, which could cause this widget to be hidden if the user
       * toggles between two visible widgets. We set it visible again to ensure
       * that it ends up visible.
       */
      setWidgetVisible(_visibleWidget, newLayer, true);
    }

    _lastVisibleWidget = _visibleWidget;
  }

  void setWidgetVisible(Widget w, Layer layer, bool visible) {
    layer.setVisible(visible);

    /*
     * Set the visibility of the widget. This is used by lazy panel to
     * initialize the widget.
     */
    w.visible = visible;
  }
}

/**
 * {@link LayoutCommand} used by this widget.
 */
class _DeckAnimateCommand extends LayoutCommand {

  DeckLayoutPanel _panel;

  _DeckAnimateCommand(this._panel, Layout layout) : super(layout);

  void schedule(int duration, LayoutAnimationCallback callback) {
    super.schedule(duration, new _LayoutCommandAnimationCallback(_panel, callback));
  }

  void doBeforeLayout() {
    _panel.doBeforeLayout();
  }
}

class _LayoutCommandAnimationCallback implements LayoutAnimationCallback {

  DeckLayoutPanel _panel;
  LayoutAnimationCallback _callback;

  _LayoutCommandAnimationCallback(this._panel, this._callback);

  void onAnimationComplete() {
    _panel.doAfterLayout();
    if (_callback != null) {
      _callback.onAnimationComplete();
    }
  }

  void onLayout(Layer layer, double progress) {
    if (_callback != null) {
      _callback.onLayout(layer, progress);
    }
  }

}