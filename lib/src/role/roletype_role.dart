//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * RoletypeRole interface.
 * The interface defines methods for setting, getting, removing states and properties.
 * <p>Allows ARIA Accessibility attributes to be added to widgets so that they can be identified by
 * assistive technology.</p>
 *
 * <p>ARIA roles define widgets and page structure that can be interpreted by a reader
 * application/device. There is a set of abstract roles which are used as
 * building blocks of the roles hierarchy structural and define the common properties and states
 * for the concrete roles. Abstract roles cannot be set to HTML elements.</p>
 *
 * <p>There are states and properties that are defined for a role. As roles are organized in a
 * hierarchy, a role has inherited and own properties and states which can be set to the
 * element.</p>
 *
 * <p>For more details about ARIA roles check <a href="http://www.w3.org/TR/wai-aria/roles">
 * The Roles Model </a>.</p>
 */
abstract class RoletypeRole {

  /**
   * Gets the role for the element {@code element}. If none is set, "" is returned.
   *
   * @param element HTML element
   * @return The role attribute value
   */
  String get(dart_html.Element element);

  /**
   * Gets the role name
   *
   * @return The role name
   */
  String getName();

  /**
   * Removes the role for element {@code element}
   *
   * @param element HTML element
   */
  void remove(dart_html.Element element);

  /**
   * Sets the role to element {@code element}
   *
   * @param element HTML element
   */
  void set(dart_html.Element element);
}
