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
}
