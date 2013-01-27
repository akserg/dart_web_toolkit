//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * An object that implements this interface contains text that has a direction.
 */
abstract class HasDirectionalText extends HasText {

  /**
   * Gets the direction of this object's text.
   *
   * @return the direction of this object's text
   */
  Direction getTextDirection();

  /**
   * Sets this object's text, also declaring its direction.
   *
   * @param text the object's new text
   * @param dir the text's direction
   */
  void setText(String text, Direction dir);
}
