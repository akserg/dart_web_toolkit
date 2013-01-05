//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A horizontal bar of folder-style tabs, most commonly used as part of a
 * {@link com.google.dwt.user.client.ui.TabPanel}.
 * <p>
 * <img class='gallery' src='doc-files/TabBar.png'/>
 * </p>
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.dwt-TabBar { the tab bar itself }</li>
 * <li>.dwt-TabBar .dwt-TabBarFirst { the left edge of the bar }</li>
 * <li>.dwt-TabBar .dwt-TabBarFirst-wrapper { table cell around the left edge }
 * </li>
 * <li>.dwt-TabBar .dwt-TabBarRest { the right edge of the bar }</li>
 * <li>.dwt-TabBar .dwt-TabBarRest-wrapper { table cell around the right edge }
 * </li>
 * <li>.dwt-TabBar .dwt-TabBarItem { unselected tabs }</li>
 * <li>.dwt-TabBar .dwt-TabBarItem-wrapper { table cell around tab }</li>
 * <li>.dwt-TabBar .dwt-TabBarItem-selected { additional style for selected
 * <p>
 * <h3>Example</h3>
 * {@example com.google.dwt.examples.TabBarExample}
 * </p>
 */
class TabBar extends Composite implements /*SourcesTabEvents,*/
  HasBeforeSelectionHandlers<int>, HasSelectionHandlers<int>/*,
  ClickListener, KeyboardListener*/ {
  
    static final String STYLENAME_DEFAULT = "dwt-TabBarItem";
    HorizontalPanel panel = new HorizontalPanel();
    Widget selectedTab;
    
    /**
     * Creates an empty tab bar.
     */
    TabBar() {
      initWidget(panel);
//      sinkEvents(Event.ONCLICK);
      clearAndSetStyleName("dwt-TabBar");

      // Add a11y role "tablist"
      //Roles.getTablistRole().set(panel.getElement());

      panel.setVerticalAlignment(HasVerticalAlignment.ALIGN_BOTTOM);

      Html first = new Html("&nbsp;", true); 
      Html rest = new Html("&nbsp;", true);
      first.clearAndSetStyleName("dwt-TabBarFirst");
      rest.clearAndSetStyleName("dwt-TabBarRest");
      first.setHeight("100%");
      rest.setHeight("100%");

      panel.add(first);
      panel.add(rest);
      first.setHeight("100%");
      panel.setWidgetCellHeight(first, "100%");
      panel.setWidgetCellWidth(rest, "100%");
      UiObject.setElementStyleName(first.getElement().parent, "dwt-TabBarFirst-wrapper");
      UiObject.setElementStyleName(rest.getElement().parent, "dwt-TabBarRest-wrapper");
    }

    
    HandlerRegistration addBeforeSelectionHandler(BeforeSelectionHandler<int> handler) {
      return addHandler(handler, BeforeSelectionEvent.TYPE);
    }

    
    HandlerRegistration addSelectionHandler(SelectionHandler<int> handler) {
      return addHandler(handler, SelectionEvent.TYPE);
    }

//    /**
//     * Adds a new tab with the specified text.
//    *
//     * @param html the new tab's html
//     */
//    void addTab(SafeHtml html) {
//      addTab(html.asString(), true);
//    }

//    /**
//     * Adds a new tab with the specified text.
//    *
//     * @param text the new tab's text
//     */
//    void addTab(String text) {
//      insertTab(text, getTabCount());
//    }

    /**
     * Adds a new tab with the specified text.
    *
     * @param text the new tab's text
     * @param asHtml <code>true</code> to treat the specified text as html
     */
    void addTabText(String text, [bool asHtml = false]) {
      insertTabText(text, getTabCount(), asHtml);
    }

    /**
     * Adds a new tab with the specified widget.
    *
     * @param widget the new tab's widget
     */
    void addTabWidget(Widget widget) {
      insertTabWidget(widget, getTabCount());
    }

//    /**
//     * @deprecated Use {@link #addBeforeSelectionHandler(BeforeSelectionHandler)}
//     * and {@link #addSelectionHandler(SelectionHandler)} instead
//     */
//    @Deprecated
//    void addTabListener(TabListener listener) {
//      ListenerWrapper.WrappedTabListener.add(this, listener);
//    }

    /**
     * Gets the tab that is currently selected.
    *
     * @return the selected tab
     */
    int getSelectedTab() {
      if (selectedTab == null) {
        return -1;
      }
      return panel.getWidgetIndex(selectedTab) - 1;
    }

    /**
     * Gets the given tab.
    *
     * This method is final because the Tab interface will expand. Therefore
     * it is highly likely that subclasses which implemented this method would end up
     * breaking.
    *
     * @param index the tab's index
     * @return the tab wrapper
     */
    Tab getTab(int index) {
      if (index >= getTabCount()) {
        return null;
      }
      _ClickDelegatePanel p = panel.getWidget(index + 1) as _ClickDelegatePanel;
      return p;
    }

    /**
     * Gets the number of tabs present.
    *
     * @return the tab count
     */
    int getTabCount() {
      return panel.getWidgetCount() - 2;
    }

    /**
     * Gets the specified tab's Html.
    *
     * @param index the index of the tab whose Html is to be retrieved
     * @return the tab's Html
     */
    String getTabHTML(int index) {
      if (index >= getTabCount()) {
        return null;
      }
      _ClickDelegatePanel delPanel = panel.getWidget(index + 1) as _ClickDelegatePanel;
      SimplePanel focusablePanel = delPanel.getFocusablePanel();
      Widget widget = focusablePanel.getWidget();
      if (widget is Html) {
        return (widget as Html).html;
      } else if (widget is Label) {
        return (widget as Label).text;
      } else {
        // This will be a focusable panel holding a user-supplied widget.
        return focusablePanel.getElement().getParentElement().innerHtml;
      }
    }

    /**
     * Inserts a new tab at the specified index.
    *
     * @param html the new tab's html
     * @param beforeIndex the index before which this tab will be inserted
     */
//    void insertTab(SafeHtml html, int beforeIndex) {
//      insertTab(html.asString(), true, beforeIndex);
//    }

    /**
     * Inserts a new tab at the specified index.
    *
     * @param text the new tab's text
     * @param asHtml <code>true</code> to treat the specified text as Html
     * @param beforeIndex the index before which this tab will be inserted
     */
    void insertTabText(String text, int beforeIndex, [bool asHtml = false]) {
      checkInsertBeforeTabIndex(beforeIndex);

      Label item;
      if (asHtml) {
        item = new Html(text);
      } else {
        item = new Label(text);
      }

      item.wordWrap = false;
      _insertTabWidget(item, beforeIndex);
    }

//    /**
//     * Inserts a new tab at the specified index.
//    *
//     * @param text the new tab's text
//     * @param beforeIndex the index before which this tab will be inserted
//     */
//    void insertTab(String text, int beforeIndex) {
//      insertTab(text, false, beforeIndex);
//    }

    /**
     * Inserts a new tab at the specified index.
    *
     * @param widget widget to be used in the new tab
     * @param beforeIndex the index before which this tab will be inserted
     */
    void insertTabWidget(Widget widget, int beforeIndex) {
      _insertTabWidget(widget, beforeIndex);
    }

    /**
     * Check if a tab is enabled or disabled. If disabled, the user cannot select
     * the tab.
    *
     * @param index the index of the tab
     * @return true if the tab is enabled, false if disabled
     */
    bool isTabEnabled(int index) {
      assert ((index >= 0) && (index < getTabCount())); // : "Tab index out of bounds";
      _ClickDelegatePanel delPanel = panel.getWidget(index + 1) as _ClickDelegatePanel;
      return delPanel.enabled;
    }

//    /**
//     * @deprecated add a {@link BeforeSelectionHandler} instead. Alternatively, if
//     * you need to access to the individual tabs, add a click handler to each
//     * {@link Tab} element instead.
//     */
//    
//    @Deprecated
//    void onClick(Widget sender) {
//    }
//
//    /**
//     * @deprecated add a key down handler to the individual {@link Tab} objects
//     *  instead.
//     */
//    
//    @Deprecated
//    void onKeyDown(Widget sender, char keyCode, int modifiers) {
//    }
//
//    /**
//     * @deprecated this method has been doing nothing for the entire last release,
//     * if what you wanted to do was to listen to key press events on tabs, add the
//     * key press handler to the individual tab wrappers instead.
//     */
//    
//    @Deprecated
//    void onKeyPress(Widget sender, char keyCode, int modifiers) {
//    }
//
//    /**
//     * @deprecated this method has been doing nothing for the entire last release,
//     * if what you wanted to do was to listen to key up events on tabs, add the
//     * key up handler to the individual tab wrappers instead.
//    *
//     */
//    
//    @Deprecated
//    void onKeyUp(Widget sender, char keyCode, int modifiers) {
//    }

    /**
     * Removes the tab at the specified index.
    *
     * @param index the index of the tab to be removed
     */
    void removeTab(int index) {
      checkTabIndex(index);

      // (index + 1) to account for 'first' placeholder widget.
      Widget toRemove = panel.getWidget(index + 1);
      if (toRemove == selectedTab) {
        selectedTab = null;
      }
      panel.remove(toRemove);
    }

//    /**
//     * @deprecated Instead use the {@link HandlerRegistration#removeHandler}
//     * call on the object returned by an add*Handler method
//     */
//    
//    @Deprecated
//    void removeTabListener(TabListener listener) {
//      ListenerWrapper.WrappedTabListener.remove(this, listener);
//    }

//    /**
//     * Programmatically selects the specified tab and fires events. Use index -1
//     * to specify that no tab should be selected.
//    *
//     * @param index the index of the tab to be selected
//     * @return <code>true</code> if successful, <code>false</code> if the change
//     * is denied by the {@link BeforeSelectionHandler}.
//     */
//    bool selectTab(int index) {
//      return selectTab(index, true);
//    }

    /**
     * Programmatically selects the specified tab. Use index -1 to specify that no
     * tab should be selected.
    *
     * @param index the index of the tab to be selected
     * @param fireEvents true to fire events, false not to
     * @return <code>true</code> if successful, <code>false</code> if the change
     * is denied by the {@link BeforeSelectionHandler}.
     */
    bool selectTab(int index, [bool fireEvents = true]) {
      checkTabIndex(index);

//      if (fireEvents) {
//        BeforeSelectionEvent event = BeforeSelectionEvent.fire(this, index);
//        if (event != null && event.isCanceled()) {
//          return false;
//        }
//      }

      // Check for -1.
      setSelectionStyle(selectedTab, false);
      if (index == -1) {
        selectedTab = null;
        return true;
      }

      selectedTab = panel.getWidget(index + 1);
      setSelectionStyle(selectedTab, true);
      if (fireEvents) {
        SelectionEvent.fire(this, index);
      }
      return true;
    }

    /**
     * Enable or disable a tab. When disabled, users cannot select the tab.
    *
     * @param index the index of the tab to enable or disable
     * @param enabled true to enable, false to disable
     */
    void setTabEnabled(int index, bool enabled) {
      assert ((index >= 0) && (index < getTabCount())); // : "Tab index out of bounds";

      // Style the wrapper
      _ClickDelegatePanel delPanel = panel.getWidget(index + 1) as _ClickDelegatePanel;
      delPanel.setEnabled(enabled);
      manageElementStyleName(delPanel.getElement(), "dwt-TabBarItem-disabled", !enabled);
      manageElementStyleName(delPanel.getElement().getParentElement(), "dwt-TabBarItem-wrapper-disabled", !enabled);
    }

    /**
     * Sets a tab's contents via Html.
    *
     * Use care when setting an object's Html; it is an easy way to expose
     * script-based security problems. Consider using
     * {@link #setTabText(int, String)} or {@link #setTabHTML(int, SafeHtml)}
     * whenever possible.
    *
     * @param index the index of the tab whose Html is to be set
     * @param html the tab new Html
     */
    void setTabHtml(int index, String html) {
      assert ((index >= 0) && (index < getTabCount())); // : "Tab index out of bounds";

      _ClickDelegatePanel delPanel = panel.getWidget(index + 1) as _ClickDelegatePanel;
      SimplePanel focusablePanel = delPanel.getFocusablePanel();
      focusablePanel.setWidget(new Html(html, false));
    }

//    /**
//     * Sets a tab's contents via safe html.
//    *
//     * @param index the index of the tab whose Html is to be set
//     * @param html the tab new Html
//     */
//    void setTabHTML(int index, SafeHtml html) {
//      setTabHTML(index, html.asString());
//    }

    /**
     * Sets a tab's text contents.
    *
     * @param index the index of the tab whose text is to be set
     * @param text the object's new text
     */
    void setTabText(int index, String text) {
      assert ((index >= 0) && (index < getTabCount())); // : "Tab index out of bounds";

      _ClickDelegatePanel delPanel = panel.getWidget(index + 1) as _ClickDelegatePanel;
      SimplePanel focusablePanel = delPanel.getFocusablePanel();

      // It is not safe to check if the current widget is an instanceof Label and
      // reuse it here because Html is an instanceof Label. Leaving an Html would
      // throw off the results of getTabHTML(int).
      focusablePanel.setWidget(new Label(text, false));
    }

    /**
     * Create a {@link SimplePanel} that will wrap the contents in a tab.
     * Subclasses can use this method to wrap tabs in decorator panels.
    *
     * @return a {@link SimplePanel} to wrap the tab contents, or null to leave
     * tabs unwrapped
     */
    SimplePanel createTabTextWrapper() {
      return null;
    }

    /**
     * Inserts a new tab at the specified index.
    *
     * @param widget widget to be used in the new tab
     * @param beforeIndex the index before which this tab will be inserted
     */
    void _insertTabWidget(Widget widget, int beforeIndex) {
      checkInsertBeforeTabIndex(beforeIndex);

      _ClickDelegatePanel delWidget = new _ClickDelegatePanel(this, widget);
      delWidget.clearAndSetStyleName(STYLENAME_DEFAULT);

      // Add a11y role "tab"
      SimplePanel focusablePanel = delWidget.getFocusablePanel();
//      Roles.getTabRole().set(focusablePanel.getElement());

      panel.insertWidget(delWidget, beforeIndex + 1);

      UiObject.manageElementStyleName(delWidget.getElement().parent, STYLENAME_DEFAULT.concat("-wrapper"), true);
    }

    /**
     * <b>Affected Elements:</b>
     * <ul>
     * <li>-tab# = The element containing the contents of the tab.</li>
     * <li>-tab-wrapper# = The cell containing the tab at the index.</li>
     * </ul>
    *
     * @see UIObject#onEnsureDebugId(String)
     */
    
    void onEnsureDebugId(String baseID) {

      int numTabs = getTabCount();
      for (int i = 0; i < numTabs; i++) {
        _ClickDelegatePanel delPanel = panel.getWidget(i + 1) as _ClickDelegatePanel;
        SimplePanel focusablePanel = delPanel.getFocusablePanel();
      }
    }

    void checkInsertBeforeTabIndex(int beforeIndex) {
      if ((beforeIndex < 0) || (beforeIndex > getTabCount())) {
        throw new Exception("IndexOutOfBounds");
      }
    }

    void checkTabIndex(int index) {
      if ((index < -1) || (index >= getTabCount())) {
        throw new Exception("IndexOutOfBounds");
      }
    }

    /**
     * Selects the tab corresponding to the widget for the tab. To be clear the
     * widget for the tab is not the widget INSIDE of the tab; it is the widget
     * used to represent the tab itself.
    *
     * @param tabWidget The widget for the tab to be selected
     * @return true if the tab corresponding to the widget for the tab could
     * located and selected, false otherwise
     */
    bool selectTabByTabWidget(Widget tabWidget) {
      int numTabs = panel.getWidgetCount() - 1;

      for (int i = 1; i < numTabs; ++i) {
        if (panel.getWidget(i) == tabWidget) {
          return selectTab(i - 1);
        }
      }

      return false;
    }

    void setSelectionStyle(Widget item, bool selected) {
      if (item != null) {
        if (selected) {
          item.addStyleName("dwt-TabBarItem-selected");
          UiObject.manageElementStyleName(item.getElement().parent, "dwt-TabBarItem-wrapper-selected", true);
        } else {
          item.removeStyleName("dwt-TabBarItem-selected");
          UiObject.manageElementStyleName(item.getElement().parent, "dwt-TabBarItem-wrapper-selected", false);
        }
      }
    }
}

/**
 * Set of characteristic interfaces supported by {@link TabBar} tabs.
 *
 * Note that this set might expand over time, so implement this interface at
 * your own risk.
 */
abstract class Tab implements HasAllKeyHandlers, HasClickHandlers, HasWordWrap {
  /**
   * Check if the underlying widget implements {@link HasWordWrap}.
   *
   * @return true if the widget implements {@link HasWordWrap}
   */
  bool hasWordWrap();
}

/**
 * <code>_ClickDelegatePanel</code> decorates any widget with the minimal
 * amount of machinery to receive clicks for delegation to the parent.
 * {@link SourcesClickEvents} is not implemented due to the fact that only a
 * single observer is needed.
 */
class _ClickDelegatePanel extends Composite implements Tab {
  SimplePanel focusablePanel;
  bool enabled = true;

  TabBar _tabBar;
  
  _ClickDelegatePanel(this._tabBar, Widget child) {

    focusablePanel = new SimplePanel.fromElement(FocusPanel.impl.createFocusable());
    focusablePanel.setWidget(child);
    SimplePanel wrapperWidget = _tabBar.createTabTextWrapper();
    if (wrapperWidget == null) {
      initWidget(focusablePanel);
    } else {
      wrapperWidget.setWidget(focusablePanel);
      initWidget(wrapperWidget);
    }

   //sinkEvents(dart_html.Event.ONCLICK | dart_html.Event.ONKEYDOWN);
  }

  
  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addHandler(handler, ClickEvent.TYPE);
  }

  
//  HandlerRegistration addKeyDownHandler(KeyDownHandler handler) {
//    return addHandler(handler, KeyDownEvent.TYPE);
//  }
//
//  
//  HandlerRegistration addKeyPressHandler(KeyPressHandler handler) {
//    return addDomHandler(handler, KeyPressEvent.TYPE);
//  }
//
//  
//  HandlerRegistration addKeyUpHandler(KeyUpHandler handler) {
//    return addDomHandler(handler, KeyUpEvent.TYPE);
//  }

  SimplePanel getFocusablePanel() {
    return focusablePanel;
  }

  
  /**
   * Gets whether word-wrapping is enabled.
   * 
   * @return <code>true</code> if word-wrapping is enabled.
   */
  bool get wordWrap => _getWordWrap();
  
  bool _getWordWrap() {
    if (hasWordWrap()) {
      return (focusablePanel.getWidget() as HasWordWrap).wordWrap;
    }
    throw new Exception("Widget does not implement HasWordWrap");
  }

  
  bool hasWordWrap() {
    return focusablePanel.getWidget() is HasWordWrap;
  }

  bool isEnabled() {
    return enabled;
  }

  
  void onBrowserEvent(dart_html.Event event) {
    if (!enabled) {
      return;
    }

    // No need for call to super.
//    switch (Dom.eventGetType(event)) {
//      case dart_html.Event.ONCLICK:
//        TabBar.this.selectTabByTabWidget(this);
//        TabBar.this.onClick(this);
//        break;
//
//      case dart_html.Event.ONKEYDOWN:
//        if (((char) Dom.eventGetKeyCode(event)) == KeyCodes.KEY_ENTER) {
//          TabBar.this.selectTabByTabWidget(this);
//        }
//        TabBar.this.onKeyDown(this, (char) event.getKeyCode(),
//            KeyboardListenerCollection.getKeyboardModifiers(event));
//        break;
//    }
    super.onBrowserEvent(event);
  }

  void setEnabled(bool enabled) {
    this.enabled = enabled;
  }

  
  void set wordWrap(bool wrap) {
    if (hasWordWrap()) {
      (focusablePanel.getWidget() as HasWordWrap).wordWrap = wrap;
    } else {
      throw new Exception("Widget does not implement HasWordWrap");
    }
  }
}
