//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * An entry in a
 * {@link com.google.gwt.user.client.ui.MenuBar}. Menu items can either fire a
 * {@link com.google.gwt.core.client.Scheduler.ScheduledCommand} when they are clicked, or open a
 * cascading sub-menu.
 *
 * Each menu item is assigned a unique Dom id in order to support ARIA. See
 * {@link com.google.gwt.user.client.ui.Accessibility} for more information.
 */
class MenuItem extends UiObject implements HasHtml, HasEnabled, HasSafeHtml {

  static final String _DEPENDENT_STYLENAME_SELECTED_ITEM = "selected";
  static final String _DEPENDENT_STYLENAME_DISABLED_ITEM = "disabled";

  ScheduledCommand _command;
  MenuBar _parentMenu, _subMenu;
  bool _enabled = true;

  /**
   * Constructs a new menu item that fires a command when it is selected.
   *
   * @param html the item's html text
   */
//  MenuItem(SafeHtml html) {
//    this(html.asString(), true);
//  }

  /**
   * Constructs a new menu item that fires a command when it is selected.
   *
   * @param html the item's text
   * @param cmd the command to be fired when it is selected
   */
//  MenuItem(SafeHtml html, ScheduledCommand cmd) {
//    this(html.asString(), true, cmd);
//  }

  /**
   * Constructs a new menu item that cascades to a sub-menu when it is selected.
   *
   * @param html the item's text
   * @param subMenu the sub-menu to be displayed when it is selected
   */
//  MenuItem(SafeHtml html, MenuBar subMenu) {
//    this(html.asString(), true, subMenu);
//  }

  MenuItem.fromSafeHtml(SafeHtml html, {MenuBar subMenu, ScheduledCommand cmd}) {
    _init(html.asString(), true, subMenu:subMenu, cmd:cmd);
  }

  MenuItem(String text, bool asHtml, {MenuBar subMenu:null, ScheduledCommand cmd:null}) {
    _init(text, asHtml, subMenu:subMenu, cmd:cmd);
  }

  void _init(String text, bool asHtml, {MenuBar subMenu:null, ScheduledCommand cmd:null}) {
    setElement(new dart_html.TableCellElement());
    setSelectionStyle(false);

    if (asHtml) {
      this.html = text;
    } else {
      this.text = text;
    }
    clearAndSetStyleName("dwt-MenuItem");

    Dom.setElementAttribute(getElement(), "id", Dom.createUniqueId());

    if (subMenu != null) {
      setSubMenu(subMenu);
    }

    if (cmd != null) {
      setScheduledCommand(cmd);
    }
    // Add a11y role "menuitem"
//    Roles.getMenuitemRole().set(getElement());
  }

  /**
   * Constructs a new menu item that fires a command when it is selected.
   *
   * @param text the item's text
   * @param asHtml <code>true</code> to treat the specified text as html
   * @param cmd the command to be fired when it is selected
   */
//  MenuItem(String text, bool asHtml, ScheduledCommand cmd) {
//    this(text, asHtml);
//    setScheduledCommand(cmd);
//  }

  /**
   * Constructs a new menu item that cascades to a sub-menu when it is selected.
   *
   * @param text the item's text
   * @param asHtml <code>true</code> to treat the specified text as html
   * @param subMenu the sub-menu to be displayed when it is selected
   */
//  MenuItem(String text, bool asHtml, MenuBar subMenu) {
//    this(text, asHtml);
//    setSubMenu(subMenu);
//  }

  /**
   * Constructs a new menu item that fires a command when it is selected.
   *
   * @param text the item's text
   * @param cmd the command to be fired when it is selected
   */
//  MenuItem(String text, ScheduledCommand cmd) {
//    this(text, false);
//    setScheduledCommand(cmd);
//  }

  /**
   * Constructs a new menu item that cascades to a sub-menu when it is selected.
   *
   * @param text the item's text
   * @param subMenu the sub-menu to be displayed when it is selected
   */
//  MenuItem(String text, MenuBar subMenu) {
//    this(text, false);
//    setSubMenu(subMenu);
//  }

//  MenuItem(String text, bool asHtml) {
//    setElement(Dom.createTD());
//    setSelectionStyle(false);
//
//    if (asHtml) {
//      setHtml(text);
//    } else {
//      setText(text);
//    }
//    setStyleName("gwt-MenuItem");
//
//    Dom.setElementAttribute(getElement(), "id", Dom.createUniqueId());
//    // Add a11y role "menuitem"
////    Roles.getMenuitemRole().set(getElement());
//  }

  /**
   * Gets the command associated with this item.  If a scheduled command
   * is associated with this item a command that can be used to execute the
   * scheduled command will be returned.
   *
   * @return the command
   * @deprecated use {@link #getScheduledCommand()} instead
   */
//  @Deprecated
//  Command getCommand() {
//    Command rtnVal;
//
//    if (command == null) {
//      rtnVal = null;
//    } else if (command instanceof Command) {
//      rtnVal = (Command) command;
//    } else {
//      rtnVal = new Command() {
//
//        void execute() {
//          if (command != null) {
//            command.execute();
//          }
//        }
//      };
//    }
//
//    return rtnVal;
//  }


  String get html {
    return getElement().innerHtml;
  }

  /**
   * Gets the menu that contains this item.
   *
   * @return the parent menu, or <code>null</code> if none exists.
   */
  MenuBar getParentMenu() {
    return _parentMenu;
  }

  /**
   * Gets the scheduled command associated with this item.
   *
   * @return this item's scheduled command, or <code>null</code> if none exists
   */
  ScheduledCommand getScheduledCommand() {
    return _command;
  }

  /**
   * Gets the sub-menu associated with this item.
   *
   * @return this item's sub-menu, or <code>null</code> if none exists
   */
  MenuBar getSubMenu() {
    return _subMenu;
  }


  String get text {
    return getElement().text;
  }


  bool get enabled {
    return _enabled;
  }

  /**
   * Sets the command associated with this item.
   *
   * @param cmd the command to be associated with this item
   * @deprecated use {@link #setScheduledCommand(ScheduledCommand)} instead
   */
//  @Deprecated
//  void setCommand(Command cmd) {
//    command = cmd;
//  }


  void set enabled(bool val) {
    if (val) {
      removeStyleDependentName(_DEPENDENT_STYLENAME_DISABLED_ITEM);
    } else {
      addStyleDependentName(_DEPENDENT_STYLENAME_DISABLED_ITEM);
    }
    this._enabled = val;
  }


  void setSafeHtml(SafeHtml val) {
    html = val.asString();
  }


  void set html(String val) {
    getElement().innerHtml = val;
  }

  /**
   * Sets the scheduled command associated with this item.
   *
   * @param cmd the scheduled command to be associated with this item
   */
  void setScheduledCommand(ScheduledCommand cmd) {
    _command = cmd;
  }

  /**
   * Sets the sub-menu associated with this item.
   *
   * @param subMenu this item's new sub-menu
   */
  void setSubMenu(MenuBar subMenu) {
    this._subMenu = subMenu;
    if (this._parentMenu != null) {
      this._parentMenu.updateSubmenuIcon(this);
    }

    if (subMenu != null) {
      // Change tab index from 0 to -1, because only the root menu is supposed
      // to be in the tab order
      FocusPanel.impl.setTabIndex(subMenu.getElement(), -1);

      // Update a11y role "haspopup"
//      Roles.getMenuitemRole().setAriaHaspopupProperty(getElement(), true);
    } else {
      // Update a11y role "haspopup"
//      Roles.getMenuitemRole().setAriaHaspopupProperty(getElement(), false);
    }
  }


  void set text(String val) {
    getElement().text = val;
  }

  void setSelectionStyle(bool selected) {
    if (selected) {
      addStyleDependentName(_DEPENDENT_STYLENAME_SELECTED_ITEM);
    } else {
      removeStyleDependentName(_DEPENDENT_STYLENAME_SELECTED_ITEM);
    }
  }

  void setParentMenu(MenuBar parentMenu) {
    this._parentMenu = parentMenu;
  }
}