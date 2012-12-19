//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * The panel to which all other widgets must ultimately be added. RootPanels are
 * never created directly. Rather, they are accessed via [RootPanel#get()].
 */
class RootPanel extends AbsolutePanel {

  /**
   * The singleton command used to detach widgets.
   */
  static AttachCommand _maybeDetachCommand = new MaybeDetachExceptionCommand();
  static Map<String, RootPanel> _rootPanels = new Map<String, RootPanel>();
  static Set<Widget> _widgetsToDetach = new Set<Widget>();

  static String DEFAULT_ID = "__id__";

  /**
   * Marks a widget as detached and removes it from the detach list.
   *
   * If an element belonging to a widget originally passed to
   * [#detachOnWindowClose(Widget)] has been removed from the document,
   * calling this method will cause it to be marked as detached immediately.
   * Failure to do so will keep the widget from being garbage collected until
   * the page is unloaded.
   *
   * This method may only be called per widget, and only for widgets that were
   * originally passed to [#detachOnWindowClose(Widget)].
   */
  static void detachNow(Widget widget) {
    assert (_widgetsToDetach.contains(widget)); // : "detachNow() called on a widget not currently in the detach list";

    try {
      widget.onDetach();
    } finally {
      _widgetsToDetach.remove(widget);
    }
  }

  /**
   * Adds a widget to the detach list. This is the list of widgets to be
   * detached when the page unloads.
   *
   * <p>
   * This method must be called for all widgets that have no parent widgets.
   * These are most commonly {@link RootPanel RootPanels}, but can also be any
   * widget used to wrap an existing element on the page. Failing to do this may
   * cause these widgets to leak memory. This method is called automatically by
   * widgets' wrap methods (e.g.
   * {@link Button#wrap(com.google.gwt.dom.client.Element)}).
   * </p>
   *
   * <p>
   * This method may <em>not</em> be called on any widget whose element is
   * contained in another widget. This is to ensure that the DOM and Widget
   * hierarchies cannot get into an inconsistent state.
   * </p>
   *
   * @param widget the widget to be cleaned up when the page closes
   * @see #detachNow(Widget)
   */
  static void detachOnWindowClose(Widget widget) {
    assert (!_widgetsToDetach.contains(widget)); // : "detachOnUnload() called twice for the same widget";
    assert (!_isElementChildOfWidget(widget.getElement())); // : "A widget that has an existing parent widget may not be added to the detach list";

    _widgetsToDetach.add(widget);
  }

  /**
   * Gets the root panel associated with a given browser element. For this to
   * work, the HTML document into which the application is loaded must have
   * specified an element with the given id.
   *
   * @param id the id of the element to be wrapped with a root panel (
   *          <code>null</code> specifies the default instance, which wraps the
   *          &lt;body&gt; element)
   * @return the root panel, or <code>null</code> if no such element was found
   */
  static RootPanel get([String id]) {
    // Find the element that this RootPanel will wrap.
    dart_html.Element elem = null;
    if (id != null) {
      // Return null if the id is specified, but no element is found.
      if (null == (elem = dart_html.document.$dom_getElementById(id))) {
        return null;
      }
    }

    if (id == null) {
      id = DEFAULT_ID;
    }

    // See if this RootPanel is already created.
    RootPanel rp = _rootPanels[id];
    if (rp != null) {
      // If the element associated with an existing RootPanel has been replaced
      // for any reason, return a new RootPanel rather than the existing one (
      // see issue 1937).
      if ((elem == null) || (rp.getElement() == elem)) {
        // There's already an existing RootPanel for this element. Return it.
        return rp;
      }
    }

    // Note that the code in this if block only happens once -
    // on the first RootPanel.get(String) or RootPanel.get()
    // call.
    if (_rootPanels.length == 0) {
      _hookWindowClosing();

      // If we're in a RTL locale, set the RTL directionality
      // on the entire document.
//      if (LocaleInfo.getCurrentLocale().isRTL()) {
//        BidiUtils.setDirectionOnElement(getRootElement(),
//            HasDirection.Direction.RTL);
//      }
    }

    // Create the panel and put it in the map.
    if (elem == null) {
      // 'null' means use document's body element.
      rp = new DefaultRootPanel();
    } else {
      // Otherwise, wrap the existing element.
      rp = new RootPanel(elem);
    }

    _rootPanels[id] = rp;
    detachOnWindowClose(rp);
    return rp;
  }

  /**
   * Convenience method for getting the document's body element.
   *
   * @return the document's body element
   */
  static dart_html.Element getBodyElement() {
    return dart_html.document.body;
  }

  /**
   * Determines whether the given widget is in the detach list.
   *
   * @param widget the widget to be checked
   * @return <code>true</code> if the widget is in the detach list
   */
  static bool isInDetachList(Widget widget) {
    return _widgetsToDetach.contains(widget);
  }

  /**
   * Convenience method for getting the document's root (<html>) element.
   *
   * @return the document's root element
   */
  static dart_html.Element getRootElement() {
    return dart_html.document.body;
  }

  /*
   * Checks to see whether the given element has any parent element that
   * belongs to a widget. This is not terribly efficient, and is thus only used
   * in an assertion.
   */
  static bool _isElementChildOfWidget(dart_html.Element element) {
    // Walk up the DOM hierarchy, looking for any widget with an event listener
    // set. Though it is not dependable in the general case that a widget will
    // have set its element's event listener at all times, it *is* dependable
    // if the widget is attached. Which it will be in this case.
    element = element.parent;
    dart_html.BodyElement body = dart_html.document.body;
//    while ((element != null) && (body != element)) {
//      if (Event.getEventListener(element) != null) {
//        return true;
//      }
//      element = element.getParentElement().cast();
//    }
    return false;
  }

  // Package-protected for use by unit tests. Do not call this method directly.
  static void detachWidgets() {
    // When the window is closing, detach all widgets that need to be
    // cleaned up. This will cause all of their event listeners
    // to be unhooked, which will avoid potential memory leaks.
    try {
      AttachDetachException.tryCommand(_widgetsToDetach, _maybeDetachCommand);
    } finally {
      _widgetsToDetach.clear();

      // Clear the RootPanel cache, since we've "detached" all RootPanels at
      // this point. This would be pointless, since it only happens on unload,
      // but it is very helpful for unit tests, because it allows
      // RootPanel.get() to work properly even after a synthesized "unload".
      _rootPanels.clear();
    }
  }

  static void _hookWindowClosing() {
    // Catch the window closing event.
//    Window.addCloseHandler(new CloseHandler<Window>() {
//      public void onClose(CloseEvent<Window> closeEvent) {
//        detachWidgets();
//      }
//    });
    dart_html.window.on.unload.add((dart_html.Event event) {
      detachWidgets();
    });
  }

  RootPanel(dart_html.Element elem) : super(elem) {
    onAttach();
  }
}

/**
 * A default RootPanel implementation that wraps the body element.
 */
class DefaultRootPanel extends RootPanel {

  DefaultRootPanel() : super(RootPanel.getBodyElement());

  void setWidgetPositionImpl(Widget w, int left, int top) {
    // Account for the difference between absolute position and the
    // body's positioning context.
    left -= dart_html.document.body.offsetLeft; // getBodyOffsetLeft();
    top -= dart_html.document.body.offsetTop; //.getBodyOffsetTop();

    super.setWidgetPositionImpl(w, left, top);
  }
}

class MaybeDetachExceptionCommand implements AttachCommand {

  /**
   * The singleton command used to detach widgets.
   */
  void execute(Widget w) {
    if (w.isAttached()) {
      w.onDetach();
    }
  }
}