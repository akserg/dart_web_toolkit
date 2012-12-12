//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_ui;

/**
 * A widget that represents a simple [:a:] element.
 */
class Anchor extends FocusWidget {

  /**
   * The default HREF is a no-op javascript statement. We need an href to ensure
   * that the browser renders the anchor with native styles, such as underline
   * and font color.
   */
  static String DEFAULT_HREF = "javascript:;";

  /**
   * Creates an empty anchor.
   *
   * The anchor's href is optionally set to <code>javascript:;</code>, based on
   * the expectation that listeners will be added to the anchor.
   */
  Anchor.empty({bool useDefaultHref:false}) {
    setElement(new dart_html.AnchorElement());
    //setStyleName("gwt-Anchor");
    if (useDefaultHref) {
      href = DEFAULT_HREF;
    }
  }

  /**
   * Return [AnchorElement] class casted element.
   */
  dart_html.AnchorElement getAnchorElement() {
    return element as dart_html.AnchorElement;
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
    getAnchorElement().name = value;
  }

  /**
   * Get the anchor's name.
   */
  String get name => getAnchorElement().name;

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
    getAnchorElement().style.whiteSpace = value ? WhiteSpace.NORMAL : WhiteSpace.NOWRAP;
  }

  /**
   * Get the anchor's wordWrap.
   */
  bool get wordWrap => getAnchorElement().style.whiteSpace == WhiteSpace.NORMAL;

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
  String get text => getAnchorElement().text;

  /**
   * Get the anchor's text.
   */
  void set text(String value) {
    assert(value != null);
    getAnchorElement().text = value;
  }

  /**
   * Sets the anchor's text.
   */
  String get direction => getAnchorElement().dir;

  /**
   * Get the anchor's text.
   */
  void set direction(String value) {
    assert(value != null);
    getAnchorElement().dir = value;
  }
}
