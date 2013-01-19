//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * ButtonRole interface.
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
abstract class ButtonRole extends CommandRole {
  void setAriaPressedState(dart_html.Element element, PressedValue value);

  String getAriaPressedState(dart_html.Element element);

  void removeAriaPressedState(dart_html.Element element);
}

/**
 * <p>Implements {@link ButtonRole}.</p>
 */
class ButtonRoleImpl extends Role implements ButtonRole {

  ButtonRoleImpl(String roleName) : super(roleName);

  //*****************************
  // Implementation of ButtonRole
  //*****************************

  void setAriaPressedState(dart_html.Element element, PressedValue value) {
    State.PRESSED.set(element, value);
  }

  String getAriaPressedState(dart_html.Element element) {
    return State.PRESSED.get(element);
  }

  void removeAriaPressedState(dart_html.Element element) {
    State.PRESSED.remove(element);
  }

}