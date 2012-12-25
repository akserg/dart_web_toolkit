//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implementation class used by {@link com.google.gwt.user.client.ui.TextBox}.
 */
class TextBoxImpl {
  
  factory TextBoxImpl.browserDependent() {
    return new TextBoxImpl();
  }
  
  TextBoxImpl();
  
  int getCursorPos(dart_html.InputElement elem) {
    // Guard needed for FireFox.
    try{
      return elem.selectionStart;
    } catch (e) {
      return 0;
    }
  }
  
  int getSelectionLength(dart_html.InputElement elem) {
    // Guard needed for FireFox.
    try{
      return elem.selectionEnd - elem.selectionStart;
    } catch (e) {
      return 0;
    }
  }
  
  int getTextAreaCursorPos(dart_html.InputElement elem) {
    return getCursorPos(elem);
  }
  
  int getTextAreaSelectionLength(dart_html.InputElement elem) {
    return getSelectionLength(elem);
  }
  
  void setSelectionRange(dart_html.InputElement elem, int pos, int length) {
    try {
      elem.setSelectionRange(pos, pos + length);
    } catch (e) {
      // Firefox throws exception if TextBox is not visible, even if attached
    }
  }
}
