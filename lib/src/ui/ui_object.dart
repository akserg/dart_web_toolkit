//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * The superclass for all user-interface objects. It simply wraps a DOM element,
 * and cannot receive events. Most interesting user-interface classes derive
 * from [Widget].
 */
abstract class UiObject implements HasVisibility {

  dart_html.Element element;

  //**************
  // HasVisibility
  //**************

  /**
   * Determines whether or not this object is visible. Note that this does not
   * necessarily take into account whether or not the receiver's parent is
   * visible, or even if it is attached to the
   * [Document]. The default implementation of this trait in [UIObject] is
   * based on the value of a dom element's style object's display attribute.
   *
   * @return <code>true</code> if the object is visible
   */
  bool get visible => element.style.display != 'none';

  /**
   * Sets whether this object is visible.
   *
   * @param visible <code>true</code> to show the object, <code>false</code> to
   *          hide it
   */
  void set visible(bool visible) {
    element.style.display = visible ? '' : 'none';
    element.attribute['aria-hidden'] = (!visible).toString();
  }

  //***********
  // PROPERTIES
  //***********

  /**
   * Sets this object's browser element. UIObject subclasses must call this
   * method before attempting to call any other methods, and it may only be
   * called once.
   *
   * @param elem the object's element
   */
  void setElement(dart_html.Element elem) {
    assert (element == null);
    this.element = elem;
  }

  /**
   * Gets this object's browser element.
   */
  dart_html.Element getElement() {
    return element;
  }

  /**
   * Replaces this object's browser element.
   *
   * This method exists only to support a specific use-case in Image, and should
   * not be used by other classes.
   *
   * @param elem the object's new element
   */
  void replaceElement(dart_html.Element elem) {
    if (element != null && element.parent != null) {
      // replace this.element in its parent with elem.
      element.parent.replaceWith(elem);
    }

    this.element = elem;
  }

  /**
   * Sets the element's title.
   */
  void set title(String value) {
    if (value == null || value.length == 0) {
      element.attributes.remove("title");
    } else {
      element.attributes["title"] = value;
    }
  }

  /**
   * Get the element's title.
   */
  String get title => element.title;

  //*******
  // Styles
  //*******

//  /**
//   * Gets the element's primary style name.
//   *
//   * @param elem the element whose primary style name is to be retrieved
//   * @return the element's primary style name
//   */
//  static String getStylePrimaryName(UiObject uiObject) {
//    assert(uiObject != null);
//
//    // The primary style name is always the first token of the full CSS class
//    // name. There can be no leading whitespace in the class name, so it's not
//    // necessary to trim() it.
//    return uiObject._stylePrimaryName;
//  }
//
//  /**
//   * Sets the element's primary style name and updates all dependent style
//   * names.
//   *
//   * @param elem the element whose style is to be reset
//   * @param style the new primary style name
//   * @see #setStyleName(Element, String, boolean)
//   */
//  static void setStylePrimaryName(UiObject uiObject, String style) {
//    assert(uiObject != null);
//
//    // Style names cannot contain leading or trailing whitespace, and cannot
//    // legally be empty.
//    style = style.trim();
//    assert(style.length > 0);
//
//    _updatePrimaryAndDependentStyleNames(uiObject, style);
//  }
//
//  /**
//   * Replaces all instances of the primary style name with newPrimaryStyleName.
//   */
//  static void _updatePrimaryAndDependentStyleNames(UiObject uiObject, String newPrimaryStyle) {
//    dart_html.Element elem = uiObject.getElement();
//    // Remove primary style name from elemen classes collection
//    Collection classes = elem.classes.filter(bool f(String clazz) {
//      return clazz != uiObject._stylePrimaryName;
//    });
//    // Check has primary style name dash separator?
//    String nameAfterDashPosition;
//    int dashPosition = uiObject._stylePrimaryName.indexOf("-");
//    if (dashPosition != -1) {
//      nameAfterDashPosition = uiObject._stylePrimaryName.substring(dashPosition);
//    }
//    // Assign new primary style name
//    uiObject._stylePrimaryName = newPrimaryStyle;
//    // Restore nameAfterDashPosition if applicable
//    if (dashPosition != -1) {
//      uiObject._stylePrimaryName = uiObject._stylePrimaryName.concat("-").concat(nameAfterDashPosition);
//    }
//    // Append primary style name to classes
//    List<String> resultCollection = new List.from(classes);
//    resultCollection.add(uiObject._stylePrimaryName);
//    // Assign back to element
//    elem.classes = resultCollection;
//  }

}
