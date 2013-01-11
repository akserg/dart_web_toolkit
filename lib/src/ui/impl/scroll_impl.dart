//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implementation of scrolling behavior.
 */
class ScrollImpl {
  static ScrollImpl impl;

  /**
   * Get the singleton instance of {@link ScrollImpl}.
   */
  static ScrollImpl get() {
    if (impl == null) {
      impl = new ScrollImpl();
    }
    return impl;
  }

  /**
   * Get the maximum horizontal scroll position.
   *
   * @param scrollable the scrollable element
   * @return the maximum scroll position
   */
  int getMaximumHorizontalScrollPosition(dart_html.Element scrollable) {
    return isRtl(scrollable) ? 0 : scrollable.scrollWidth - scrollable.clientWidth;
  }

  /**
   * Get the minimum horizontal scroll position.
   *
   * @param scrollable the scrollable element
   * @return the minimum scroll position
   */
  int getMinimumHorizontalScrollPosition(dart_html.Element scrollable) {
    return isRtl(scrollable) ? scrollable.clientWidth - scrollable.scrollWidth : 0;
  }

  /**
   * Initialize a scrollable element.
   *
   * @param scrollable the scrollable element
   * @param container the container
   */
  void initialize(dart_html.Element scrollable, dart_html.Element container) {
    // Overridden by ScrollImplTrident.
  }

  /**
   * Check if the specified element has an RTL direction. We can't base this on
   * the current locale because the user can modify the direction at the DOM
   * level.
   *
   * @param scrollable the scrollable element
   * @return true if the direction is RTL, false if LTR
   */
  bool isRtl(dart_html.Element scrollable) {
//    var computedStyle = $doc.defaultView.getComputedStyle(scrollable, null);
//    return computedStyle.getPropertyValue('direction') == 'rtl';
    return false;
  }
}


///**
// * IE does not fire a scroll event when the scrollable element or the
// * container is resized, so we synthesize one as needed. IE scrolls in the
// * positive direction, even in RTL mode.
// */
//static class ScrollImplTrident extends ScrollImpl {
//
//  static JavaScriptObject scrollHandler;
//
//  static JavaScriptObject resizeHandler;
//
//  /**
//   * Creates static, leak-safe scroll/resize handlers.
//   */
//  static native void initStaticHandlers() /*-{
//  // caches last scroll position
//  @com.google.gwt.user.client.ui.ScrollImpl.ScrollImplTrident::scrollHandler = function() {
//  var scrollableElem = $wnd.event.srcElement;
//  scrollableElem.__lastScrollTop = scrollableElem.scrollTop;
//  scrollableElem.__lastScrollLeft = scrollableElem.scrollLeft;
//  };
//  // watches for resizes that should fire a fake scroll event
//  @com.google.gwt.user.client.ui.ScrollImpl.ScrollImplTrident::resizeHandler = function() {
//  var scrollableElem = $wnd.event.srcElement;
//  if (scrollableElem.__isScrollContainer) {
//  scrollableElem = scrollableElem.parentNode;
//  }
//  // Give the browser a chance to fire a native scroll event before synthesizing one.
//  setTimeout($entry(function() {
//  // Trigger a synthetic scroll event if the scroll position changes.
//  if (scrollableElem.scrollTop != scrollableElem.__lastScrollTop ||
//  scrollableElem.scrollLeft != scrollableElem.__lastScrollLeft) {
//  // Update scroll positions.
//  scrollableElem.__lastScrollTop = scrollableElem.scrollTop;
//  scrollableElem.__lastScrollLeft = scrollableElem.scrollLeft;
//  @com.google.gwt.user.client.ui.ScrollImpl.ScrollImplTrident::triggerScrollEvent(Lcom/google/gwt/dom/client/dart_html.Element;)
//  (scrollableElem);
//  }
//  }), 1);
//  };
//  }-*/;
//
//  static void triggerScrollEvent(dart_html.Element elem) {
//    elem.dispatchEvent(Document.get().createScrollEvent());
//  }
//
//  ScrollImplTrident() {
//    initStaticHandlers();
//  }
//
//  @Override
//  native void initialize(dart_html.Element scrollable, dart_html.Element container) /*-{
//    // Remember the last scroll position.
//  scrollable.__lastScrollTop = scrollable.__lastScrollLeft = 0;
//  scrollable.attachEvent('onscroll',
//  @com.google.gwt.user.client.ui.ScrollImpl.ScrollImplTrident::scrollHandler);
//
//  // Detect if the scrollable element or the container within it changes
//  // size, either of which could affect the scroll position.
//  scrollable.attachEvent('onresize',
//  @com.google.gwt.user.client.ui.ScrollImpl.ScrollImplTrident::resizeHandler);
//  container.attachEvent('onresize',
//  @com.google.gwt.user.client.ui.ScrollImpl.ScrollImplTrident::resizeHandler);
//  // use bool (primitive, won't leak) hint to resizeHandler that its the container
//  container.__isScrollContainer = true;
//  }-*/;
//
//  @Override
//  native bool isRtl(dart_html.Element scrollable) /*-{
//  return scrollable.currentStyle.direction == 'rtl';
//  }-*/;
//}
