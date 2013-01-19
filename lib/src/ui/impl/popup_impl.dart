//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Implementation class used by {@link com.google.gwt.user.client.ui.PopupPanel}.
 */
class PopupImpl {

  dart_html.Element createElement() {
    return new dart_html.DivElement();
  }

  dart_html.Element getContainerElement(dart_html.Element popup) {
    return popup;
  }

  dart_html.Element getStyleElement(dart_html.Element popup) {
    return popup.parent;
  }

  /**
   * @param popup the popup
   */
  void onHide(dart_html.Element popup) {
  }

  /**
   * @param popup the popup
   */
  void onShow(dart_html.Element popup) {
  }

  /**
   * @param popup the popup
   * @param rect the clip rect
   */
  void setClip(dart_html.Element popup, String rect) {
    popup.style.clip = rect;
  }

  /**
   * @param popup the popup
   * @param visible true if visible
   */
  void setVisible(dart_html.Element popup, bool visible) {
  }
}
