//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * This class provides a set of static methods that allow you to manipulate the
 * browser's Document Object Model (DOM). It contains methods for manipulating
 * both [Element]s and [Event]s.
 */
class Dom {

  /**
   * DOM helper class Implementation.
   */
  static DomHelper domHelper = new DomHelper.browserDependent();
  
  /**
   * Gets any named property from an element, as a string.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value
   */
  static String getElementProperty(dart_html.Element elem, String prop) {
    assert(elem != null);
    assert(prop != null);
    //
    String eProp = elem.attributes[prop];
    return eProp == null ? null : eProp;
  }

  /**
   * Gets any named property from an element, as an int.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value as an int
   */
  static int getElementPropertyInt(dart_html.Element elem, String prop) {
    String eProp = getElementProperty(elem, prop);
    //
    int intProp = int.parse(eProp);
    return intProp != null ? intProp : 0;
  }

  /**
   * Gets any named property from an element, as a boolean.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value as a boolean
   */
  static bool getElementPropertyBoolean(dart_html.Element elem, String prop) {
    String eProp = getElementProperty(elem, prop);
    //
    return eProp == 'true';
  }

  /**
   * Gets any named property from an element, as a boolean.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value as a boolean
   */
  static void setElementPropertyBoolean(dart_html.Element elem, String prop, bool value) {
    assert(elem != null);
    assert(prop != null);
    assert(value != null);
    //
    elem.attributes[prop] = value.toString();
  }
  
  /**
   * Sets a property on the given element.
   * 
   * @param elem the element whose property is to be set
   * @param prop the name of the property to be set
   * @param value the new property value
   */
  static void setElementProperty(dart_html.Element elem, String prop, String value) {
    elem.attributes[prop] = value;
  }
  
  /**
   * Sets an attribute on a given element.
   * 
   * @param elem element whose attribute is to be set
   * @param attr the name of the attribute
   * @param value the value to which the attribute should be set
   */
  static void setElementAttribute(dart_html.Element elem, String attr, String value) {
    elem.attributes[attr] = value;
  }
  
  /**
   * Removes the named attribute from the given element.
   * 
   * @param elem the element whose attribute is to be removed
   * @param attr the name of the element to remove
   */
  static void removeElementAttribute(dart_html.Element elem, String attr) {
    elem.attributes.remove(attr);
  }
  
  /**
   * Sets the {@link EventListener} to receive events for the given element.
   * Only one such listener may exist for a single element.
   * 
   * @param elem the element whose listener is to be set
   * @param listener the listener to receive {@link Event events}
   */
  static void setEventListener(dart_html.Element elem, EventListener listener) {
    domHelper.setEventListener(elem, listener);
  }
  
  /**
   * Gets an element's absolute left coordinate in the document's coordinate
   * system.
   * 
   * @param elem the element to be measured
   * @return the element's absolute left coordinate
   */
  static int getAbsoluteLeft(dart_html.Element elem) {
    return domHelper.getAbsoluteLeft(elem);
  }
  
  /**
   * Gets an element's absolute top coordinate in the document's coordinate
   * system.
   * 
   * @param elem the element to be measured
   * @return the element's absolute top coordinate
   */
  static int getAbsoluteTop(dart_html.Element elem) {
    return domHelper.getAbsoluteTop(elem);
  }
  
  /**
   * Sets an attribute on the given element's style.
   * 
   * @param elem the element whose style attribute is to be set
   * @param attr the name of the style attribute to be set
   * @param value the style attribute's new value
   */
  static void setStyleAttribute(dart_html.Element elem, String attr, String value) {
//    dart_html.CssStyleDeclaration style = elem.style;
    elem.style.setProperty(attr, value);
  }
}
