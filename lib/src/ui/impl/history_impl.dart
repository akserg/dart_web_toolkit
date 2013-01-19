//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Native implementation associated with
 * {@link com.google.gwt.user.client.History}. User classes should not use this
 * class directly.
 *
 * <p>
 * This base version uses the HTML5 standard window.onhashchange event to
 * determine when the URL hash identifier changes.
 * </p>
 */
class HistoryImpl implements HasValueChangeHandlers<String> {

  static String _token = "";

  static String getToken() {
    return (_token == null) ? "" : _token;
  }

  static void setToken(String token) {
    HistoryImpl._token = token;
  }

  EventBus _handlers = new SimpleEventBus();

  //*****************************************
  // Implementation of HasValueChangeHandlers
  //*****************************************

  /**
   * Adds a {@link ValueChangeEvent} handler to be informed of changes to the
   * browser's history stack.
   *
   * @param handler the handler
   */
  HandlerRegistration addValueChangeHandler(ValueChangeHandler<String> handler) {
    return _handlers.addHandler(ValueChangeEvent.TYPE, handler);
  }

  //****

  String encodeFragment(String fragment) {
    // encodeURI() does *not* encode the '#' character.
    return fragment; //encodeURI(fragment).replace("#", "%23");
  }

  String decodeFragment(String encodedFragment) {
    // decodeURI() does *not* decode the '#' character.
    return encodedFragment; //decodeURI(encodedFragment.replace("%23", "#"));
  }

  void fireEvent(DwtEvent event) {
    _handlers.fireEvent(event);
  }

  /**
   * Fires the {@link ValueChangeEvent} to all handlers with the given tokens.
   */
  void fireHistoryChangedImpl(String newToken) {
    ValueChangeEvent.fire(this, newToken);
  }

  EventBus getHandlers() {
    return _handlers;
  }

  bool init() {

    var token = '';

    // Get the initial token from the url's hash component.
    String hash = dart_html.window.location.hash;
    if (hash.length > 0) {
      token = decodeFragment(hash.substring(1));
    }

    HistoryImpl.setToken(token);

    //var historyImpl = this;

    //var oldHandler = dart_html.window.on["hashchange"];

    dart_html.window.on.hashChange.add((dart_html.Event event) {
      var token = '';
      String hash = dart_html.window.location.hash;
      if (hash.length > 0) {
        token = decodeFragment(hash.substring(1));
      }

      HistoryImpl.setToken(token);

//      if (oldHandler) {
//        oldHandler();
//      }
    });

    return true;

  }

  void newItem(String historyToken, bool issueEvent) {
    historyToken = (historyToken == null) ? "" : historyToken;
    if (historyToken != getToken()) {
      setToken(historyToken);
      nativeUpdate(historyToken);
      if (issueEvent) {
        fireHistoryChangedImpl(historyToken);
      }
    }
  }

  void newItemOnEvent(String historyToken) {
    historyToken = (historyToken == null) ? "" : historyToken;
    if (historyToken != getToken()) {
      setToken(historyToken);
      nativeUpdateOnEvent(historyToken);
      fireHistoryChangedImpl(historyToken);
    }
  }

  void nativeUpdate(String historyToken) {
    //$wnd.location.hash = this.@com.google.gwt.user.client.impl.HistoryImpl::encodeFragment(Ljava/lang/String;)(historyToken);
    dart_html.window.location.hash = encodeFragment(historyToken);
  }

  void nativeUpdateOnEvent(String historyToken) {
    // Do nothing, the hash is already updated.
  }
}
