//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that implements this interface has a 'name' associated with it,
 * allowing it to be used with {@link FormPanel}. This property is the name
 * that will be associated with the widget when its form is submitted.
 */
abstract class HasName {

  /**
   * Sets the widget's name.
   * 
   * @param name the widget's new name
   */
  void set name(String value);

  /**
   * Gets the widget's name.
   * 
   * @return the widget's name
   */
  String get name;
}
