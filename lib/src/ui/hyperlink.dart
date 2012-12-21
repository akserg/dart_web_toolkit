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
class Hyperlink extends Widget implements HasClickHandlers {
  
  static HyperlinkImpl _impl = new HyperlinkImpl();
  dart_html.Element _anchorElem = new dart_html.AnchorElement();
  String _targetHistoryToken;
  
  /**
   * Creates a hyperlink with its text and target history token specified.
   *
   * @param text the hyperlink's text
   * @param targetHistoryToken the history token to which it will link, which
   *          may not be null (use {@link Anchor} instead if you don't need
   *          history processing)
   */
  Hyperlink([String text, bool asHTML = false, String targetHistoryToken = null]) {
    _init(new dart_html.DivElement(), targetHistoryToken);
  }
  
  Hyperlink.fromElement(dart_html.Element element) {
    _init(element);
    //
    //sinkEvents(Event.ONCLICK);
    //directionalTextHelper = new DirectionalTextHelper(anchorElem, /* is inline */ true);
  }
  
  void _init(dart_html.Element element, [String targetHistoryToken = null]) {
    if (element == null) {
      setElement(_anchorElem);
    } else {
      setElement(element);
      getElement().append(_anchorElem);
    }
    //
    if (targetHistoryToken != null) {
      setTargetHistoryToken(targetHistoryToken);
    }
    //
    clearAndSetStyleName("dwt-Hyperlink");
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
  void setTargetHistoryToken(String targetHistoryToken) {
    assert (targetHistoryToken != null); //  : "targetHistoryToken must not be null, consider using Anchor instead";
    this._targetHistoryToken = targetHistoryToken;
    String hash = History.encodeHistoryToken(_targetHistoryToken);
    //DOM.setElementProperty(anchorElem, "href", "#" + hash);
    _anchorElem.href = "#".concat(hash);
  }
  
  String get text => _anchorElem.text;
  
  void set text(String value) {
    _anchorElem.text = value;
  }
  
  //*******
  // Events
  //*******
  
  void onBrowserEvent(dart_html.Event event) {
    super.onBrowserEvent(event);
    //if (DOM.eventGetType(event) == Event.ONCLICK && impl.handleAsClick(event)) {
    if (event.type == dart_html.Event.CLICK && _impl.handleAsClick(event)) {
      History.newItem(_targetHistoryToken);
      //DOM.eventPreventDefault(event);
      event.preventDefault();
    }
  }
  
  
}
