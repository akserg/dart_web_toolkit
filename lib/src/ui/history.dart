//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * This class allows you to interact with the browser's history stack. Each
 * "item" on the stack is represented by a single string, referred to as a
 * "token". You can create new history items (which have a token associated with
 * them when they are created), and you can programmatically force the current
 * history to move back or forward.
 *
 * <p>
 * In order to receive notification of user-directed changes to the current
 * history item, implement the {@link ValueChangeHandler} interface and attach
 * it via {@link #addValueChangeHandler(ValueChangeHandler)}.
 * </p>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.HistoryExample}
 * </p>
 *
 * <p>
 * <h3>URL Encoding</h3>
 * Any valid characters may be used in the history token and will survive
 * round-trips through {@link #newItem(String)} to {@link #getToken()}/
 * {@link ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)}
 * , but most will be encoded in the user-visible URL. The following US-ASCII
 * characters are not encoded on any currently supported browser (but may be in
 * the future due to future browser changes):
 * <ul>
 * <li>a-z
 * <li>A-Z
 * <li>0-9
 * <li>;,/?:@&=+$-_.!~*()
 * </ul>
 * </p>
 */
class History {
  static HistoryImpl _impl;
  
  /**
   * Adds a {@link com.google.gwt.event.logical.shared.ValueChangeEvent} handler
   * to be informed of changes to the browser's history stack.
   *
   * @param handler the handler
   * @return the registration used to remove this value change handler
   */
  static HandlerRegistration addValueChangeHandler(ValueChangeHandler<String> handler) {
    return _impl != null ? _impl.addValueChangeHandler(handler) : null;
  }
  
  /**
   * Programmatic equivalent to the user pressing the browser's 'back' button.
   *
   * Note that this does not work correctly on Safari 2.
   */
  static void back() {
    dart_html.window.history.back();
  }
  
  /**
   * Programmatic equivalent to the user pressing the browser's 'forward'
   * button.
   */
  static void forward() {
    dart_html.window.history.forward();
  }
  
  /**
   * Encode a history token for use as part of a URI.
   *
   * @param historyToken the token to encode
   * @return the encoded token, suitable for use as part of a URI
   */
  static String encodeHistoryToken(String historyToken) {
    return _impl != null ? _impl.encodeFragment(historyToken) : historyToken;
  }
  
  /**
   * Fire
   * {@link ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)}
   * events with the current history state. This is most often called at the end
   * of an application's
   * {@link com.google.gwt.core.client.EntryPoint#onModuleLoad()} to inform
   * history handlers of the initial application state.
   */
  static void fireCurrentHistoryState() {
    if (_impl != null) {
      String token = getToken();
      _impl.fireHistoryChangedImpl(token);
    }
  }
  
  /**
   * Gets the current history token. The handler will not receive a
   * {@link ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)}
   * event for the initial token; requiring that an application request the
   * token explicitly on startup gives it an opportunity to run different
   * initialization code in the presence or absence of an initial token.
   *
   * @return the initial token, or the empty string if none is present.
   */
  static String getToken() {
    return _impl != null ? HistoryImpl.getToken() : "";
  }
  
  /**
   * Adds a new browser history entry. Calling this method will cause
   * {@link ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)}
   * to be called as well if and only if issueEvent is true.
   *
   * @param historyToken the token to associate with the new history item
   * @param issueEvent true if a
   *          {@link ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)}
   *          event should be issued
   */
  static void newItem(String historyToken, [bool issueEvent = true]) {
    if (_impl != null) {
      _impl.newItem(historyToken, issueEvent);
    }
  }
}
