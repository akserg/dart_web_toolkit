//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that can "pop up" over other widgets. It overlays the browser's
 * client area (and any previously-created popups).
 *
 * <p>
 * A PopupPanel should not generally be added to other panels; rather, it should
 * be shown and hidden using the {@link #show()} and {@link #hide()} methods.
 * </p>
 * <p>
 * The width and height of the PopupPanel cannot be explicitly set; they are
 * determined by the PopupPanel's widget. Calls to {@link #setWidth(String)} and
 * {@link #setHeight(String)} will call these methods on the PopupPanel's
 * widget.
 * </p>
 * <p>
 * <img class='gallery' src='doc-files/PopupPanel.png'/>
 * </p>
 *
 * <p>
 * The PopupPanel can be optionally displayed with a "glass" element behind it,
 * which is commonly used to gray out the widgets behind it. It can be enabled
 * using {@link #setGlassEnabled(bool)}. It has a default style name of
 * "gwt-PopupPanelGlass", which can be changed using
 * {@link #setGlassStyleName(String)}.
 * </p>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.PopupPanelExample}
 * </p>
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-PopupPanel</dt>
 * <dd>the outside of the popup</dd>
 * <dt>.gwt-PopupPanel .popupContent</dt>
 * <dd>the wrapper around the content</dd>
 * <dt>.gwt-PopupPanelGlass</dt>
 * <dd>the glass background behind the popup</dd>
 * </dl>
 */
class PopupPanel extends SimplePanel implements /*EventPreview,*/ HasAnimation, HasCloseHandlers<PopupPanel>  {

  /**
   * The duration of the animation.
   */
  static const int ANIMATION_DURATION = 200;

  /**
   * The default style name.
   */
  static const String DEFAULT_STYLENAME = "dwt-PopupPanel";

  static PopupImpl impl = new PopupImpl();

  /**
   * Window resize handler used to keep the glass the proper size.
   */
  ResizeHandler glassResizer;

  /**
   * If true, animate the opening of this popup from the center. If false,
   * animate it open from top to bottom, and do not animate closing. Use false
   * to animate menus.
   */
  AnimationType animType = AnimationType.CENTER;

  bool autoHide = false, previewAllNativeEvents = false, modal = false, showing = false;
  bool autoHideOnHistoryEvents = false;

  List<dart_html.Element> autoHidePartners;

  // Used to track requested size across changing child widgets
  String desiredHeight;

  String desiredWidth;

  /**
   * The glass element.
   */
  dart_html.Element glass;

  String glassStyleName = "dwt-PopupPanelGlass";

  /**
   * A bool indicating that a glass element should be used.
   */
  bool _isGlassEnabled = false;

  bool _isAnimationEnabled = false;

  // the left style attribute in pixels
  int leftPosition = -1;

  HandlerRegistration nativePreviewHandlerRegistration;
  HandlerRegistration historyHandlerRegistration;

  /**
   * The {@link ResizeAnimation} used to open and close the {@link PopupPanel}s.
   */
  ResizeAnimation resizeAnimation;

  // The top style attribute in pixels
  int topPosition = -1;

  /**
   * Creates an empty popup panel, specifying its "auto-hide" and "modal"
   * properties.
   *
   * @param autoHide <code>true</code> if the popup should be automatically
   *          hidden when the user clicks outside of it or the history token
   *          changes.
   * @param modal <code>true</code> if keyboard or mouse events that do not
   *          target the PopupPanel or its children should be ignored
   */
  PopupPanel([bool autoHide = null, bool modal = null]) : super() {
    glassResizer = new _WindowResizeHandler(this);
    //
    resizeAnimation = new ResizeAnimation(this);
    //

    super.getContainerElement().append(impl.createElement());

    // Default position of popup should be in the upper-left corner of the
    // window. By setting a default position, the popup will not appear in
    // an undefined location if it is shown before its position is set.
    setPopupPosition(0, 0);
    clearAndSetStyleName(DEFAULT_STYLENAME);
    UiObject.setElementStyleName(getContainerElement(), "popupContent");
    //
    if (autoHide != null) {
      this.autoHide = autoHide;
      this.autoHideOnHistoryEvents = autoHide;
    }
    //
    if (modal != null) {
      this.modal = modal;
    }
  }

  /**
   * Mouse events that occur within an autoHide partner will not hide a panel
   * set to autoHide.
   *
   * @param partner the auto hide partner to add
   */
  void addAutoHidePartner(dart_html.Element partner) {
    assert (partner != null); // : "partner cannot be null";
    if (autoHidePartners == null) {
      autoHidePartners = new List<dart_html.Element>();
    }
    autoHidePartners.add(partner);
  }

  HandlerRegistration addCloseHandler(CloseHandler handler) {
    return addHandler(handler, CloseEvent.TYPE);
  }

  /**
   * Centers the popup in the browser window and shows it. If the popup was
   * already showing, then the popup is centered.
   */
  void center() {
    bool initiallyShowing = showing;
    bool initiallyAnimated = _isAnimationEnabled;

    if (!initiallyShowing) {
      visible = false;
      setAnimationEnabled(false);
      show();
    }

    // If left/top are set from a previous center() call, and our content
    // has changed, we may get a bogus getOffsetWidth because our new content
    // is wrapping (giving a lower offset width) then it would without the
    // previous left. Setting left/top back to 0 avoids this.
    dart_html.Element elem = getElement();
    elem.style.left = "0px";
    elem.style.top = "0px";

    int left = (Dom.getClientWidth() - getOffsetWidth()) >> 1;
    int top = (Dom.getClientHeight() - getOffsetHeight()) >> 1;
    setPopupPosition(dart_math.max(Dom.getScrollLeft() + left, 0),
        dart_math.max(Dom.getScrollTop() + top, 0));

    if (!initiallyShowing) {
      setAnimationEnabled(initiallyAnimated);
      // Run the animation. The popup is already visible, so we can skip the
      // call to setState.
      if (initiallyAnimated) {
        impl.setClip(getElement(), "rect(0px, 0px, 0px, 0px)");
        visible = true;
        resizeAnimation.run(ANIMATION_DURATION);
      } else {
        visible = true;
      }
    }
  }

  /**
   * Gets the style name to be used on the glass element. By default, this is
   * "gwt-PopupPanelGlass".
   *
   * @return the glass element's style name
   */
  String getGlassStyleName() {
    return glassStyleName;
  }

  /**
   * Gets the panel's offset height in pixels. Calls to
   * {@link #setHeight(String)} before the panel's child widget is set will not
   * influence the offset height.
   *
   * @return the object's offset height
   */

  int getOffsetHeight() {
    return super.getOffsetHeight();
  }

  /**
   * Gets the panel's offset width in pixels. Calls to {@link #setWidth(String)}
   * before the panel's child widget is set will not influence the offset width.
   *
   * @return the object's offset width
   */

  int getOffsetWidth() {
    return super.getOffsetWidth();
  }

  /**
   * Gets the popup's left position relative to the browser's client area.
   *
   * @return the popup's left position
   */
  int getPopupLeft() {
    return Dom.getAbsoluteLeft(getElement());
  }

  /**
   * Gets the popup's top position relative to the browser's client area.
   *
   * @return the popup's top position
   */
  int getPopupTop() {
    return Dom.getAbsoluteTop(getElement());
  }


  String getTitle() {
    return Dom.getElementProperty(getContainerElement(), "title");
  }

  /**
   * Hides the popup and detaches it from the page. This has no effect if it is
   * not currently showing.
   *
   * @param autoClosed the value that will be passed to
   *          {@link CloseHandler#onClose(CloseEvent)} when the popup is closed
   */
  void hide([bool autoClosed = false]) {
    if (!isShowing()) {
      return;
    }
    resizeAnimation.setState(false, false);
    CloseEvent.fire(this, this, autoClosed);
  }

  bool isAnimationEnabled() {
    return _isAnimationEnabled;
  }

  /**
   * Returns <code>true</code> if the popup should be automatically hidden when
   * the user clicks outside of it.
   *
   * @return true if autoHide is enabled, false if disabled
   */
  bool isAutoHideEnabled() {
    return autoHide;
  }

  /**
   * Returns <code>true</code> if the popup should be automatically hidden when
   * the history token changes, such as when the user presses the browser's back
   * button.
   *
   * @return true if enabled, false if disabled
   */
  bool isAutoHideOnHistoryEventsEnabled() {
    return autoHideOnHistoryEvents;
  }

  /**
   * Returns <code>true</code> if a glass element will be displayed under the
   * {@link PopupPanel}.
   *
   * @return true if enabled
   */
  bool isGlassEnabled() {
    return _isGlassEnabled;
  }

  /**
   * Returns <code>true</code> if keyboard or mouse events that do not target
   * the PopupPanel or its children should be ignored.
   *
   * @return true if popup is modal, false if not
   */
  bool isModal() {
    return modal;
  }

  /**
   * Returns <code>true</code> if the popup should preview all events,
   * even if the event has already been consumed by another popup.
   *
   * @return true if previewAllNativeEvents is enabled, false if disabled
   */
  bool isPreviewingAllNativeEvents() {
    return previewAllNativeEvents;
  }

  /**
   * Determines whether or not this popup is showing.
   *
   * @return <code>true</code> if the popup is showing
   * @see #show()
   * @see #hide()
   */
  bool isShowing() {
    return showing;
  }

  /**
   * Determines whether or not this popup is visible. Note that this just checks
   * the <code>visibility</code> style attribute, which is set in the
   * {@link #setVisible(bool)} method. If you want to know if the popup is
   * attached to the page, use {@link #isShowing()} instead.
   *
   * @return <code>true</code> if the object is visible
   * @see #setVisible(bool)
   */

  bool get visible => getElement().style.visibility != "hidden"; // !"hidden".equals(getElement().style.getProperty("visibility"));

  /**
   * @deprecated Use {@link #onPreviewNativeEvent} instead
   */
//  @Deprecated
  bool onEventPreview(NativePreviewEvent event) {
    return true;
  }

  /**
   * Remove an autoHide partner.
   *
   * @param partner the auto hide partner to remove
   */
  void removeAutoHidePartner(dart_html.Element partner) {
    assert (partner != null); // : "partner cannot be null";
    if (autoHidePartners != null) {
      //autoHidePartners.remove(partner);
      partner.remove();
    }
  }

//  /**
//   * @deprecated Use the {@link HandlerRegistration#removeHandler} method on the
//   *             object returned by {@link #addCloseHandler} instead
//   */
//  @Deprecated
//  void removePopupListener(PopupListener listener) {
//    ListenerWrapper.WrappedPopupListener.remove(this, listener);
//  }

  void setAnimationEnabled(bool enable) {
    _isAnimationEnabled = enable;
  }

  /**
   * Enable or disable the autoHide feature. When enabled, the popup will be
   * automatically hidden when the user clicks outside of it.
   *
   * @param autoHide true to enable autoHide, false to disable
   */
  void setAutoHideEnabled(bool autoHide) {
    this.autoHide = autoHide;
  }

  /**
   * Enable or disable autoHide on history change events. When enabled, the
   * popup will be automatically hidden when the history token changes, such as
   * when the user presses the browser's back button. Disabled by default.
   *
   * @param enabled true to enable, false to disable
   */
  void setAutoHideOnHistoryEventsEnabled(bool enabled) {
    this.autoHideOnHistoryEvents = enabled;
  }

  /**
   * When enabled, the background will be blocked with a semi-transparent pane
   * the next time it is shown. If the PopupPanel is already visible, the glass
   * will not be displayed until it is hidden and shown again.
   *
   * @param enabled true to enable, false to disable
   */
  void setGlassEnabled(bool enabled) {
    this._isGlassEnabled = enabled;
    if (enabled && glass == null) {
      glass = new dart_html.DivElement();
      glass.className = glassStyleName;

      glass.style.position = Position.ABSOLUTE.value;
      glass.style.left = "0" + Unit.PX.value;
      glass.style.top = "0" + Unit.PX.value;
    }
  }

  /**
   * Sets the style name to be used on the glass element. By default, this is
   * "gwt-PopupPanelGlass".
   *
   * @param glassStyleName the glass element's style name
   */
  void setGlassStyleName(String glassStyleName) {
    this.glassStyleName = glassStyleName;
    if (glass != null) {
      glass.className = glassStyleName;
    }
  }

  /**
   * Sets the height of the panel's child widget. If the panel's child widget
   * has not been set, the height passed in will be cached and used to set the
   * height immediately after the child widget is set.
   *
   * <p>
   * Note that subclasses may have a different behavior. A subclass may decide
   * not to change the height of the child widget. It may instead decide to
   * change the height of an internal panel widget, which contains the child
   * widget.
   * </p>
   *
   * @param height the object's new height, in CSS units (e.g. "10px", "1em")
   */

  void setHeight(String height) {
    desiredHeight = height;
    maybeUpdateSize();
    // If the user cleared the size, revert to not trying to control children.
    if (height.length == 0) {
      desiredHeight = null;
    }
  }

  /**
   * When the popup is modal, keyboard or mouse events that do not target the
   * PopupPanel or its children will be ignored.
   *
   * @param modal true to make the popup modal
   */
  void setModal(bool modal) {
    this.modal = modal;
  }

  /**
   * Sets the popup's position relative to the browser's client area. The
   * popup's position may be set before calling {@link #show()}.
   *
   * @param left the left position, in pixels
   * @param top the top position, in pixels
   */
  void setPopupPosition(int left, int top) {
    // Save the position of the popup
    leftPosition = left;
    topPosition = top;

    // Account for the difference between absolute position and the
    // body's positioning context.
    left -= dart_html.document.body.offset.left;
    top -= dart_html.document.body.offset.top;

    // Set the popup's position manually, allowing setPopupPosition() to be
    // called before show() is called (so a popup can be positioned without it
    // 'jumping' on the screen).
    dart_html.Element elem = getElement();
    elem.style.left = left.toString() + Unit.PX.value;
    elem.style.top = top.toString() + Unit.PX.value;
  }

  /**
   * Sets the popup's position using a {@link PositionCallback}, and shows the
   * popup. The callback allows positioning to be performed based on the
   * offsetWidth and offsetHeight of the popup, which are normally not available
   * until the popup is showing. By positioning the popup before it is shown,
   * the the popup will not jump from its original position to the new position.
   *
   * @param callback the callback to set the position of the popup
   * @see PositionCallback#setPosition(int offsetWidth, int offsetHeight)
   */
  void setPopupPositionAndShow(PopupPanelPositionCallback callback) {
    visible = false;
    show();
    callback.setPosition(getOffsetWidth(), getOffsetHeight());
    visible = true;
  }

  /**
   * <p>
   * When enabled, the popup will preview all events, even if another
   * popup was opened after this one.
   * </p>
   * <p>
   * If autoHide is enabled, enabling this feature will cause the popup to
   * autoHide even if another non-modal popup was shown after it. If this
   * feature is disabled, the popup will only autoHide if it was the last popup
   * opened.
   * </p>
   *
   * @param previewAllNativeEvents true to enable, false to disable
   */
  void setPreviewingAllNativeEvents(bool previewAllNativeEvents) {
    this.previewAllNativeEvents = previewAllNativeEvents;
  }


  void setTitle(String title) {
    dart_html.Element containerElement = getContainerElement();
    if (title == null || title.length == 0) {
      containerElement.attributes.remove("title");
    } else {
      containerElement.title = title;
    }
  }

  /**
   * Sets whether this object is visible. This method just sets the
   * <code>visibility</code> style attribute. You need to call {@link #show()}
   * to actually attached/detach the {@link PopupPanel} to the page.
   *
   * @param visible <code>true</code> to show the object, <code>false</code> to
   *          hide it
   * @see #show()
   * @see #hide()
   */

  void set visible(bool vis) {
    // We use visibility here instead of UiObject's default of display
    // Because the panel is absolutely positioned, this will not create
    // "holes" in displayed contents and it allows normal layout passes
    // to occur so the size of the PopupPanel can be reliably determined.
    Dom.setStyleAttribute(getElement(), "visibility", vis ? "visible"
        : "hidden");

    // If the PopupImpl creates an iframe shim, it's also necessary to hide it
    // as well.
    impl.setVisible(getElement(), vis);
    if (glass != null) {
      impl.setVisible(glass, vis);
      glass.style.visibility = vis ? "visible" : "hidden";
    }
  }


  void setWidget(Widget w) {
    super.setWidget(w);
    maybeUpdateSize();
  }

  /**
   * Sets the width of the panel's child widget. If the panel's child widget has
   * not been set, the width passed in will be cached and used to set the width
   * immediately after the child widget is set.
   *
   * <p>
   * Note that subclasses may have a different behavior. A subclass may decide
   * not to change the width of the child widget. It may instead decide to
   * change the width of an internal panel widget, which contains the child
   * widget.
   * </p>
   *
   * @param width the object's new width, in CSS units (e.g. "10px", "1em")
   */

  void setWidth(String width) {
    desiredWidth = width;
    maybeUpdateSize();
    // If the user cleared the size, revert to not trying to control children.
    if (width.length == 0) {
      desiredWidth = null;
    }
  }

  /**
   * Shows the popup and attach it to the page. It must have a child widget
   * before this method is called.
   */
  void show() {
    if (showing) {
      return;
    } else if (isAttached()) {
      // The popup is attached directly to another panel, so we need to remove
      // it from its parent before showing it. This is a weird use case, but
      // since PopupPanel is a Widget, its legal.
      this.removeFromParent();
    }
    resizeAnimation.setState(true, false);
  }

  /**
   * Normally, the popup is positioned directly below the relative target, with
   * its left edge aligned with the left edge of the target. Depending on the
   * width and height of the popup and the distance from the target to the
   * bottom and right edges of the window, the popup may be displayed directly
   * above the target, and/or its right edge may be aligned with the right edge
   * of the target.
   *
   * @param target the target to show the popup below
   */
  void showRelativeTo(UiObject target) {
    // Set the position of the popup right before it is shown.
    setPopupPositionAndShow(new ShowPositionCallback(this, target));
  }


  dart_html.Element getContainerElement() {
    return impl.getContainerElement(getPopupImplElement());
  }

  /**
   * Get the glass element used by this {@link PopupPanel}. The element is not
   * created until it is enabled via {@link #setGlassEnabled(bool)}.
   *
   * @return the glass element, or null if not created
   */
  dart_html.Element getGlassElement() {
    return glass;
  }


  dart_html.Element getStyleElement() {
    return impl.getStyleElement(getPopupImplElement());
  }

  void onPreviewNativeEvent(NativePreviewEvent event) {
    // Cancel the event based on the deprecated onEventPreview() method
    if (event.isFirstHandler() && !onEventPreview(event)) {
      event.cancel();
    }
  }


  void onUnload() {
    super.onUnload();

    // Just to be sure, we perform cleanup when the popup is unloaded (i.e.
    // removed from the Dom). This is normally taken care of in hide(), but it
    // can be missed if someone removes the popup directly from the RootPanel.
    if (isShowing()) {
      resizeAnimation.setState(false, true);
    }
  }

  /**
   * We control size by setting our child widget's size. However, if we don't
   * currently have a child, we record the size the user wanted so that when we
   * do get a child, we can set it correctly. Until size is explicitly cleared,
   * any child put into the popup will be given that size.
   */
  void maybeUpdateSize() {
    // For subclasses of PopupPanel, we want the default behavior of setWidth
    // and setHeight to change the dimensions of PopupPanel's child widget.
    // We do this because PopupPanel's child widget is the first widget in
    // the hierarchy which provides structure to the panel. DialogBox is
    // an example of this. We want to set the dimensions on DialogBox's
    // FlexTable, which is PopupPanel's child widget. However, it is not
    // DialogBox's child widget. To make sure that we are actually getting
    // PopupPanel's child widget, we have to use super.getWidget().
    Widget w = super.getWidget();
    if (w != null) {
      if (desiredHeight != null) {
        w.setHeight(desiredHeight);
      }
      if (desiredWidth != null) {
        w.setWidth(desiredWidth);
      }
    }
  }

  /**
   * Sets the animation used to animate this popup. Used by gwt-incubator to
   * allow DropDownPanel to override the default popup animation. Not protected
   * because the exact API may change in gwt 1.6.
   *
   * @param animation the animation to use for this popup
   */
  void setAnimation(ResizeAnimation animation) {
    resizeAnimation = animation;
  }

  /**
   * Enable or disable animation of the {@link PopupPanel}.
   *
   * @param type the type of animation to use
   */
  void setAnimationType(AnimationType type) {
    animType = type;
  }

  /**
   * Remove focus from an dart_html.Element.
   *
   * @param elt The dart_html.Element on which <code>blur()</code> will be invoked
   */
  void blur(dart_html.Element elt) {
    // Issue 2390: blurring the body causes IE to disappear to the background
    if (elt.blur != null && elt != dart_html.document.body) {
      elt.blur();
    }
  }

  /**
   * Does the event target one of the partner elements?
   *
   * @param event the event
   * @return true if the event targets a partner
   */
  bool eventTargetsPartner(dart_html.Event event) {
    if (autoHidePartners == null) {
      return false;
    }

    dart_html.EventTarget target = event.target;
    if (target is dart_html.Element) {
      for (dart_html.Element elem in autoHidePartners) {
        if (Dom.isOrHasChild(elem, target)) {
          return true;
        }
      }
    }
    return false;
  }

  /**
   * Does the event target this popup?
   *
   * @param event the event
   * @return true if the event targets the popup
   */
  bool eventTargetsPopup(dart_html.Event event) {
    dart_html.EventTarget target = event.target;
    if (target is dart_html.Element) {
      return Dom.isOrHasChild(getElement(), target);
    }
    return false;
  }

  /**
   * Get the element that {@link PopupImpl} uses. PopupImpl creates an element
   * that goes inside of the outer element, so all methods in PopupImpl are
   * relative to the first child of the outer element, not the outer element
   * itself.
   *
   * @return the dart_html.Element that {@link PopupImpl} creates and expects
   */
  dart_html.Element getPopupImplElement() {
    return super.getContainerElement().firstChild;
  }

  /**
   * Positions the popup, called after the offset width and height of the popup
   * are known.
   *
   * @param relativeObject the ui object to position relative to
   * @param offsetWidth the drop down's offset width
   * @param offsetHeight the drop down's offset height
   */
  void position(final UiObject relativeObject, int offsetWidth,
      int offsetHeight) {
    // Calculate left position for the popup. The computation for
    // the left position is bidi-sensitive.

    int textBoxOffsetWidth = relativeObject.getOffsetWidth();

    // Compute the difference between the popup's width and the
    // textbox's width
    int offsetWidthDiff = offsetWidth - textBoxOffsetWidth;

    int left;

    if (LocaleInfo.getCurrentLocale().isRTL()) { // RTL case

      int textBoxAbsoluteLeft = relativeObject.getAbsoluteLeft();

      // Right-align the popup. Note that this computation is
      // valid in the case where offsetWidthDiff is negative.
      left = textBoxAbsoluteLeft - offsetWidthDiff;

      // If the suggestion popup is not as wide as the text box, always
      // align to the right edge of the text box. Otherwise, figure out whether
      // to right-align or left-align the popup.
      if (offsetWidthDiff > 0) {

        // Make sure scrolling is taken into account, since
        // box.getAbsoluteLeft() takes scrolling into account.
        int windowRight = Dom.getClientWidth() + Dom.getScrollLeft();
        int windowLeft = Dom.getScrollLeft();

        // Compute the left value for the right edge of the textbox
        int textBoxLeftValForRightEdge = textBoxAbsoluteLeft
            + textBoxOffsetWidth;

        // Distance from the right edge of the text box to the right edge
        // of the window
        int distanceToWindowRight = windowRight - textBoxLeftValForRightEdge;

        // Distance from the right edge of the text box to the left edge of the
        // window
        int distanceFromWindowLeft = textBoxLeftValForRightEdge - windowLeft;

        // If there is not enough space for the overflow of the popup's
        // width to the right of the text box and there IS enough space for the
        // overflow to the right of the text box, then left-align the popup.
        // However, if there is not enough space on either side, stick with
        // right-alignment.
        if (distanceFromWindowLeft < offsetWidth
            && distanceToWindowRight >= offsetWidthDiff) {
          // Align with the left edge of the text box.
          left = textBoxAbsoluteLeft;
        }
      }
    } else { // LTR case

      // Left-align the popup.
      left = relativeObject.getAbsoluteLeft();

      // If the suggestion popup is not as wide as the text box, always align to
      // the left edge of the text box. Otherwise, figure out whether to
      // left-align or right-align the popup.
      if (offsetWidthDiff > 0) {
        // Make sure scrolling is taken into account, since
        // box.getAbsoluteLeft() takes scrolling into account.
        int windowRight = Dom.getClientWidth() + Dom.getScrollLeft();
        int windowLeft = Dom.getScrollLeft();

        // Distance from the left edge of the text box to the right edge
        // of the window
        int distanceToWindowRight = windowRight - left;

        // Distance from the left edge of the text box to the left edge of the
        // window
        int distanceFromWindowLeft = left - windowLeft;

        // If there is not enough space for the overflow of the popup's
        // width to the right of hte text box, and there IS enough space for the
        // overflow to the left of the text box, then right-align the popup.
        // However, if there is not enough space on either side, then stick with
        // left-alignment.
        if (distanceToWindowRight < offsetWidth
            && distanceFromWindowLeft >= offsetWidthDiff) {
          // Align with the right edge of the text box.
          left -= offsetWidthDiff;
        }
      }
    }

    // Calculate top position for the popup

    int top = relativeObject.getAbsoluteTop();

    // Make sure scrolling is taken into account, since
    // box.getAbsoluteTop() takes scrolling into account.
    int windowTop = Dom.getScrollTop();
    int windowBottom = Dom.getScrollTop() + Dom.getClientHeight();

    // Distance from the top edge of the window to the top edge of the
    // text box
    int distanceFromWindowTop = top - windowTop;

    // Distance from the bottom edge of the window to the bottom edge of
    // the text box
    int distanceToWindowBottom = windowBottom
        - (top + relativeObject.getOffsetHeight());

    // If there is not enough space for the popup's height below the text
    // box and there IS enough space for the popup's height above the text
    // box, then then position the popup above the text box. However, if there
    // is not enough space on either side, then stick with displaying the
    // popup below the text box.
    if (distanceToWindowBottom < offsetHeight
        && distanceFromWindowTop >= offsetHeight) {
      top -= offsetHeight;
    } else {
      // Position above the text box
      top += relativeObject.getOffsetHeight();
    }
    setPopupPosition(left, top);
  }

  /**
   * Preview the {@link dart_html.Event}.
   *
   * @param event the {@link dart_html.Event}
   */
  void previewNativeEvent(NativePreviewEvent event) {
    // If the event has been canceled or consumed, ignore it
    if (event.isCanceled() || (!previewAllNativeEvents && event.isConsumed())) {
      // We need to ensure that we cancel the event even if its been consumed so
      // that popups lower on the stack do not auto hide
      if (modal) {
        event.cancel();
      }
      return;
    }

    // Fire the event hook and return if the event is canceled
    onPreviewNativeEvent(event);
    if (event.isCanceled()) {
      return;
    }

    // If the event targets the popup or the partner, consume it
    dart_html.Event nativeEvent = event.getNativeEvent();
    bool eventTargetsPopupOrPartner = eventTargetsPopup(nativeEvent) || eventTargetsPartner(nativeEvent);
    if (eventTargetsPopupOrPartner) {
      event.consume();
    }

    // Cancel the event if it doesn't target the modal popup. Note that the
    // event can be both canceled and consumed.
    if (modal) {
      event.cancel();
    }

    // Switch on the event type
    int type = IEvent.getTypeInt(nativeEvent.type);
    switch (type) {
//      case IEvent.ONKEYDOWN:
//        if (!onKeyDownPreview((char) nativeEvent.getKeyCode(),
//            KeyboardListenerCollection.getKeyboardModifiers(nativeEvent))) {
//          event.cancel();
//        }
//        return;
//      case IEvent.ONKEYUP:
//        if (!onKeyUpPreview((char) nativeEvent.getKeyCode(),
//            KeyboardListenerCollection.getKeyboardModifiers(nativeEvent))) {
//          event.cancel();
//        }
//        return;
//      case IEvent.ONKEYPRESS:
//        if (!onKeyPressPreview((char) nativeEvent.getKeyCode(),
//            KeyboardListenerCollection.getKeyboardModifiers(nativeEvent))) {
//          event.cancel();
//        }
//        return;
//
      case IEvent.ONMOUSEDOWN:
        // Don't eat events if event capture is enabled, as this can
        // interfere with dialog dragging, for example.
        if (Dom.getCaptureElement() != null) {
          event.consume();
          return;
        }

        if (!eventTargetsPopupOrPartner && autoHide) {
          hide(true);
          return;
        }
        break;
      case IEvent.ONMOUSEUP:
      case IEvent.ONMOUSEMOVE:
      case IEvent.ONCLICK:
      case IEvent.ONDBLCLICK:
        // Don't eat events if event capture is enabled, as this can
        // interfere with dialog dragging, for example.
        if (Dom.getCaptureElement() != null) {
          event.consume();
          return;
        }
        break;

      case IEvent.ONFOCUS:
        dart_html.Element target = nativeEvent.target as dart_html.Element;
        if (modal && !eventTargetsPopupOrPartner && (target != null)) {
          blur(target);
          event.cancel();
          return;
        }
        break;
    }
  }

  /**
   * Register or unregister the handlers used by {@link PopupPanel}.
   */
  void updateHandlers() {
    // Remove any existing handlers.
    if (nativePreviewHandlerRegistration != null) {
      nativePreviewHandlerRegistration.removeHandler();
      nativePreviewHandlerRegistration = null;
    }
    if (historyHandlerRegistration != null) {
      historyHandlerRegistration.removeHandler();
      historyHandlerRegistration = null;
    }

    // Create handlers if showing.
    if (showing) {
      nativePreviewHandlerRegistration = IEvent.addNativePreviewHandler(new NativePreviewHandlerAdapter((NativePreviewEvent event) {
        previewNativeEvent(event);
      }));
      historyHandlerRegistration = History.addValueChangeHandler(new HistoryValueChangeHandler(this));
    }
  }
}

class HistoryValueChangeHandler<String> implements ValueChangeHandler<String> {

  PopupPanel _panel;

  HistoryValueChangeHandler(this._panel);

  /**
   * Called when {@link ValueChangeEvent} is fired.
   *
   * @param event the {@link ValueChangeEvent} that was fired
   */
  void onValueChange(ValueChangeEvent<String> event) {
    if (_panel.autoHideOnHistoryEvents) {
      _panel.hide();
    }
  }
}

/**
 * A callback that is used to set the position of a {@link PopupPanel} right
 * before it is shown.
 */
abstract class PopupPanelPositionCallback {

  /**
   * Provides the opportunity to set the position of the PopupPanel right
   * before the PopupPanel is shown. The offsetWidth and offsetHeight values
   * of the PopupPanel are made available to allow for positioning based on
   * its size.
  *
   * @param offsetWidth the offsetWidth of the PopupPanel
   * @param offsetHeight the offsetHeight of the PopupPanel
   * @see PopupPanel#setPopupPositionAndShow(PositionCallback)
   */
  void setPosition(int offsetWidth, int offsetHeight);
}

/**
 * Set the position of the popup right before it is shown.
 */
class ShowPositionCallback implements PopupPanelPositionCallback {

  PopupPanel _panel;
  UiObject _target;

  ShowPositionCallback(_panel, this._target);

    /**
     * Provides the opportunity to set the position of the PopupPanel right
     * before the PopupPanel is shown. The offsetWidth and offsetHeight values
     * of the PopupPanel are made available to allow for positioning based on
     * its size.
    *
     * @param offsetWidth the offsetWidth of the PopupPanel
     * @param offsetHeight the offsetHeight of the PopupPanel
     * @see PopupPanel#setPopupPositionAndShow(PositionCallback)
     */
  void setPosition(int offsetWidth, int offsetHeight) {
    _panel.position(_target, offsetWidth, offsetHeight);
  }
}

/**
 * An {@link Animation} used to enlarge the popup into view.
 */
class ResizeAnimation extends Animation {
  /**
   * The {@link PopupPanel} being affected.
   */
  PopupPanel curPanel = null;

  /**
   * Indicates whether or not the {@link PopupPanel} is in the process of
   * unloading. If the popup is unloading, then the animation just does
   * cleanup.
   */
  bool isUnloading = false;

  /**
   * The offset height and width of the current {@link PopupPanel}.
   */
  int offsetHeight, offsetWidth = -1;

  /**
   * A bool indicating whether we are showing or hiding the popup.
   */
  bool showing = false;

  /**
   * The timer used to delay the show animation.
   */
  Timer showTimer;

  /**
   * A bool indicating whether the glass element is currently attached.
   */
  bool glassShowing = false;

  //HandlerRegistration resizeRegistration;

  /**
   * Create a new {@link ResizeAnimation}.
  *
   * @param panel the panel to affect
   */
  ResizeAnimation(PopupPanel panel) {
    this.curPanel = panel;
  }

  /**
   * Open or close the content. This method always called immediately after
   * the PopupPanel showing state has changed, so we base the animation on the
   * current state.
  *
   * @param showing true if the popup is showing, false if not
   */
  void setState(bool showing, bool isUnloading) {
    // Immediately complete previous open/close animation
    this.isUnloading = isUnloading;
    cancel();

    // If there is a pending timer to start a show animation, then just cancel
    // the timer and complete the show operation.
    if (showTimer != null) {
      showTimer.cancel();
      showTimer = null;
      onComplete();
    }

    // Update the logical state.
    curPanel.showing = showing;
    curPanel.updateHandlers();

    // Determine if we need to animate
    bool animate = !isUnloading && curPanel._isAnimationEnabled;
    if (curPanel.animType != AnimationType.CENTER && !showing) {
      animate = false;
    }

    // Open the new item
    this.showing = showing;
    if (animate) {
      // impl.onShow takes some time to complete, so we do it before starting
      // the animation. If we move this to onStart, the animation will look
      // choppy or not run at all.
      if (showing) {
        maybeShowGlass();

        // Set the position attribute, and then attach to the Dom. Otherwise,
        // the PopupPanel will appear to 'jump' from its static/relative
        // position to its absolute position (issue #1231).
        Dom.setStyleAttribute(curPanel.getElement(), "position", "absolute");
        if (curPanel.topPosition != -1) {
          curPanel.setPopupPosition(curPanel.leftPosition,
              curPanel.topPosition);
        }
        PopupPanel.impl.setClip(curPanel.getElement(), getRectString(0, 0, 0, 0));
        RootPanel.get().add(curPanel);
        PopupPanel.impl.onShow(curPanel.getElement());

        // Wait for the popup panel and iframe to be attached before running
        // the animation. We use a Timer instead of a DeferredCommand so we
        // can cancel it if the popup is hidden synchronously.
        showTimer = new Timer.get(() {
          showTimer = null;
          run(PopupPanel.ANIMATION_DURATION);
        });
        showTimer.schedule(1);
      } else {
        run(PopupPanel.ANIMATION_DURATION);
      }
    } else {
      onInstantaneousRun();
    }
  }


  void onComplete() {
    if (!showing) {
      maybeShowGlass();
      if (!isUnloading) {
        RootPanel.get().remove(curPanel);
      }
      PopupPanel.impl.onHide(curPanel.getElement());
    }
    PopupPanel.impl.setClip(curPanel.getElement(), "rect(auto, auto, auto, auto)");
    Dom.setStyleAttribute(curPanel.getElement(), "overflow", "visible");
  }


  void onStart() {
    offsetHeight = curPanel.getOffsetHeight();
    offsetWidth = curPanel.getOffsetWidth();
    Dom.setStyleAttribute(curPanel.getElement(), "overflow", "hidden");
    super.onStart();
  }


  void onUpdate(double progress) {
    if (!showing) {
      progress = 1.0 - progress;
    }

    // Determine the clipping size
    int top = 0;
    int left = 0;
    int right = 0;
    int bottom = 0;
    int height = (progress * offsetHeight).toInt();
    int width = (progress * offsetWidth).toInt();
    switch (curPanel.animType) {
      case AnimationType.ROLL_DOWN:
        right = offsetWidth;
        bottom = height;
        break;
      case AnimationType.CENTER:
        top = (offsetHeight - height) >> 1;
        left = (offsetWidth - width) >> 1;
        right = left + width;
        bottom = top + height;
        break;
      case AnimationType.ONE_WAY_CORNER:
        if (LocaleInfo.getCurrentLocale().isRTL()) {
          left = offsetWidth - width;
        }
        right = left + width;
        bottom = top + height;
        break;
    }
    // Set the rect clipping
    PopupPanel.impl.setClip(curPanel.getElement(), getRectString(top, right, bottom, left));
  }

  /**
   * Returns a rect string.
   */
  String getRectString(int top, int right, int bottom, int left) {
    return "rect(${top}px, ${right}px, ${bottom}px, ${left}px)";
  }

  /**
   * Show or hide the glass.
   */
  void maybeShowGlass() {
    if (showing) {
      if (curPanel._isGlassEnabled) {
        dart_html.document.body.append(curPanel.glass);
        PopupPanel.impl.onShow(curPanel.glass);

//        resizeRegistration = dart_html.document.window.addResizeHandler(curPanel.glassResizer);
        curPanel.glassResizer.onResize(null);

        glassShowing = true;
      }
    } else if (glassShowing) {
      //dart_html.document.body.removeChild(curPanel.glass);
      curPanel.glass.remove();
      PopupPanel.impl.onHide(curPanel.glass);

//      resizeRegistration.removeHandler();
//      resizeRegistration = null;

      glassShowing = false;
    }
  }

  void onInstantaneousRun() {
    maybeShowGlass();
    if (showing) {
      // Set the position attribute, and then attach to the Dom. Otherwise,
      // the PopupPanel will appear to 'jump' from its static/relative
      // position to its absolute position (issue #1231).
      Dom.setStyleAttribute(curPanel.getElement(), "position", "absolute");
      if (curPanel.topPosition != -1) {
        curPanel.setPopupPosition(curPanel.leftPosition, curPanel.topPosition);
      }
      RootPanel.get().add(curPanel);
      PopupPanel.impl.onShow(curPanel.getElement());
    } else {
      if (!isUnloading) {
        RootPanel.get().remove(curPanel);
      }
      PopupPanel.impl.onHide(curPanel.getElement());
    }
    Dom.setStyleAttribute(curPanel.getElement(), "overflow", "visible");
  }
}


class _WindowResizeHandler implements ResizeHandler {

  PopupPanel _panel;

  _WindowResizeHandler(this._panel);

  void onResize(ResizeEvent event) {
    int winWidth = Dom.getClientWidth();
    int winHeight = Dom.getClientHeight();

    // Hide the glass while checking the document size. Otherwise it would
    // interfere with the measurement.
    _panel.glass.style.display = Display.NONE.value;
    _panel.glass.style.width = "0" + Unit.PX.value;
    _panel.glass.style.height = "0" + Unit.PX.value;

    int width = Dom.getScrollWidth();
    int height = Dom.getScrollHeight();

    // Set the glass size to the larger of the window's client size or the
    // document's scroll size.
    _panel.glass.style.width = dart_math.max(width, winWidth).toString() + Unit.PX.value;
    _panel.glass.style.height = dart_math.max(height, winHeight).toString() + Unit.PX.value;

    // The size is set. Show the glass again.
    _panel.glass.style.display = Display.BLOCK.value;
  }
}