//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * An absolute panel positions all of its children absolutely, allowing them to
 * overlap.
 *
 * <p>
 * Note that this panel will not automatically resize itself to allow enough
 * room for its absolutely-positioned children. It must be explicitly sized in
 * order to make room for them.
 * </p>
 *
 * <p>
 * Once a widget has been added to an absolute panel, the panel effectively
 * "owns" the positioning of the widget. Any existing positioning attributes on
 * the widget may be modified by the panel.
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * AbsolutePanel elements in {@link com.google.gwt.uibinder.client.UiBinder
 * UiBinder} templates lay out their children with absolute position, using
 * &lt;g:at> elements. Each at element should have <code>left</code> and
 * <code>top</code> attributes in pixels. They also can contain widget children
 * directly, with no position specified.
 *
 * <p>
 * For example:
 *
 * <pre>
 * &lt;g:AbsolutePanel>
 *   &lt;g:at left='10' top='20'>
 *     &lt;g:Label>Lorem ipsum...&lt;/g:Label>
 *   &lt;/g:at>
 *   &lt;g:Label>...dolores est.&lt;/g:Label>
 * &lt;/g:AbsolutePanel>
 * </pre>
 */
class AbsolutePanel extends ComplexPanel implements InsertPanelForIsWidget{

  /**
   * Changes a DOM element's positioning to static.
   *
   * @param elem the DOM element
   */
  static void _changeToStaticPositioning(dart_html.Element elem) {
    elem.style.left = "";
    elem.style.top = "";
    elem.style.position = "";
  }

  /**
   * Creates an empty absolute panel or with the given element.
   * This is protected so that it can be used by [RootPanel] or a subclass that
   * wants to substitute another element.
   * The element is presumed to be a <div>.
   */
  AbsolutePanel([dart_html.Element elem]) {
    if (elem == null) {
      setElement(new dart_html.DivElement());

      // Setting the panel's position style to 'relative' causes it to be treated
      // as a new positioning context for its children.
      getElement().style.position = "relative";
      getElement().style.overflow = "hidden";
    } else {
      setElement(elem);
    }
  }

  void add(Widget w) {
    super.addWidget(w, getElement());
  }

  /**
   * Adds a widget to the panel at the specified position. Setting a position of
   * <code>(-1, -1)</code> will cause the child widget to be positioned
   * statically.
   *
   * @param w the widget to be added
   * @param left the widget's left position
   * @param top the widget's top position
   */
  void addInPosition(Widget w, int left, int top) {
    // In order to avoid the potential for a flicker effect, it is necessary
    // to set the position of the widget before adding it to the AbsolutePanel.
    // The Widget should be removed from its parent before any positional
    // changes are made to prevent flickering.
    w.removeFromParent();
    int beforeIndex = getWidgetCount();
    setWidgetPositionImpl(w, left, top);
    insertAt(w, beforeIndex);
    _verifyPositionNotStatic(w);
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #add(Widget,int,int)
   */
  void addIsWidgetInPosition(IsWidget w, int left, int top) {
    this.addInPosition(w.asWidget(),left,top);
  }

  /**
   * Gets the position of the left outer border edge of the widget relative to
   * the left outer border edge of the panel.
   *
   * @param w the widget whose position is to be retrieved
   * @return the widget's left position
   */
  int getWidgetLeft(Widget w) {
    _checkWidgetParent(w);
    return Dom.getAbsoluteLeft(w.getElement()) - Dom.getAbsoluteLeft(getElement());
  }

  /**
   * Gets the position of the top outer border edge of the widget relative to
   * the top outer border edge of the panel.
   *
   * @param w the widget whose position is to be retrieved
   * @return the widget's top position
   */
  int getWidgetTop(Widget w) {
    _checkWidgetParent(w);
    return Dom.getAbsoluteTop(w.getElement()) - Dom.getAbsoluteTop(getElement());
  }

  void insertAt(Widget w, int beforeIndex) {
    insert(w, getElement(), beforeIndex, true);
  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertAt(asWidgetOrNull(w), beforeIndex);
  }

  /**
   * Inserts a child widget at the specified position before the specified
   * index. Setting a position of <code>(-1, -1)</code> will cause the child
   * widget to be positioned statically. If the widget is already a child of
   * this panel, it will be moved to the specified index.
   *
   * @param w the child widget to be inserted
   * @param left the widget's left position
   * @param top the widget's top position
   * @param beforeIndex the index before which it will be inserted
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  void insertPosition(Widget w, int left, int top, int beforeIndex) {
    // In order to avoid the potential for a flicker effect, it is necessary
    // to set the position of the widget before adding it to the AbsolutePanel.
    // The Widget should be removed from its parent before any positional
    // changes are made to prevent flickering.
    w.removeFromParent();
    setWidgetPositionImpl(w, left, top);
    insertAt(w, beforeIndex);
    _verifyPositionNotStatic(w);
  }

  /**
   * Overrides {@link ComplexPanel#remove(Widget)} to change the removed
   * Widget's element back to static positioning.This is done so that any
   * positioning changes to the widget that were done by the panel are undone
   * when the widget is disowned from the panel.
   */
  bool remove(Widget w) {
    bool removed = super.remove(w);
    if (removed) {
      _changeToStaticPositioning(w.getElement());
    }
    return removed;
  }

  /**
   * Sets the position of the specified child widget. Setting a position of
   * <code>(-1, -1)</code> will cause the child widget to be positioned
   * statically.
   *
   * @param w the child widget to be positioned
   * @param left the widget's left position
   * @param top the widget's top position
   */
  void setWidgetPosition(Widget w, int left, int top) {
    _checkWidgetParent(w);
    setWidgetPositionImpl(w, left, top);
    _verifyPositionNotStatic(w);
  }

  void setWidgetPositionImpl(Widget w, int left, int top) {
    dart_html.Element h = w.getElement();
    if (left == -1 && top == -1) {
      _changeToStaticPositioning(h);
    } else {
      h.style.position = "absolute";
      h.style.left = left.toString().concat("px");
      h.style.top = top.toString().concat("px");
    }
  }

  void _checkWidgetParent(Widget w) {
    if (w.getParent() != this) {
      throw new Exception("Widget must be a child of this panel.");
    }
  }

  /**
   * Verify that the given widget is not statically positioned on the page
   * (relative to the document window), unless the widget is in fact directly
   * attached to the document BODY. Note that the current use of this method is
   * not comprehensive, since we can only verify the offsetParent if both parent
   * (AbsolutePanel) and child widget are both visible and attached to the DOM
   * when this test is executed.
   *
   * @param child the widget whose position and placement should be tested
   */
  void _verifyPositionNotStatic(Widget child) {
    // Only verify widget position in Development Mode
    if (UI.isProdMode()) {
      return;
    }

    // Make sure we can actually perform a check
    if (!isAttached()) {
      return;
    }

    // Non-visible or detached elements have no offsetParent
    if (child.getElement().offsetParent == null) {
      return;
    }

    // Check if offsetParent == parent
    if (child.getElement().offsetParent == getElement()) {
      return;
    }

    /*
     * When this AbsolutePanel is the document BODY, e.g. RootPanel.get(), then
     * no explicit position:relative is needed as children are already
     * positioned relative to their parent. For simplicity we test against
     * parent, not offsetParent, since in IE6+IE7 (but not IE8+) standards mode,
     * the offsetParent, for elements whose parent is the document BODY, is the
     * HTML element, not the BODY element.
     */
    //if ("body".equals(getElement().getNodeName().toLowerCase())) {
    if (getElement() is dart_html.BodyElement) {
      return;
    }

    /*
     * Warn the developer, but allow the execution to continue in case legacy
     * apps depend on broken CSS.
     */
//    String className = getClass().getName();
//    GWT.log("Warning: " + className + " descendants will be incorrectly "
//        + "positioned, i.e. not relative to their parent element, when "
//        + "'position:static', which is the CSS default, is in effect. One "
//        + "possible fix is to call "
//        + "'panel.getElement().getStyle().setPosition(Position.RELATIVE)'.",
//        // Stack trace provides context for the developer
//        new Exception(className.concat(" is missing CSS 'position:{relative,absolute,fixed}'"));
  }
}
