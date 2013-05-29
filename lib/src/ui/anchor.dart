//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that represents a simple [:a:] element.
 */
class Anchor extends FocusWidget implements HasHorizontalAlignment,
  HasName, HasHtml, HasWordWrap,
  HasDirectionEstimator, HasDirectionalSafeHtml {

  /**
   * The default HREF is a no-op javascript statement. We need an href to ensure
   * that the browser renders the anchor with native styles, such as underline
   * and font color.
   */
  static String DEFAULT_HREF = "javascript:;";

  HorizontalAlignmentConstant _horzAlign;

  DirectionalTextHelper _directionalTextHelper;

  /**
   * Creates an Anchor widget that wraps an existing &lt;a&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory Anchor.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    Anchor anchor = new Anchor.fromElement(element);

    // Mark it attached and remember it for cleanup.
    anchor.onAttach();
    RootPanel.detachOnWindowClose(anchor);

    return anchor;
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;a&gt; element.
   *
   * @param element the element to be used
   */
  Anchor.fromElement(dart_html.AnchorElement element) {
    setElement(element);
    _directionalTextHelper = new DirectionalTextHelper(getAnchorElement(), /* is inline */ true);
  }

  /**
   * Creates an empty anchor.
   *
   * The anchor's href is optionally set to <code>javascript:;</code>, based on
   * the expectation that listeners will be added to the anchor.
   */
  Anchor([bool useDefaultHref = false]) {
    setElement(new dart_html.AnchorElement());
    clearAndSetStyleName("dwt-Anchor");
    _directionalTextHelper = new DirectionalTextHelper(getAnchorElement(), /* is inline */true);
    if (useDefaultHref) {
      href = DEFAULT_HREF;
    }
  }

  DirectionEstimator getDirectionEstimator() {
    return _directionalTextHelper.getDirectionEstimator();
  }

  /**
   * Return [AnchorElement] class casted element.
   */
  dart_html.AnchorElement getAnchorElement() {
    return getElement() as dart_html.AnchorElement;
  }

  //*****************************************
  // Implementation of HasHorizontalAlignment
  //*****************************************

  HorizontalAlignmentConstant getHorizontalAlignment() {
    return _horzAlign;
  }

  void setHorizontalAlignment(HorizontalAlignmentConstant align) {
    _horzAlign = align;
    getElement().style.textAlign = align.getTextAlignString();
  }

  //***************************
  // Implementation of HasFocus
  //***************************
  /**
   * Gets the widget's position in the tab index.
   *
   * @return the widget's tab index
   */
  int get tabIndex => getAnchorElement().tabIndex;

  void setTabIndex(int index) {
    getAnchorElement().tabIndex = index;
  }

  //***********
  // PROPERTIES
  //***********

  /**
   * Sets the anchor's href (the url to which it links).
   */
  void set href(String value) {
    assert(value != null);
    getAnchorElement().href = value;
  }

  /**
   * Get the anchor's href.
   */
  String get href => getAnchorElement().href;

  /**
   * Sets the anchor's name.
   */
  void set name(String value) {
    assert(value != null);
    //getAnchorElement().name = value;
  }

  /**
   * Get the anchor's name.
   */
  String get name => ""; //getAnchorElement().name;

  /**
   * Sets the anchor's target.
   */
  void set target(String value) {
    assert(value != null);
    getAnchorElement().target = value;
  }

  /**
   * Get the anchor's target.
   */
  String get target => getAnchorElement().target;

  /**
   * Sets the anchor's wordWrap.
   */
  void set wordWrap(bool value) {
    assert(value != null);
    getAnchorElement().style.whiteSpace = value ? WhiteSpace.NORMAL.value : WhiteSpace.NOWRAP.value;
  }

  /**
   * Get the anchor's wordWrap.
   */
  bool get wordWrap => getAnchorElement().style.whiteSpace == WhiteSpace.NORMAL.value;

  /**
   * Sets the anchor's html.
   */
  String get html => getAnchorElement().innerHtml;

  /**
   * Get the anchor's html.
   */
  void set html(String value) {
    assert(value != null);
    getAnchorElement().innerHtml = value;
  }

  /**
   * Sets the anchor's text.
   */
  String get text => _directionalTextHelper.getTextOrHtml(false); //getAnchorElement().text;

  /**
   * Get the anchor's text.
   */
  void set text(String value) {
    assert(value != null);
    _directionalTextHelper.setTextOrHtml(value, false);
  }

  void setText(String text, Direction dir) {
    _directionalTextHelper.setTextOrHtml(text, false, dir);
  }

  Direction getTextDirection() {
    return _directionalTextHelper.getTextDirection();
  }

  /**
   * Sets the anchor's text.
   */
//  String get direction => getAnchorElement().dir;
//  Direction getDirection() {
//    return BidiUtils.getDirectionOnElement(getElement());
//  }

  /**
   * Get the anchor's text.
   */
//  void set direction(String value) {
//    assert(value != null);
//    getAnchorElement().dir = value;
//  }
  
  //*****************************************
  // Implementation of HasDirectionalSafeHtml
  //*****************************************
  
  void setHtml(SafeHtml html, Direction dir) {
    _directionalTextHelper.setTextOrHtml(html.asString(), true, dir);
  }

  /**
   * {@inheritDoc}
   * <p>
   * See note at {@link #setDirectionEstimator(DirectionEstimator)}.
   */
  void enableDirectionEstimator(bool enabled) {
    _directionalTextHelper.enableDefaultDirectionEstimator(enabled);
  }

  /**
   * {@inheritDoc}
   * <p>
   * Note: DirectionEstimator should be set before the widget has any content;
   * it's highly recommended to set it using a constructor. Reason: if the
   * widget already has non-empty content, this will update its direction
   * according to the new estimator's result. This may cause flicker, and thus
   * should be avoided.
   */
  void setDirectionEstimator(DirectionEstimator directionEstimator) {
    _directionalTextHelper.setDirectionEstimator(directionEstimator);
  }

  void setAccessKey(int key) {
    //getAnchorElement().accessKey(Character.toString(key));
  }

  void setFocus(bool focused) {
    if (focused) {
      getAnchorElement().focus();
    } else {
      getAnchorElement().blur();
    }
  }
}
