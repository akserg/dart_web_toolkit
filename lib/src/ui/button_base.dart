//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

abstract class ButtonBase extends FocusWidget implements HasHtml, HasSafeHtml {
  
  /**
   * Creates a new ButtonBase that wraps the given browser element.
   * 
   * @param elem the DOM element to be wrapped
   */
  ButtonBase(dart_html.Element elem) : super(elem);
  
  //**************************
  // Implementation of HasHtml
  //**************************
  
  /**
   * Gets this object's contents as HTML.
   * 
   * @return the object's HTML
   */
  String get html {
    return getElement().innerHtml;
  }

  /**
   * Sets this object's contents via HTML. Use care when setting an object's
   * HTML; it is an easy way to expose script-based security problems. Consider
   * using {@link #setText(String)} whenever possible.
   * 
   * @param html the object's new HTML
   */
  void set html(String value) {
    assert(value != null);
    getElement().innerHtml = value;
  }
  
  //***********
  // PROPERTIES
  //***********
  
  /**
   * Sets the element's text.
   */
  String get text => getElement().innerText;

  /**
   * Get the element's text.
   */
  void set text(String value) {
    assert(value != null);
    getElement().innerText = value;
  }
}
