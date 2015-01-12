//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A standard menu bar widget. A menu bar can contain any number of menu items,
 * each of which can either fire a {@link com.google.gwt.core.client.Scheduler.ScheduledCommand} or
 * open a cascaded menu bar.
 *
 * <p>
 * <img class='gallery' src='doc-files/MenuBar.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-MenuBar</dt>
 * <dd>the menu bar itself</dd>
 * <dt>.gwt-MenuBar-horizontal</dt>
 * <dd>dependent style applied to horizontal menu bars</dd>
 * <dt>.gwt-MenuBar-vertical</dt>
 * <dd>dependent style applied to vertical menu bars</dd>
 * <dt>.gwt-MenuBar .gwt-MenuItem</dt>
 * <dd>menu items</dd>
 * <dt>.gwt-MenuBar .gwt-MenuItem-selected</dt>
 * <dd>selected menu items</dd>
 * <dt>.gwt-MenuBar .gwt-MenuItemSeparator</dt>
 * <dd>section breaks between menu items</dd>
 * <dt>.gwt-MenuBar .gwt-MenuItemSeparator .menuSeparatorInner</dt>
 * <dd>inner component of section separators</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupTopLeft</dt>
 * <dd>the top left cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupTopLeftInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupTopCenter</dt>
 * <dd>the top center cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupTopCenterInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupTopRight</dt>
 * <dd>the top right cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupTopRightInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupMiddleLeft</dt>
 * <dd>the middle left cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupMiddleLeftInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupMiddleCenter</dt>
 * <dd>the middle center cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupMiddleCenterInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupMiddleRight</dt>
 * <dd>the middle right cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupMiddleRightInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupBottomLeft</dt>
 * <dd>the bottom left cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupBottomLeftInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupBottomCenter</dt>
 * <dd>the bottom center cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupBottomCenterInner</dt>
 * <dd>the inner element of the cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupBottomRight</dt>
 * <dd>the bottom right cell</dd>
 * <dt>.gwt-MenuBarPopup .menuPopupBottomRightInner</dt>
 * <dd>the inner element of the cell</dd>
 * </dl>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.MenuBarExample}
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * MenuBar elements in UiBinder template files can have a <code>vertical</code>
 * bool attribute (which defaults to false), and may have only MenuItem
 * elements as children. MenuItems may contain HTML and MenuBars.
 * <p>
 * For example:
 *
 * <pre>
 * &lt;g:MenuBar>
 *   &lt;g:MenuItem>Higgledy
 *     &lt;g:MenuBar vertical="true">
 *       &lt;g:MenuItem>able&lt;/g:MenuItem>
 *       &lt;g:MenuItem>baker&lt;/g:MenuItem>
 *       &lt;g:MenuItem>charlie&lt;/g:MenuItem>
 *     &lt;/g:MenuBar>
 *   &lt;/g:MenuItem>
 *   &lt;g:MenuItem>Piggledy
 *     &lt;g:MenuBar vertical="true">
 *       &lt;g:MenuItem>foo&lt;/g:MenuItem>
 *       &lt;g:MenuItem>bar&lt;/g:MenuItem>
 *       &lt;g:MenuItem>baz&lt;/g:MenuItem>
 *     &lt;/g:MenuBar>
 *   &lt;/g:MenuItem>
 *   &lt;g:MenuItem>&lt;b>Pop!&lt;/b>
 *     &lt;g:MenuBar vertical="true">
 *       &lt;g:MenuItem>uno&lt;/g:MenuItem>
 *       &lt;g:MenuItem>dos&lt;/g:MenuItem>
 *       &lt;g:MenuItem>tres&lt;/g:MenuItem>
 *     &lt;/g:MenuBar>
 *   &lt;/g:MenuItem>
 * &lt;/g:MenuBar>
 * </pre>
 */
// Nothing we can do about MenuBar implementing PopupListener until next
// release.
class MenuBar extends Widget implements HasAnimation, HasCloseHandlers<PopupPanel> {

  static final String _STYLENAME_DEFAULT = "dwt-MenuBar";

  /**
   * List of all {@link MenuItem}s and {@link MenuItemSeparator}s.
   */
  List<UiObject> _allItems = new List<UiObject>();

  /**
   * List of {@link MenuItem}s, not including {@link MenuItemSeparator}s.
   */
  List<MenuItem> _items = new List<MenuItem>();

  dart_html.Element _body;

  AbstractImagePrototype _subMenuIcon = null;
  bool _isAnimationEnabled = false;
  MenuBar _parentMenu;
  PopupPanel _popup;
  MenuItem _selectedItem;
  MenuBar _shownChildMenu;
  bool _vertical = false, _autoOpen = false;
  bool _focusOnHover = true;

  /**
   * Creates an empty menu bar that uses the specified ClientBundle for menu
   * images.
   *
   * @param vertical <code>true</code> to orient the menu bar vertically
   * @param resources a bundle that provides images for this menu
   */
  MenuBar([bool vertical = false, MenuResource resources = null]) {
    if (resources == null) {
      resources = new MenuResources();
    }
    _init(vertical, AbstractImagePrototype.create(resources.menuBarSubMenuIcon()));
  }

  HandlerRegistration addCloseHandler(CloseHandler<PopupPanel> handler) {
    return addHandler(handler, CloseEvent.TYPE);
  }

  /**
   * Adds a menu item to the bar.
   *
   * @param item the item to be added
   * @return the {@link MenuItem} object
   */
  MenuItem addItem(MenuItem item) {
    return insertItem(item, _allItems.length);
  }

  /**
   * Adds a menu item to the bar containing SafeHtml, that will fire the given
   * command when it is selected.
   *
   * @param html the item's html text
   * @param cmd the command to be fired
   * @return the {@link MenuItem} object created
   */
  MenuItem addSafeHtmlItem(SafeHtml html, {MenuBar popup, ScheduledCommand cmd}) {
    return addItem(new MenuItem.fromSafeHtml(html, subMenu:popup, cmd:cmd));
  }

  /**
   * Adds a menu item to the bar, that will fire the given command when it is
   * selected.
   *
   * @param text the item's text
   * @param asHtml <code>true</code> to treat the specified text as html
   * @param cmd the command to be fired
   * @return the {@link MenuItem} object created
   */
  MenuItem addTextItem(String text, bool asHtml, {MenuBar popup, ScheduledCommand cmd}) {
    return addItem(new MenuItem(text, asHtml, subMenu:popup, cmd:cmd));
  }

  /**
   * Adds a thin line to the {@link MenuBar} to separate sections of
   * {@link MenuItem}s.
   *
   * @param separator the {@link MenuItemSeparator} to be added
   * @return the {@link MenuItemSeparator} object
   */
  MenuItemSeparator addSeparator([MenuItemSeparator separator = null]) {
    if (separator == null) {
      separator = new MenuItemSeparator();
    }
    return insertSeparator(_allItems.length, separator);
  }

  /**
   * Removes all menu items from this menu bar.
   */
  void clearItems() {
    // Deselect the current item
    selectItem(null);

    dart_html.Element container = _getItemContainerElement();
    while (Dom.getChildCount(container) > 0) {
      Dom.getChild(container, 0).remove();
    }

    // Set the parent of all items to null
    for (UiObject item in _allItems) {
      _setItemColSpan(item, 1);
      if (item is MenuItemSeparator) {
        item.setParentMenu(null);
      } else {
        (item as MenuItem).setParentMenu(null);
      }
    }

    // Clear out all of the items and separators
    _items.clear();
    _allItems.clear();
  }

  /**
   * Closes this menu and all child menu popups.
   *
   * @param pFocus true to move focus to the parent
   */
  void closeAllChildren(bool pFocus) {
    if (_shownChildMenu != null) {
      // Hide any open submenus of this item
      _shownChildMenu._onHide(pFocus);
      _shownChildMenu = null;
      selectItem(null);
    }
    // Close the current popup
    if (_popup != null) {
      _popup.hide();
    }
    // If focus is true, set focus to parentMenu
    if (pFocus && _parentMenu != null) {
      _parentMenu.focus();
    }
  }

  /**
   * Give this MenuBar focus.
   */
  void focus() {
    FocusPanel.impl.focus(getElement());
  }

  /**
   * Gets whether this menu bar's child menus will open when the mouse is moved
   * over it.
   *
   * @return <code>true</code> if child menus will auto-open
   */
  bool getAutoOpen() {
    return _autoOpen;
  }

  /**
   * Get the index of a {@link MenuItem}.
   *
   * @return the index of the item, or -1 if it is not contained by this MenuBar
   */
  int getItemIndex(MenuItem item) {
    return _allItems.indexOf(item);
  }

  /**
   * Get the index of a {@link MenuItemSeparator}.
   *
   * @return the index of the separator, or -1 if it is not contained by this
   *         MenuBar
   */
  int getSeparatorIndex(MenuItemSeparator item) {
    return _allItems.indexOf(item);
  }

  /**
   * Adds a menu item to the bar at a specific index.
   *
   * @param item the item to be inserted
   * @param beforeIndex the index where the item should be inserted
   * @return the {@link MenuItem} object
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  MenuItem insertItem(MenuItem item, int beforeIndex) {
    // Check the bounds
    if (beforeIndex < 0 || beforeIndex > _allItems.length) {
      throw new Exception("IndexOutOfBounds");
    }

    // Add to the list of items
//    _allItems.insertRange(beforeIndex, 1, item);
    _allItems.insert(beforeIndex, item);
    int itemsIndex = 0;
    for (int i = 0; i < beforeIndex; i++) {
      if (_allItems[i] is MenuItem) {
        itemsIndex++;
      }
    }
//    _items.insertRange(itemsIndex, 1, item);
    _items.insert(itemsIndex, item);

    // Setup the menu item
    _addItemElement(beforeIndex, item.getElement());
    item.setParentMenu(this);
    item.setSelectionStyle(false);
    updateSubmenuIcon(item);
    return item;
  }

  /**
   * Adds a thin line to the {@link MenuBar} to separate sections of
   * {@link MenuItem}s at the specified index.
   *
   * @param separator the {@link MenuItemSeparator} to be inserted
   * @param beforeIndex the index where the separator should be inserted
   * @return the {@link MenuItemSeparator} object
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  MenuItemSeparator insertSeparator(int beforeIndex, [MenuItemSeparator separator = null]) {
    // Check the bounds
    if (beforeIndex < 0 || beforeIndex > _allItems.length) {
      throw new Exception("IndexOutOfBounds");
    }

    if (separator == null) {
      separator = new MenuItemSeparator();
    }

    if (_vertical) {
      _setItemColSpan(separator, 2);
    }
    _addItemElement(beforeIndex, separator.getElement());
    separator.setParentMenu(this);
//    _allItems.insertRange(beforeIndex, 1, separator);
    _allItems.insert(beforeIndex, separator);
    return separator;
  }


  bool isAnimationEnabled() {
    return _isAnimationEnabled;
  }

  /**
   * Check whether or not this widget will steal keyboard focus when the mouse
   * hovers over it.
   *
   * @return true if enabled, false if disabled
   */
  bool isFocusOnHoverEnabled() {
    return _focusOnHover;
  }

  /**
   * Moves the menu selection down to the next item. If there is no selection,
   * selects the first item. If there are no items at all, does nothing.
   */
  void moveSelectionDown() {
    if (_selectFirstItemIfNoneSelected()) {
      return;
    }

    if (_vertical) {
      _selectNextItem();
    } else {
      if (_selectedItem.getSubMenu() != null
          && !_selectedItem.getSubMenu().getItems().isEmpty
          && (_shownChildMenu == null || _shownChildMenu.getSelectedItem() == null)) {
        if (_shownChildMenu == null) {
          doItemAction(_selectedItem, false, true);
        }
        _selectedItem.getSubMenu().focus();
      } else if (_parentMenu != null) {
        if (_parentMenu._vertical) {
          _parentMenu._selectNextItem();
        } else {
          _parentMenu.moveSelectionDown();
        }
      }
    }
  }

  /**
   * Moves the menu selection up to the previous item. If there is no selection,
   * selects the first item. If there are no items at all, does nothing.
   */
  void moveSelectionUp() {
    if (_selectFirstItemIfNoneSelected()) {
      return;
    }

    if ((_shownChildMenu == null) && _vertical) {
      _selectPrevItem();
    } else if ((_parentMenu != null) && _parentMenu._vertical) {
      _parentMenu._selectPrevItem();
    } else {
      _close(true);
    }
  }


  void onBrowserEvent(dart_html.Event event) {
    MenuItem item = _findItem(event.target);
    switch (Dom.eventGetType(event)) {
      case IEvent.ONCLICK:
        FocusPanel.impl.focus(getElement());
        // Fire an item's command when the user clicks on it.
        if (item != null) {
          doItemAction(item, true, true);
        }
        break;

      case IEvent.ONMOUSEOVER:
        if (item != null) {
          itemOver(item, true);
        }
        break;

      case IEvent.ONMOUSEOUT:
        if (item != null) {
          itemOver(null, true);
        }
        break;

      case IEvent.ONFOCUS:
        _selectFirstItemIfNoneSelected();
        break;

      case IEvent.ONKEYDOWN:
        dart_html.KeyboardEvent kEvent = event as dart_html.KeyboardEvent;
        int keyCode = kEvent.keyCode;
        switch (keyCode) {
          case KeyCodes.KEY_LEFT:
            if (LocaleInfo.getCurrentLocale().isRTL()) {
              _moveToNextItem();
            } else {
              _moveToPrevItem();
            }
            _eatEvent(event);
            break;
          case KeyCodes.KEY_RIGHT:
            if (LocaleInfo.getCurrentLocale().isRTL()) {
              _moveToPrevItem();
            } else {
              _moveToNextItem();
            }
            _eatEvent(event);
            break;
          case KeyCodes.KEY_UP:
            moveSelectionUp();
            _eatEvent(event);
            break;
          case KeyCodes.KEY_DOWN:
            moveSelectionDown();
            _eatEvent(event);
            break;
          case KeyCodes.KEY_ESCAPE:
            closeAllParentsAndChildren();
            _eatEvent(event);
            break;
          case KeyCodes.KEY_TAB:
            closeAllParentsAndChildren();
            break;
          case KeyCodes.KEY_ENTER:
            if (!_selectFirstItemIfNoneSelected()) {
              doItemAction(_selectedItem, true, true);
              _eatEvent(event);
            }
            break;
        } // end switch(keyCode)

        break;
    } // end switch (Dom.eventGetType(event))
    super.onBrowserEvent(event);
  }

  /**
   * Closes the menu bar.
   *
   * @deprecated Use {@link #addCloseHandler(CloseHandler)} instead
   */
//
//  @Deprecated
//  void onPopupClosed(PopupPanel sender, bool autoClosed) {
//    // If the menu popup was auto-closed, close all of its parents as well.
//    if (autoClosed) {
//      closeAllParents();
//    }
//
//    // When the menu popup closes, remember that no item is
//    // currently showing a popup menu.
//    onHide(!autoClosed);
//    CloseEvent.fire(MenuBar.this, sender);
//    shownChildMenu = null;
//    popup = null;
//    if (parentMenu != null && parentMenu.popup != null) {
//      parentMenu.popup.setPreviewingAllNativeEvents(true);
//    }
//  }

  /**
   * Removes the specified menu item from the bar.
   *
   * @param item the item to be removed
   */
  void removeItem(MenuItem item) {
    // Unselect if the item is currently selected
    if (_selectedItem == item) {
      selectItem(null);
    }

    if (_removeItemElement(item)) {
      _setItemColSpan(item, 1);
      _items.remove(item);
      item.setParentMenu(null);
    }
  }

  /**
   * Removes the specified {@link MenuItemSeparator} from the bar.
   *
   * @param separator the separator to be removed
   */
  void removeSeparator(MenuItemSeparator separator) {
    if (_removeItemElement(separator)) {
      separator.setParentMenu(null);
    }
  }

  /**
   * Select the given MenuItem, which must be a direct child of this MenuBar.
   *
   * @param item the MenuItem to select, or null to clear selection
   */
  void selectItem(MenuItem item) {
    assert (item == null || item.getParentMenu() == this);

    if (item == _selectedItem) {
      return;
    }

    if (_selectedItem != null) {
      _selectedItem.setSelectionStyle(false);
      // Set the style of the submenu indicator
      if (_vertical) {
        dart_html.Element tr = _selectedItem.getElement().parent;
        if (Dom.getChildCount(tr) == 2) {
          dart_html.Element td = Dom.getChild(tr, 1);
          UiObject.manageElementStyleName(td, "subMenuIcon-selected", false);
        }
      }
    }

    if (item != null) {
      item.setSelectionStyle(true);

      // Set the style of the submenu indicator
      if (_vertical) {
        dart_html.Element tr = item.getElement().parent;
        if (tr.children.length == 2) {
          dart_html.Element td = tr.children[1];
          UiObject.manageElementStyleName(td, "subMenuIcon-selected", true);
        }
      }

//      Roles.getMenubarRole().setAriaActivedescendantProperty(getElement(),
//          IdReference.of(Dom.getElementAttribute(item.getElement(), "id")));
    }

    _selectedItem = item;
  }


  void setAnimationEnabled(bool enable) {
    _isAnimationEnabled = enable;
  }

  /**
   * Sets whether this menu bar's child menus will open when the mouse is moved
   * over it.
   *
   * @param autoOpen <code>true</code> to cause child menus to auto-open
   */
  void setAutoOpen(bool autoOpen) {
    this._autoOpen = autoOpen;
  }

  /**
   * Enable or disable auto focus when the mouse hovers over the MenuBar. This
   * allows the MenuBar to respond to keyboard events without the user having to
   * click on it, but it will steal focus from other elements on the page.
   * Enabled by default.
   *
   * @param enabled true to enable, false to disable
   */
  void setFocusOnHoverEnabled(bool enabled) {
    _focusOnHover = enabled;
  }

  /**
   * Returns a list containing the <code>MenuItem</code> objects in the menu
   * bar. If there are no items in the menu bar, then an empty <code>List</code>
   * object will be returned.
   *
   * @return a list containing the <code>MenuItem</code> objects in the menu bar
   */
  List<MenuItem> getItems() {
    return this._items;
  }

  /**
   * Returns the <code>MenuItem</code> that is currently selected (highlighted)
   * by the user. If none of the items in the menu are currently selected, then
   * <code>null</code> will be returned.
   *
   * @return the <code>MenuItem</code> that is currently selected, or
   *         <code>null</code> if no items are currently selected
   */
  MenuItem getSelectedItem() {
    return this._selectedItem;
  }


  void onDetach() {
    // When the menu is detached, make sure to close all of its children.
    if (_popup != null) {
      _popup.hide();
    }

    super.onDetach();
  }

  /*
   * Closes all parent menu popups.
   */
  void closeAllParents() {
    if (_parentMenu != null) {
      // The parent menu will recursively call closeAllParents.
      _close(false);
    } else {
      // If this is the top most menu, deselect the current item.
      selectItem(null);
    }
  }

  /**
   * Closes all parent and child menu popups.
   */
  void closeAllParentsAndChildren() {
    closeAllParents();
    // Ensure the popup is closed even if it has not been enetered
    // with the mouse or key navigation
    if (_parentMenu == null && _popup != null) {
      _popup.hide();
    }
  }

  /*
   * Performs the action associated with the given menu item. If the item has a
   * popup associated with it, the popup will be shown. If it has a command
   * associated with it, and 'fireCommand' is true, then the command will be
   * fired. Popups associated with other items will be hidden.
   *
   * @param item the item whose popup is to be shown. @param fireCommand
   * <code>true</code> if the item's command should be fired, <code>false</code>
   * otherwise.
   */
  void doItemAction(final MenuItem item, bool fireCommand, bool pFocus) {
    // Should not perform any action if the item is disabled
    if (!item.enabled) {
      return;
    }

    // Ensure that the item is selected.
    selectItem(item);

    // if the command should be fired and the item has one, fire it
    if (fireCommand && item.getScheduledCommand() != null) {
      // Close this menu and all of its parents.
      closeAllParents();

      // Fire the item's command. The command must be fired in the same event
      // loop or popup blockers will prevent popups from opening.
      ScheduledCommand cmd = item.getScheduledCommand();
      Scheduler.get().scheduleDeferred(new _MenuScheduledCommand(cmd));

      // hide any open submenus of this item
      if (_shownChildMenu != null) {
        _shownChildMenu._onHide(pFocus);
        _popup.hide();
        _shownChildMenu = null;
        selectItem(null);
      }
    } else if (item.getSubMenu() != null) {
      if (_shownChildMenu == null) {
        // open this submenu
        _openPopup(item);
      } else if (item.getSubMenu() != _shownChildMenu) {
        // close the other submenu and open this one
        _shownChildMenu._onHide(pFocus);
        _popup.hide();
        _openPopup(item);
      } else if (fireCommand && !_autoOpen) {
        // close this submenu
        _shownChildMenu._onHide(pFocus);
        _popup.hide();
        _shownChildMenu = null;
        selectItem(item);
      }
    } else if (_autoOpen && _shownChildMenu != null) {
      // close submenu
      _shownChildMenu._onHide(pFocus);
      _popup.hide();
      _shownChildMenu = null;
    }
  }

  /**
   * Visible for testing.
   */
  PopupPanel getPopup() {
    return _popup;
  }

  void itemOver(MenuItem item, bool pFocus) {
    if (item == null) {
      // Don't clear selection if the currently selected item's menu is showing.
      if ((_selectedItem != null)
          && (_shownChildMenu == _selectedItem.getSubMenu())) {
        return;
      }
    }

    if (item != null && !item.enabled) {
      return;
    }

    // Style the item selected when the mouse enters.
    selectItem(item);
    if (pFocus && _focusOnHover) {
      focus();
    }

    // If child menus are being shown, or this menu is itself
    // a child menu, automatically show an item's child menu
    // when the mouse enters.
    if (item != null) {
      if ((_shownChildMenu != null) || (_parentMenu != null) || _autoOpen) {
        doItemAction(item, false, _focusOnHover);
      }
    }
  }

//  /**
//   * Set the IDs of the menu items.
//   *
//   * @param baseID the base ID
//   */
//  void setMenuItemDebugIds(String baseID) {
//    int itemCount = 0;
//    for (MenuItem item in _items) {
//      item.ensureDebugId(baseID + "-item" + itemCount);
//      itemCount++;
//    }
//  }

  /**
   * Show or hide the icon used for items with a submenu.
   *
   * @param item the item with or without a submenu
   */
  void updateSubmenuIcon(MenuItem item) {
    // The submenu icon only applies to vertical menus
    if (!_vertical) {
      return;
    }

    // Get the index of the MenuItem
    int idx = _allItems.indexOf(item);
    if (idx == -1) {
      return;
    }

    dart_html.Element container = _getItemContainerElement();
    dart_html.Element tr = Dom.getChild(container, idx);
    int tdCount = Dom.getChildCount(tr);
    MenuBar submenu = item.getSubMenu();
    if (submenu == null) {
      // Remove the submenu indicator
      if (tdCount == 2) {
        //Dom.removeChild(tr, Dom.getChild(tr, 1));
        Dom.getChild(tr, 1).remove();
      }
      _setItemColSpan(item, 2);
    } else if (tdCount == 1) {
      // Show the submenu indicator
      _setItemColSpan(item, 1);
      dart_html.Element td = new dart_html.TableCellElement();
      td.style.verticalAlign = "middle";
      td.append(_subMenuIcon.createElement());
      UiObject.setElementStyleName(td, "subMenuIcon");
      tr.append(td);
    }
  }

  /**
   * Physically add the td element of a {@link MenuItem} or
   * {@link MenuItemSeparator} to this {@link MenuBar}.
   *
   * @param beforeIndex the index where the separator should be inserted
   * @param tdElem the td element to be added
   */
  void _addItemElement(int beforeIndex, dart_html.Element tdElem) {
    if (_vertical) {
      dart_html.Element tr = new dart_html.TableRowElement();
      Dom.insertChild(_body, tr, beforeIndex);
      tr.append(tdElem);
    } else {
      dart_html.Element tr = Dom.getChild(_body, 0);
      Dom.insertChild(tr, tdElem, beforeIndex);
    }
  }

  /**
   * Closes this menu (if it is a popup).
   *
   * @param focus true to move focus to the parent
   */
  void _close(bool focus) {
    if (_parentMenu != null) {
      _parentMenu._popup.hide(!focus);
      if (focus) {
        _parentMenu.focus();
      }
    }
  }

  void _eatEvent(dart_html.Event event) {
//    event.cancelBubble = true;
    event.preventDefault();
  }

  MenuItem _findItem(dart_html.Element hItem) {
    for (MenuItem item in _items) {
      if (Dom.isOrHasChild(item.getElement(), hItem)) {
        return item;
      }
    }
    return null;
  }

  dart_html.Element _getItemContainerElement() {
    if (_vertical) {
      return _body;
    } else {
      return Dom.getChild(_body, 0);
    }
  }

  void _init(bool vertical, AbstractImagePrototype subMenuIcon) {
    this._subMenuIcon = subMenuIcon;

    dart_html.TableElement table = new dart_html.TableElement();
    _body = table.createTBody();
    table.append(_body);

    if (!vertical) {
      dart_html.Element tr = new dart_html.TableRowElement();
      _body.append(tr);
    }

    this._vertical = vertical;

    dart_html.Element outer = FocusPanel.impl.createFocusable();
    outer.append(table);
    setElement(outer);

    //Roles.getMenubarRole().set(getElement());

    sinkEvents(IEvent.ONCLICK | IEvent.ONMOUSEOVER | IEvent.ONMOUSEOUT
        | IEvent.ONFOCUS | IEvent.ONKEYDOWN);

    clearAndSetStyleName(_STYLENAME_DEFAULT);
    if (_vertical) {
      addStyleDependentName("vertical");
    } else {
      addStyleDependentName("horizontal");
    }

    // Hide focus outline in Mozilla/Webkit/Opera
    Dom.setStyleAttribute(getElement(), "outline", "0px");

    // Hide focus outline in IE 6/7
    Dom.setElementAttribute(getElement(), "hideFocus", "true");

    // Deselect items when blurring without a child menu.
    addDomHandler(new BlurHandlerAdapter((BlurEvent evt) {
      if (_shownChildMenu == null) {
        selectItem(null);
      }
    }), BlurEvent.TYPE);
  }

  void _moveToNextItem() {
    if (_selectFirstItemIfNoneSelected()) {
      return;
    }

    if (!_vertical) {
      _selectNextItem();
    } else {
      if (_selectedItem.getSubMenu() != null
          && !_selectedItem.getSubMenu().getItems().isEmpty
          && (_shownChildMenu == null || _shownChildMenu.getSelectedItem() == null)) {
        if (_shownChildMenu == null) {
          doItemAction(_selectedItem, false, true);
        }
        _selectedItem.getSubMenu().focus();
      } else if (_parentMenu != null) {
        if (!_parentMenu._vertical) {
          _parentMenu._selectNextItem();
        } else {
          _parentMenu._moveToNextItem();
        }
      }
    }
  }

  void _moveToPrevItem() {
    if (_selectFirstItemIfNoneSelected()) {
      return;
    }

    if (!_vertical) {
      _selectPrevItem();
    } else {
      if ((_parentMenu != null) && (!_parentMenu._vertical)) {
        _parentMenu._selectPrevItem();
      } else {
        _close(true);
      }
    }
  }

  /*
   * This method is called when a menu bar is hidden, so that it can hide any
   * child popups that are currently being shown.
   */
  void _onHide(bool pFocus) {
    if (_shownChildMenu != null) {
      _shownChildMenu._onHide(pFocus);
      _popup.hide();
      if (pFocus) {
        focus();
      }
    }
  }

  /*
   * This method is called when a menu bar is shown.
   */
  void _onShow() {
    // clear the selection; a keyboard user can cursor down to the first item
    selectItem(null);
  }

  void _openPopup(MenuItem item) {
    // Only the last popup to be opened should preview all event
    if (_parentMenu != null && _parentMenu._popup != null) {
      _parentMenu._popup.setPreviewingAllNativeEvents(false);
    }

    // Create a new popup for this item, and position it next to
    // the item (below if this is a horizontal menu bar, to the
    // right if it's a vertical bar).
    _popup = new _MenuDecoratedPopupPanel(this, item, true, false, "menuPopup");
    _popup.setAnimationType(AnimationType.ONE_WAY_CORNER);
    _popup.setAnimationEnabled(_isAnimationEnabled);
    _popup.clearAndSetStyleName(_STYLENAME_DEFAULT + "Popup");
    String primaryStyleName = getStylePrimaryName();
    if (_STYLENAME_DEFAULT != primaryStyleName) {
      _popup.addStyleName(primaryStyleName + "Popup");
    }
    //_popup.addPopupListener(this);
    // Closes the menu bar.
    _popup.addCloseHandler(new CloseHandlerAdapter((CloseEvent evt){
        // If the menu popup was auto-closed, close all of its parents as well.
        if (evt.autoClosed) {
          closeAllParents();
        }

        // When the menu popup closes, remember that no item is
        // currently showing a popup menu.
        _onHide(!evt.autoClosed);
        CloseEvent.fire(this, evt.target);
        _shownChildMenu = null;
        _popup = null;
        if (_parentMenu != null && _parentMenu._popup != null) {
          _parentMenu._popup.setPreviewingAllNativeEvents(true);
        }
    }));

    _shownChildMenu = item.getSubMenu();
    item.getSubMenu()._parentMenu = this;

    // Show the popup, ensuring that the menubar's event preview remains on top
    // of the popup's.
    _popup.setPopupPositionAndShow(new _PopupPanelPositionCallback(this, item));

    // Add sub menu into parent menu as AutoHidePartner to fix problem
    // with doesn't react second level of menu
    if (_parentMenu != null) {
      _parentMenu._popup.addAutoHidePartner(_popup.getElement());
    }
  }

  /**
   * Removes the specified item from the {@link MenuBar} and the physical Dom
   * structure.
   *
   * @param item the item to be removed
   * @return true if the item was removed
   */
  bool _removeItemElement(UiObject item) {
    int idx = _allItems.indexOf(item);
    if (idx == -1) {
      return false;
    }

    dart_html.Element container = _getItemContainerElement();
    //Dom.removeChild(container, Dom.getChild(container, idx));
    Dom.getChild(container, idx).remove();
    _allItems.remove(idx);
    return true;
  }

  /**
   * Selects the first item in the menu if no items are currently selected. Has
   * no effect if there are no items.
   *
   * @return true if no item was previously selected, false otherwise
   */
  bool _selectFirstItemIfNoneSelected() {
    if (_selectedItem == null) {
      for (MenuItem nextItem in _items) {
        if (nextItem.enabled) {
          selectItem(nextItem);
          break;
        }
      }
      return true;
    }
    return false;
 }

  void _selectNextItem() {
    if (_selectedItem == null) {
      return;
    }

    int index = _items.indexOf(_selectedItem);
    // We know that selectedItem is set to an item that is contained in the
    // items collection.
    // Therefore, we know that index can never be -1.
    assert (index != -1);

    MenuItem itemToBeSelected;

    int firstIndex = index;
    while (true) {
      index = index + 1;
      if (index == _items.length) {
        // we're at the end, loop around to the start
        index = 0;
      }
      if (index == firstIndex) {
        itemToBeSelected = _items[firstIndex];
        break;
      } else {
        itemToBeSelected = _items[index];
        if (itemToBeSelected.enabled) {
          break;
        }
      }
    }

    selectItem(itemToBeSelected);
    if (_shownChildMenu != null) {
      doItemAction(itemToBeSelected, false, true);
    }
  }

  void _selectPrevItem() {
    if (_selectedItem == null) {
      return;
    }

    int index = _items.indexOf(_selectedItem);
    // We know that selectedItem is set to an item that is contained in the
    // items collection.
    // Therefore, we know that index can never be -1.
    assert (index != -1);

    MenuItem itemToBeSelected;

    int firstIndex = index;
    while (true) {
      index = index - 1;
      if (index < 0) {
        // we're at the start, loop around to the end
        index = _items.length - 1;
      }
      if (index == firstIndex) {
        itemToBeSelected = _items[firstIndex];
        break;
      } else {
        itemToBeSelected = _items[index];
        if (itemToBeSelected.enabled) {
          break;
        }
      }
    }

    selectItem(itemToBeSelected);
    if (_shownChildMenu != null) {
      doItemAction(itemToBeSelected, false, true);
    }
  }

  /**
   * Set the colspan of a {@link MenuItem} or {@link MenuItemSeparator}.
   *
   * @param item the {@link MenuItem} or {@link MenuItemSeparator}
   * @param colspan the colspan
   */
  void _setItemColSpan(UiObject item, int colspan) {
    Dom.setElementPropertyInt(item.getElement(), "colSpan", colspan);
  }
}

/**
 * A ClientBundle that contains the default resources for this widget.
 */
abstract class MenuResource extends ClientBundle {
  /**
   * An image indicating a {@link MenuItem} has an associated submenu.
   */
//  @ImageOptions(flipRtl = true)
  ImageResource menuBarSubMenuIcon();
}

/**
 * Default menu resources.
 */
class MenuResources implements MenuResource {

  ImageResource _resource;

  static const String MENU_RESOURCE = "menuBarSubMenuIcon.gif";
  static const String MENU_RESOURCE_RTL = "menuBarSubMenuIcon_rtl.gif";

  MenuResources();

  Source get source {
    return null;
  }

  /**
   * An image indicating a {@link MenuItem} has an associated submenu.
   */
  ImageResource menuBarSubMenuIcon() {
    if (_resource == null) {
      // We must check is left or right based locales we using here.
      _resource = _getMenuImageResourcePrototype(MENU_RESOURCE);
    }
    return _resource;
  }

  ImageResourcePrototype _getMenuImageResourcePrototype(String name) {
    String uri = DWT.getModuleBaseURL() + "resource/images/" + name;
    ImageResourcePrototype imageResource = new ImageResourcePrototype(name, 
        UriUtils.fromTrustedString(uri), 0, 0, 5, 9, false, false);
    return imageResource;
  }
}

class _MenuDecoratedPopupPanel extends DecoratedPopupPanel {

  MenuBar menuBar;
  MenuItem item;

  _MenuDecoratedPopupPanel(this.menuBar, this.item, [bool autoHide = false, bool modal = false, String prefix = "popup"]) : super(autoHide, modal, prefix) {
    setWidget(item.getSubMenu());
    setPreviewingAllNativeEvents(true);
    item.getSubMenu()._onShow();
  }


  void onPreviewNativeEvent(NativePreviewEvent event) {
    // Hook the popup panel's event preview. We use this to keep it from
    // auto-hiding when the parent menu is clicked.
    if (!event.isCanceled()) {

      switch (IEvent.getTypeInt(event.getNativeEvent().type)) {
        case IEvent.ONMOUSEDOWN:
          // If the event target is part of the parent menu, suppress the
          // event altogether.
          dart_html.EventTarget target = event.getNativeEvent().target;
          dart_html.Element parentMenuElement = item.getParentMenu().getElement();
          if (Dom.isOrHasChild(parentMenuElement, target as dart_html.Element)) {
            event.cancel();
            return;
          }
          super.onPreviewNativeEvent(event);
          if (event.isCanceled()) {
            menuBar.selectItem(null);
          }
          return;
      }
    }
    super.onPreviewNativeEvent(event);
  }
}

class _PopupPanelPositionCallback extends PopupPanelPositionCallback {

  MenuBar menuBar;
  MenuItem item;

  _PopupPanelPositionCallback(this.menuBar, this.item);

  void setPosition(int offsetWidth, int offsetHeight) {
    // depending on the bidi direction position a menu on the left or right
    // of its base item
    if (LocaleInfo.getCurrentLocale().isRTL()) {
      if (menuBar._vertical) {
        menuBar._popup.setPopupPosition(menuBar.getAbsoluteLeft() - offsetWidth + 1, item.getAbsoluteTop());
      } else {
        menuBar._popup.setPopupPosition(item.getAbsoluteLeft() + item.getOffsetWidth() - offsetWidth, menuBar.getAbsoluteTop() + menuBar.getOffsetHeight() - 1);
      }
    } else {
      if (menuBar._vertical) {
        menuBar._popup.setPopupPosition(menuBar.getAbsoluteLeft() + menuBar.getOffsetWidth() - 1, item.getAbsoluteTop());
      } else {
        menuBar._popup.setPopupPosition(item.getAbsoluteLeft(), menuBar.getAbsoluteTop() + menuBar.getOffsetHeight() - 1);
      }
    }
  }
}

class _MenuScheduledCommand extends ScheduledCommand {

  ScheduledCommand _cmd;

  _MenuScheduledCommand(this._cmd);

  /**
   * Invokes the command.
   */
  void execute() {
    _cmd.execute();
  }
}