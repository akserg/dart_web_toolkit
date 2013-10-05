//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 *  ARIA specific type attribute.
 */
class AriaValueAttribute<T extends AriaAttributeType> extends Attribute<T> {

  AriaValueAttribute(String name, [String defaultValue = null]) : super(name, defaultValue);

  String getSingleValue(T value) {
    return value.getAriaValue();
  }
}
