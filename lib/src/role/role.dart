//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * <p>Allows ARIA Accessibility attributes to be added to widgets so that they can be identified by
 * assistive technology.</p>
 *
 * <p>ARIA roles define widgets and page structure that can be interpreted by a reader
 * application/device. There is a set of abstract roles which are used as
 * building blocks of the roles hierarchy structural and define the common properties and states
 * for the concrete roles. Abstract roles cannot be set to HTML elements.</p>
 *
 * <p>This class defines some of the supported operations for a role -- set/get/remove
 * role to/from a DOM element.</p>
 *
 * <p>For more details about ARIA roles check <a href="http://www.w3.org/TR/wai-aria/roles">
 * The Roles Model </a>.</p>
 */
class Role {
  
  static final String ATTR_NAME_ROLE = "role";
  String _roleName;
  
  Role(String roleName) {
    assert (roleName != null); // : "Role name cannot be null";
    this._roleName = roleName;
  }
  
  /**
   * Gets the role for the element {@code element}. If none is set, "" is returned.
   *
   * @param element HTML element
   * @return The role attribute value
   */
  String get(dart_html.Element element) {
    assert (element != null); // : "Element cannot be null.";
    return element.attributes[ATTR_NAME_ROLE];
  }
  
  /**
   * Gets the role name
   *
   * @return The role name
   */
  String getName() {
    return _roleName;
  }
  
  /**
   * Removes the role for element {@code element}
   *
   * @param element HTML element
   */
  void remove(dart_html.Element element) {
    assert (element != null); // : "Element cannot be null.";
    element.attributes.remove(ATTR_NAME_ROLE);
  }
  
  /**
   * Sets the role to element {@code element}
   *
   * @param element HTML element
   */
  void set(dart_html.Element element) {
    assert (element != null); // : "Element cannot be null.";
    element.attributes[ATTR_NAME_ROLE] = _roleName;
  }
}
