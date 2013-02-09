//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A separator that can be placed in a
 * {@link com.google.gwt.user.client.ui.MenuBar}.
 */
class MenuItemSeparator extends UiObject {

  static final String _STYLENAME_DEFAULT = "dwt-MenuItemSeparator";

  MenuBar _parentMenu;

  /**
   * Constructs a new {@link MenuItemSeparator}.
   */
  MenuItemSeparator() {
    setElement(new dart_html.TableCellElement());
    clearAndSetStyleName(_STYLENAME_DEFAULT);

    // Add an inner element for styling purposes
    dart_html.Element div = new dart_html.DivElement();
    getElement().append(div);
    UiObject.setElementStyleName(div, "menuSeparatorInner");
  }

  /**
   * Gets the menu that contains this item.
   *
   * @return the parent menu, or <code>null</code> if none exists.
   */
  MenuBar getParentMenu() {
    return _parentMenu;
  }

  void setParentMenu(MenuBar parentMenu) {
    this._parentMenu = parentMenu;
  }
}
