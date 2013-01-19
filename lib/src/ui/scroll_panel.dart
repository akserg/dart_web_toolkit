//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple panel that wraps its contents in a scrollable area.
 */
class ScrollPanel extends SimplePanel implements RequiresResize, ProvidesResize, HasScrolling {

  dart_html.Element containerElem;
  dart_html.Element scrollableElem;

  /**
   * The scroller used to support touch events.
   */
  //TouchScroller touchScroller;

  /**
   * Creates an empty scroll panel or with the given [child] widget.
   */
  ScrollPanel([Widget child = null]) : super() {
    this.scrollableElem = getElement();
    this.containerElem = new dart_html.DivElement();
    scrollableElem.append(containerElem);
    initialize();
    //
    if (child != null) {
      setWidget(child);
    }
  }

  /**
   * Creates an empty scroll panel using the specified root, scrollable, and
   * container elements.
   *
   * @param root the root element of the Widget
   * @param scrollable the scrollable element, which can be the same as the root
   *          element
   * @param container the container element that holds the child
   */
  ScrollPanel.fromElement(dart_html.Element root, dart_html.Element scrollable, dart_html.Element container) : super.fromElement(root) {
    this.scrollableElem = scrollable;
    this.containerElem = container;
    initialize();
  }

  HandlerRegistration addScrollHandler(ScrollHandler handler) {
    /*
     * Sink the event on the scrollable element, which may not be the root
     * element.
     */
//    Event.sinkEvents(getScrollableElement(), Event.ONSCROLL);
    return addHandler(handler, ScrollEvent.TYPE);
  }

  /**
   * Ensures that the specified item is visible, by adjusting the panel's scroll
   * position.
   *
   * @param item the item whose visibility is to be ensured
   */
  void ensureVisible(UiObject item) {
    dart_html.Element scroll = getScrollableElement();
    dart_html.Element element = item.getElement();
    ensureVisibleImpl(scroll, element);
  }

  /**
   * Gets the horizontal scroll position.
   *
   * @return the horizontal scroll position, in pixels
   */
  int getHorizontalScrollPosition() {
    return getScrollableElement().scrollLeft;
  }

  int getMaximumHorizontalScrollPosition() {
    return ScrollImpl.get().getMaximumHorizontalScrollPosition(getScrollableElement());
  }

  int getMaximumVerticalScrollPosition() {
    return getScrollableElement().scrollHeight - getScrollableElement().clientHeight;
  }

  int getMinimumHorizontalScrollPosition() {
    return ScrollImpl.get().getMinimumHorizontalScrollPosition(getScrollableElement());
  }

  int getMinimumVerticalScrollPosition() {
    return 0;
  }

  int getVerticalScrollPosition() {
    return getScrollableElement().scrollTop;
  }

  /**
   * Check whether or not touch based scrolling is disabled. This method always
   * returns false on devices that do not support touch scrolling.
   *
   * @return true if disabled, false if enabled
   */
  bool isTouchScrollingDisabled() {
    return false; //touchScroller == null;
  }

  void onResize() {
    Widget child = getWidget();
    if ((child != null) && (child is RequiresResize)) {
      (child as RequiresResize).onResize();
    }
  }

  /**
   * Scroll to the bottom of this panel.
   */
  void scrollToBottom() {
    setVerticalScrollPosition(getMaximumVerticalScrollPosition());
  }

  /**
   * Scroll to the far left of this panel.
   */
  void scrollToLeft() {
    setHorizontalScrollPosition(getMinimumHorizontalScrollPosition());
  }

  /**
   * Scroll to the far right of this panel.
   */
  void scrollToRight() {
    setHorizontalScrollPosition(getMaximumHorizontalScrollPosition());
  }

  /**
   * Scroll to the top of this panel.
   */
  void scrollToTop() {
    setVerticalScrollPosition(getMinimumVerticalScrollPosition());
  }

  /**
   * Sets whether this panel always shows its scroll bars, or only when
   * necessary.
   *
   * @param alwaysShow <code>true</code> to show scroll bars at all times
   */
  void setAlwaysShowScrollBars(bool alwaysShow) {
    getScrollableElement().style.overflow = alwaysShow ? Overflow.SCROLL.value : Overflow.AUTO.value;
  }

  /**
   * Sets the object's height. This height does not include decorations such as
   * border, margin, and padding.
   *
   * @param height the object's new height, in absolute CSS units (e.g. "10px",
   *          "1em" but not "50%")
   */

  void setHeight(String height) {
    super.setHeight(height);
  }

  /**
   * Sets the horizontal scroll position.
   *
   * @param position the new horizontal scroll position, in pixels
   */
  void setHorizontalScrollPosition(int position) {
    getScrollableElement().scrollLeft = position;
  }

  /**
   * Sets the object's size. This size does not include decorations such as
   * border, margin, and padding.
   *
   * @param width the object's new width, in absolute CSS units (e.g. "10px",
   *          "1em", but not "50%")
   * @param height the object's new height, in absolute CSS units (e.g. "10px",
   *          "1em", but not "50%")
   */

  void setSize(String width, String height) {
    super.setSize(width, height);
  }

  /**
   * Set whether or not touch scrolling is disabled. By default, touch scrolling
   * is enabled on devices that support touch events.
   *
   * @param isDisabled true to disable, false to enable
   * @return true if touch scrolling is enabled and supported, false if disabled
   *         or not supported
   */
  bool setTouchScrollingDisabled(bool isDisabled) {
    if (isDisabled == isTouchScrollingDisabled()) {
      return isDisabled;
    }

//    if (isDisabled) {
//      // Detach the touch scroller.
//      touchScroller.setTargetWidget(null);
//      touchScroller = null;
//    } else {
//      // Attach a new touch scroller.
//      touchScroller = TouchScroller.createIfSupported(this);
//    }
    return isTouchScrollingDisabled();
  }

  void setVerticalScrollPosition(int position) {
    getScrollableElement().scrollTop = position;
  }

  /**
   * Sets the object's width. This width does not include decorations such as
   * border, margin, and padding.
   *
   * @param width the object's new width, in absolute CSS units (e.g. "10px",
   *          "1em", but not "50%")
   */

  void setWidth(String width) {
    super.setWidth(width);
  }


  dart_html.Element getContainerElement() {
    return containerElem;
  }

  /**
   * Get the scrollable element. That is the element with its overflow set to
   * 'auto' or 'scroll'.
   *
   * @return the scrollable element
   */
  dart_html.Element getScrollableElement() {
    return scrollableElem;
  }


  void onAttach() {
    super.onAttach();

    /*
     * Attach the event listener in onAttach instead of onLoad so users cannot
     * accidentally override it. If the scrollable element is the same as the
     * root element, then we set the event listener twice (once in
     * super.onAttach() and once here), which is fine.
     */
    //Event.setEventListener(getScrollableElement(), this);
  }


  void onDetach() {
    /*
     * Detach the event listener in onDetach instead of onUnload so users cannot
     * accidentally override it.
     */
    //Event.setEventListener(getScrollableElement(), null);

    super.onDetach();
  }

  void ensureVisibleImpl(dart_html.Element scroll, dart_html.Element e) {
    if (e == null) {
      return;
    }

    dart_html.Element item = e;
    int realOffset = 0;
    while (item != null && (item != scroll)) {
      realOffset += item.offsetTop;
      item = item.offsetParent;
    }

    scroll.scrollTop = realOffset - scroll.offsetHeight ~/ 2;
  }

  /**
   * Initialize the widget.
   */
  void initialize() {
    setAlwaysShowScrollBars(false);

    // Prevent IE standard mode bug when a AbsolutePanel is contained.
    scrollableElem.style.position = Position.RELATIVE.value;
    containerElem.style.position = Position.RELATIVE.value;

    // Hack to account for the IE6/7 scrolling bug described here:
    //   http://stackoverflow.com/questions/139000/div-with-overflowauto-and-a-100-wide-table-problem
    scrollableElem.style.zoom = "1";
    containerElem.style.zoom = "1";

    // Enable touch scrolling.
    setTouchScrollingDisabled(false);

    // Initialize the scrollable element.
    ScrollImpl.get().initialize(scrollableElem, containerElem);
  }
}
