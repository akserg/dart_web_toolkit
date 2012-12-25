//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * An object that implements this interface contains text, which can be set and
 * retrieved using these methods.
 * 
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * The body of an XML element representing a widget that implements
 * HasText will be parsed as text and be used in a call to its
 * {@link #setText(String)} method. HasText elements must only
 * contain text. (This behavior is overridden for {@link HasHTML}
 * widgets.)
 * 
 * <p>For example:<pre>
 * &lt;g:Label>Hello.&lt;/g:Label>
 * </pre>
 */
abstract class HasText {

  /**
   * Gets this object's text.
   * 
   * @return the object's text
   */
  String get text;

  /**
   * Sets this object's text.
   * 
   * @param text the object's new text
   */
  void set text(String value);
}
