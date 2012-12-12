//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * An object that implements this interface contains text, which can be set and
 * retrieved using these methods. The object's text can be set either as HTML or
 * as text.
 * 
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * The body of an XML element representing a widget that implements
 * HasHTML will be parsed as HTML and be used in a call to its
 * {@link #setHTML(String)} method.
 * 
 * <p>For example:<pre>
 * &lt;g:PushButton>&lt;b>Click me!&lt;/b>&lt;/g:PushButton>
 * </pre>
 */
abstract class HasHtml implements HasText {
  
  /**
   * Gets this object's contents as HTML.
   * 
   * @return the object's HTML
   */
  String get html;

  /**
   * Sets this object's contents via HTML. Use care when setting an object's
   * HTML; it is an easy way to expose script-based security problems. Consider
   * using {@link #setText(String)} whenever possible.
   * 
   * @param html the object's new HTML
   */
  void set html(String value);
}
