//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that serves as an "internal" hyperlink. That is, it is a link to
 * another state of the running application. When clicked, it will create a new
 * history frame using {@link com.google.gwt.user.client.History#newItem}, but
 * without reloading the page.
 *
 * <p>
 * If you want an HTML hyperlink (&lt;a&gt; tag) without interacting with the
 * history system, use {@link Anchor} instead.
 * </p>
 *
 * <p>
 * Being a true hyperlink, it is also possible for the user to "right-click,
 * open link in new window", which will cause the application to be loaded in a
 * new window at the state specified by the hyperlink.
 * </p>
 *
 * <p>
 * <h3>Built-in Bidi Text Support</h3>
 * This widget is capable of automatically adjusting its direction according to
 * its content. This feature is controlled by {@link #setDirectionEstimator} or
 * passing a DirectionEstimator parameter to the constructor, and is off by
 * default.
 * </p>
 *
 * <p>
 * <img class='gallery' src='doc-files/Hyperlink.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-Hyperlink { }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3> {@example com.google.gwt.examples.HistoryExample}
 * </p>
 *
 * @see Anchor
 */
class Hyperlink extends Widget implements HasHtml, HasClickHandlers,
  HasDirectionEstimator, HasDirectionalSafeHtml {

  static final DirectionEstimator DEFAULT_DIRECTION_ESTIMATOR = DirectionalTextHelper.DEFAULT_DIRECTION_ESTIMATOR;
  
  static HyperlinkImpl _impl = new HyperlinkImpl();
  
  DirectionalTextHelper directionalTextHelper;
  dart_html.AnchorElement _anchorElem = new dart_html.AnchorElement();
  String _targetHistoryToken;

  /**
   * Creates a hyperlink with its text and target history token specified.
   *
   * @param text the hyperlink's text
   * @param targetHistoryToken the history token to which it will link, which
   *          may not be null (use {@link Anchor} instead if you don't need
   *          history processing)
   */
  Hyperlink([String text, bool asHtml = false, String targetHistoryToken = null]) {
    _init(new dart_html.DivElement(), text, asHtml, targetHistoryToken);
  }

  Hyperlink.fromElement(dart_html.Element element) {
    _init(element);
  }

  void _init(dart_html.Element element, [String text = "", bool asHtml = false, String token = null]) {
    if (element == null) {
      setElement(_anchorElem);
    } else {
      setElement(element);
      getElement().append(_anchorElem);
    }
    sinkEvents(IEvent.ONCLICK);
    directionalTextHelper = new DirectionalTextHelper(_anchorElem, /* is inline */ true);
    //
    directionalTextHelper.setTextOrHtml(text, asHtml);
    //
    if (token != null) {
      targetHistoryToken = token;
    }
    //
    clearAndSetStyleName("dwt-Hyperlink");
  }

  //***********************************
  // Implementation of HasClickHandlers
  //***********************************

  /**
   * Gets this object's contents as HTML.
   *
   * @return the object's HTML
   */
  String get html => directionalTextHelper.getTextOrHtml(true);

  /**
   * Sets this object's contents via HTML. Use care when setting an object's
   * HTML; it is an easy way to expose script-based security problems. Consider
   * using {@link #setText(String)} whenever possible.
   *
   * @param html the object's new HTML
   */
  void set html(String value) {
    directionalTextHelper.setTextOrHtml(html, true);
  }

  //***********************************
  // Implementation of HasClickHandlers
  //***********************************

  /**
   * Adds a {@link ClickEvent} handler.
   *
   * @param handler the click handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addHandler(handler, ClickEvent.TYPE);
  }

  //***********************************
  // Implementation of HasClickHandlers
  //***********************************
  
  /**
   * Returns the {@code DirectionEstimator} object.
   */
  DirectionEstimator getDirectionEstimator() {
    return directionalTextHelper.getDirectionEstimator();
  }
  
  /**
   * Toggles on / off direction estimation.
   *
   * @param enabled Whether to enable direction estimation. If {@code true},
   *          sets the {@link DirectionEstimator} object to a default
   *          {@code DirectionEstimator}.
   */
  void enableDefaultDirectionEstimator(bool enabled) {
    directionalTextHelper.enableDefaultDirectionEstimator(enabled);
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
    directionalTextHelper.setDirectionEstimator(directionEstimator);
  }
  
  //**********
  //Properties
  //**********

  /**
   * Gets the history token referenced by this hyperlink.
   *
   * @return the target history token
   * @see #setTargetHistoryToken
   */
  String get targetHistoryToken => _targetHistoryToken;

  /**
   * Sets the history token referenced by this hyperlink. This is the history
   * token that will be passed to {@link History#newItem} when this link is
   * clicked.
   *
   * @param targetHistoryToken the new history token, which may not be null (use
   *          {@link Anchor} instead if you don't need history processing)
   */
  void set targetHistoryToken(String token) {
    assert (token != null); //  : "targetHistoryToken must not be null, consider using Anchor instead";
    this._targetHistoryToken = token;
    String hash = History.encodeHistoryToken(_targetHistoryToken);
    //DOM.setElementProperty(anchorElem, "href", "#" + hash);
    _anchorElem.href = "#" + hash;
  }

  String get text => directionalTextHelper.getTextOrHtml(false);

  void set text(String value) {
    directionalTextHelper.setTextOrHtml(text, false);
  }
  
  Direction getTextDirection() {
    return directionalTextHelper.getTextDirection();
  }

  void setText(String text, Direction dir) {
    directionalTextHelper.setTextOrHtml(text, false, dir);
  }
  
  //*******
  // Events
  //*******

  void onBrowserEvent(dart_html.Event event) {
    super.onBrowserEvent(event);
    if (Dom.eventGetType(event) == IEvent.ONCLICK && _impl.handleAsClick(event)) {
      History.newItem(targetHistoryToken);
      event.preventDefault();
    }
  }
}
