//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_ui;

/**
 * Implemented by objects that have the visibility trait.
 */
abstract class HasVisibility {

  /**
   * Determines whether or not this object is visible. Note that this does not
   * necessarily take into account whether or not the receiver's parent is
   * visible, or even if it is attached to the
   * [Document]. The default implementation of this trait in [UIObject] is 
   * based on the value of a dom element's style object's display attribute.
   * 
   * @return <code>true</code> if the object is visible
   */
  bool get visible;

  /**
   * Sets whether this object is visible.
   * 
   * @param visible <code>true</code> to show the object, <code>false</code> to
   *          hide it
   */
  void set visible(bool visible);
}
