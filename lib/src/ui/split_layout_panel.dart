//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that adds user-positioned splitters between each of its child
 * widgets.
 *
 * <p>
 * This panel is used in the same way as {@link DockLayoutPanel}, except that
 * its children's sizes are always specified in {@link Unit#PX} units, and each
 * pair of child widgets has a splitter between them that the user can drag.
 * </p>
 *
 * <p>
 * This widget will <em>only</em> work in standards mode, which requires that
 * the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-SplitLayoutPanel { the panel itself }</li>
 * <li>.gwt-SplitLayoutPanel .gwt-SplitLayoutPanel-HDragger { horizontal dragger
 * }</li>
 * <li>.gwt-SplitLayoutPanel .gwt-SplitLayoutPanel-VDragger { vertical dragger }
 * </li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.SplitLayoutPanelExample}
 * </p>
 */
class SplitLayoutPanel extends DockLayoutPanel {

  static const int DEFAULT_SPLITTER_SIZE = 8;
  static const int DOUBLE_CLICK_TIMEOUT = 500;

  /**
   * The element that masks the screen so we can catch mouse events over
   * iframes.
   */
  static dart_html.Element glassElem = null;

  final int _splitterSize;

  /**
   * Construct a new {@link SplitLayoutPanel} with the specified splitter size
   * in pixels.
   *
   * @param splitterSize the size of the splitter in pixels
   */
  SplitLayoutPanel([this._splitterSize = DEFAULT_SPLITTER_SIZE]) : super(Unit.PX) {
    clearAndSetStyleName("dwt-SplitLayoutPanel");

    if (glassElem == null) {
      glassElem = new dart_html.DivElement();
      glassElem.style.position = Position.ABSOLUTE.type;
      glassElem.style.top = "0".concat(Unit.PX.type);
      glassElem.style.left = "0".concat(Unit.PX.type);
      glassElem.style.margin = "0".concat(Unit.PX.type);
      glassElem.style.padding = "0".concat(Unit.PX.type);
      glassElem.style.borderWidth = "0".concat(Unit.PX.type);

      // We need to set the background color or mouse events will go right
      // through the glassElem. If the SplitPanel contains an iframe, the
      // iframe will capture the event and the slider will stop moving.
      glassElem.style.background = "white";
      glassElem.style.opacity = "0.0";
    }
  }

  /**
   * Return the size of the splitter in pixels.
   *
   * @return the splitter size
   */
  int getSplitterSize() {
    return _splitterSize;
  }

  void _insert(Widget child, Direction direction, double size, Widget before) {
    super._insert(child, direction, size, before);
    if (direction != Direction.CENTER) {
      _insertSplitter(child, before);
    }
  }

  bool remove(Widget child) {
    assert (child is! Splitter); // : "Splitters may not be directly removed";

    int idx = getWidgetIndex(child);
    if (super.remove(child)) {
      // Remove the associated splitter, if any.
      // Now that the widget is removed, idx is the index of the splitter.
      if (idx < getWidgetCount()) {
        // Call super.remove(), or we'll end up recursing.
        super.remove(getWidget(idx));
      }
      return true;
    }
    return false;
  }

  /**
   * Sets the minimum allowable size for the given widget.
   *
   * <p>
   * Its associated splitter cannot be dragged to a position that would make it
   * smaller than this size. This method has no effect for the
   * {@link DockLayoutPanel.Direction#CENTER} widget.
   * </p>
   *
   * @param child the child whose minimum size will be set
   * @param minSize the minimum size for this widget
   */
  void setWidgetMinSize(Widget child, int minSize) {
    assertIsChild(child);
    Splitter splitter = _getAssociatedSplitter(child);
    // The splitter is null for the center element.
    if (splitter != null) {
      splitter.setMinSize(minSize);
    }
  }

  /**
   * Sets a size below which the slider will close completely. This can be used
   * in conjunction with {@link #setWidgetMinSize} to provide a speed-bump
   * effect where the slider will stick to a preferred minimum size before
   * closing completely.
   *
   * <p>
   * This method has no effect for the {@link DockLayoutPanel.Direction#CENTER}
   * widget.
   * </p>
   *
   * @param child the child whose slider should snap closed
   * @param snapClosedSize the width below which the widget will close or
   *        -1 to disable.
   */
  void setWidgetSnapClosedSize(Widget child, int snapClosedSize) {
    assertIsChild(child);
    Splitter splitter = _getAssociatedSplitter(child);
    // The splitter is null for the center element.
    if (splitter != null) {
      splitter.setSnapClosedSize(snapClosedSize);
    }
  }

  /**
   * Sets whether or not double-clicking on the splitter should toggle the
   * display of the widget.
   *
   * @param child the child whose display toggling will be allowed or not.
   * @param allowed whether or not display toggling is allowed for this widget
   */
  void setWidgetToggleDisplayAllowed(Widget child, bool allowed) {
    assertIsChild(child);
    Splitter splitter = _getAssociatedSplitter(child);
    // The splitter is null for the center element.
    if (splitter != null) {
      splitter.setToggleDisplayAllowed(allowed);
    }
  }

  Splitter _getAssociatedSplitter(Widget child) {
    // If a widget has a next sibling, it must be a splitter, because the only
    // widget that *isn't* followed by a splitter must be the CENTER, which has
    // no associated splitter.
    int idx = getWidgetIndex(child);
    if (idx > -1 && idx < getWidgetCount() - 1) {
      Widget splitter = getWidget(idx + 1);
      assert (splitter is Splitter); // : "Expected child widget to be splitter";
      return splitter as Splitter;
    }
    return null;
  }

  void _insertSplitter(Widget widget, Widget before) {
    assert (getChildren().size() > 0); // : "Can't add a splitter before any children";

    LayoutData layout = widget.getLayoutData() as LayoutData;
    Splitter splitter = null;
    switch (getResolvedDirection(layout.direction)) {
      case Direction.WEST:
        splitter = new HSplitter(this, widget, false);
        break;
      case Direction.EAST:
        splitter = new HSplitter(this, widget, true);
        break;
      case Direction.NORTH:
        splitter = new VSplitter(this, widget, false);
        break;
      case Direction.SOUTH:
        splitter = new VSplitter(this, widget, true);
        break;
      default:
        assert (false); // : "Unexpected direction";
        break;
    }

    super._insert(splitter, layout.direction, _splitterSize.toDouble(), before);
  }
}

