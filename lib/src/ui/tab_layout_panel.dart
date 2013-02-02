//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that represents a tabbed set of pages, each of which contains another
 * widget. Its child widgets are shown as the user selects the various _tabs
 * associated with them. The _tabs can contain arbitrary text, HTML, or widgets.
 *
 * <p>
 * This widget will <em>only</em> work in standards mode, which requires that
 * the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-TabLayoutPanel
 * <dd>the panel itself
 * <dt>.gwt-TabLayoutPanel .gwt-TabLayoutPanelTabs
 * <dd>the tab bar element
 * <dt>.gwt-TabLayoutPanel .gwt-TabLayoutPanelTab
 * <dd>an individual tab
 * <dt>.gwt-TabLayoutPanel .gwt-TabLayoutPanelTabInner
 * <dd>an element nested in each tab (useful for styling)
 * <dt>.gwt-TabLayoutPanel .gwt-TabLayoutPanelContent
 * <dd>applied to all child content widgets
 * </dl>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.TabLayoutPanelExample}
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * A TabLayoutPanel element in a {@link com.google.gwt.uibinder.client.UiBinder
 * UiBinder} template must have a <code>barHeight</code> attribute with a double
 * value, and may have a <code>barUnit</code> attribute with a
 * {@link com.google.gwt.dom.client.Style.Unit Style.Unit} value.
 * <code>barUnit</code> defaults to PX.
 * <p>
 * The children of a TabLayoutPanel element are laid out in &lt;g:tab>
 * elements. Each tab can have one widget child and one of two types of header
 * elements. A &lt;g:header> element can hold html, or a &lt;g:customHeader>
 * element can hold a widget. (Note that the tags of the header elements are
 * not capitalized. This is meant to signal that the head is not a runtime
 * object, and so cannot have a <code>ui:field</code> attribute.)
 * <p>
 * For example:<pre>
 * &lt;g:TabLayoutPanel barUnit='EM' barHeight='3'>
 *  &lt;g:tab>
 *    &lt;g:header size='7'>&lt;b>HTML&lt;/b> header&lt;/g:header>
 *    &lt;g:Label>able&lt;/g:Label>
 *  &lt;/g:tab>
 *  &lt;g:tab>
 *    &lt;g:customHeader size='7'>
 *      &lt;g:Label>Custom header&lt;/g:Label>
 *    &lt;/g:customHeader>
 *    &lt;g:Label>baker&lt;/g:Label>
 *  &lt;/g:tab>
 * &lt;/g:TabLayoutPanel>
 * </pre>
 */
class TabLayoutPanel extends ResizeComposite implements HasWidgets, ProvidesResize, IndexedPanelForIsWidget, AnimatedLayout, HasBeforeSelectionHandlers<int>, HasSelectionHandlers<int> {

  static final String _CONTENT_CONTAINER_STYLE = "dwt-TabLayoutPanelContentContainer";
  static final String _CONTENT_STYLE = "dwt-TabLayoutPanelContent";
  static final String _TAB_STYLE = "dwt-TabLayoutPanelTab";
  
  static final String _TAB_INNER_STYLE = "dwt-TabLayoutPanelTabInner";
  
  static final int _BIG_ENOUGH_TO_NOT_WRAP = 16384;

  _TabbedDeckLayoutPanel _deckPanel;
  final FlowPanel _tabBar = new FlowPanel();
  final List<_Tab> _tabs = new List<_Tab>();
  int _selectedIndex = -1;

  /**
   * Creates an empty tab panel.
   *
   * @param barHeight the size of the tab bar
   * @param barUnit the unit in which the tab bar size is specified
   */
  TabLayoutPanel(double barHeight, Unit barUnit) {
    _deckPanel = new _TabbedDeckLayoutPanel(this);
    _deckPanel.addStyleName(_CONTENT_CONTAINER_STYLE);
    //
    LayoutPanel panel = new LayoutPanel();
    initWidget(panel);

    // Add the tab bar to the panel.
    panel.add(_tabBar);
    panel.setWidgetLeftRight(_tabBar, 0.0, Unit.PX, 0.0, Unit.PX);
    panel.setWidgetTopHeight(_tabBar, 0.0, Unit.PX, barHeight, barUnit);
    panel.setWidgetVerticalPosition(_tabBar, Alignment.END);

    // Add the deck panel to the panel.
    panel.add(_deckPanel);
    panel.setWidgetLeftRight(_deckPanel, 0.0, Unit.PX, 0.0, Unit.PX);
    panel.setWidgetTopBottom(_deckPanel, barHeight, barUnit, 0.0, Unit.PX);

    // Make the tab bar extremely wide so that _tabs themselves never wrap.
    // (Its layout container is overflow:hidden)
    _tabBar.getElement().style.width = _BIG_ENOUGH_TO_NOT_WRAP.toString().concat(Unit.PX.value);

    _tabBar.clearAndSetStyleName("dwt-TabLayoutPanelTabs");
    clearAndSetStyleName("dwt-TabLayoutPanel");
  }

//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void addIsWidget(IsWidget w) {
//    add(asWidgetOrNull(w));
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void addIsWidgetTab(IsWidget w, IsWidget tab) {
//    addIsWidget(asWidgetOrNull(w), asWidgetOrNull(tab));
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void addIsWidgetText(IsWidget w, String text) {
//    add(asWidgetOrNull(w), text);
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void add(IsWidget w, String text, bool asHtml) {
//    add(asWidgetOrNull(w), text, asHtml);
//  }

//  /**
//   * Adds a widget to the panel. If the Widget is already attached, it will be
//   * moved to the right-most index.
//   *
//   * @param child the widget to be added
//   * @param html the html to be shown on its tab
//   */
//  void add(Widget child, SafeHtml html) {
//    add(child, html.asString(), true);
//  }

  /**
   * Adds a widget to the panel. If the Widget is already attached, it will be
   * moved to the right-most index.
   *
   * @param child the widget to be added
   * @param text the text to be shown on its tab
   * @param asHtml <code>true</code> to treat the specified text as HTML
   */
  void add(Widget child, [String text = "", bool asHtml = false]) {
    insert(child, getWidgetCount(), text, asHtml);
  }

  /**
   * Adds a widget to the panel. If the Widget is already attached, it will be
   * moved to the right-most index.
   *
   * @param child the widget to be added
   * @param tab the widget to be placed in the associated tab
   */
  void addTab(Widget child, Widget tab) {
    insertTab(child, tab, getWidgetCount());
  }

  HandlerRegistration addBeforeSelectionHandler(
      BeforeSelectionHandler<int> handler) {
    return addHandler(handler, BeforeSelectionEvent.getType());
  }

  HandlerRegistration addSelectionHandler(
      SelectionHandler<int> handler) {
    return addHandler(handler, SelectionEvent.getType());
  }

  void animate(int duration, [LayoutAnimationCallback callback = null]) {
    _deckPanel.animate(duration, callback);
  }

  void clear() {
    Iterator<Widget> it = iterator() as Iterator<Widget>;
    while (it.moveNext()) {
      Widget widget = it.current;
      widget.removeFromParent();
    }
  }

  void forceLayout() {
    _deckPanel.forceLayout();
  }

  /**
   * Get the duration of the animated transition between _tabs.
   *
   * @return the duration in milliseconds
   */
  int getAnimationDuration() {
    return _deckPanel.getAnimationDuration();
  }

  /**
   * Gets the index of the currently-selected tab.
   *
   * @return the selected index, or <code>-1</code> if none is selected.
   */
  int getSelectedIndex() {
    return _selectedIndex;
  }

  /**
   * Gets the widget in the tab at the given index.
   *
   * @param index the index of the tab to be retrieved
   * @return the tab's widget
   */
  Widget getTabWidgetById(int index) {
    checkIndex(index);
    return _tabs[index].getWidget();
  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
  Widget getTabIsWidget(IsWidget child) {
    return getTabWidget(asWidgetOrNull(child));
  }

  /**
   * Gets the widget in the tab associated with the given child widget.
   *
   * @param child the child whose tab is to be retrieved
   * @return the tab's widget
   */
  Widget getTabWidget(Widget child) {
    checkChild(child);
    return getWidgetById(getWidgetIndex(child));
  }

  /**
   * Returns the widget at the given index.
   */
  Widget getWidgetById(int index) {
    return _deckPanel.getWidget(index);
  }

  /**
   * Returns the number of _tabs and widgets.
   */
  int getWidgetCount() {
    return _deckPanel.getWidgetCount();
  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
  int getWidgetIndexIsWidget(IsWidget child) {
    return getWidgetIndex(asWidgetOrNull(child));
  }

  /**
   * Returns the index of the given child, or -1 if it is not a child.
   */
  int getWidgetIndex(Widget child) {
    return _deckPanel.getWidgetIndex(child);
  }

//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void insert(IsWidget child, int beforeIndex) {
//    insert(asWidgetOrNull(child), beforeIndex);
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void insert(IsWidget child, IsWidget tab, int beforeIndex) {
//    insert(asWidgetOrNull(child), asWidgetOrNull(tab), beforeIndex);
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void insert(IsWidget child, String text, bool asHtml, int beforeIndex) {
//    insert(asWidgetOrNull(child), text, asHtml, beforeIndex);
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void insert(IsWidget child, String text, int beforeIndex) {
//    insert(asWidgetOrNull(child), text, beforeIndex);
//  }

//  /**
//   * Inserts a widget into the panel. If the Widget is already attached, it will
//   * be moved to the requested index.
//   *
//   * @param child the widget to be added
//   * @param html the html to be shown on its tab
//   * @param beforeIndex the index before which it will be inserted
//   */
//  void insert(Widget child, SafeHtml html, int beforeIndex) {
//    insert(child, html.asString(), true, beforeIndex);
//  }

  /**
   * Inserts a widget into the panel. If the Widget is already attached, it will
   * be moved to the requested index.
   *
   * @param child the widget to be added
   * @param text the text to be shown on its tab
   * @param asHtml <code>true</code> to treat the specified text as HTML
   * @param beforeIndex the index before which it will be inserted
   */
  void insert(Widget child, int beforeIndex, [String text = "", bool asHtml = false]) {
    Widget contents;
    if (asHtml) {
      contents = new Html(text);
    } else {
      contents = new Label(text);
    }
    insertTab(child, contents, beforeIndex);
  }

  /**
   * Inserts a widget into the panel. If the Widget is already attached, it will
   * be moved to the requested index.
   *
   * @param child the widget to be added
   * @param tab the widget to be placed in the associated tab
   * @param beforeIndex the index before which it will be inserted
   */
  void insertTab(Widget child, Widget tab, int beforeIndex) {
    _insert(child, new _Tab(this, tab), beforeIndex);
  }

  /**
   * Check whether or not transitions slide in vertically or horizontally.
   * Defaults to horizontally.
   *
   * @return true for vertical transitions, false for horizontal
   */
  bool isAnimationVertical() {
    return _deckPanel.isAnimationVertical();
  }

  Iterator<Widget> iterator() {
    return _deckPanel.iterator();
  }

  bool removeAt(int index) {
    if ((index < 0) || (index >= getWidgetCount())) {
      return false;
    }

    Widget child = getWidgetById(index);
    _tabBar.removeAt(index);
    _deckPanel._removeProtected(child);
    child.removeStyleName(_CONTENT_STYLE);

    _Tab tab = _tabs.removeAt(index);
    tab.getWidget().removeFromParent();

    if (index == _selectedIndex) {
      // If the selected tab is being removed, select the first tab (if there
      // is one).
      _selectedIndex = -1;
      if (getWidgetCount() > 0) {
        selectTab(0);
      }
    } else if (index < _selectedIndex) {
      // If the _selectedIndex is greater than the one being removed, it needs
      // to be adjusted.
      --_selectedIndex;
    }
    return true;
  }

  bool remove(Widget w) {
    int index = getWidgetIndex(w);
    if (index == -1) {
      return false;
    }

    return removeAt(index);
  }

  /**
   * Programmatically selects the specified tab.
   *
   * @param index the index of the tab to be selected
   * @param fireEvents true to fire events, false not to
   */
  void selectTab(int index, [bool fireEvents = true]) {
    checkIndex(index);
    if (index == _selectedIndex) {
      return;
    }

    // Fire the before selection event, giving the recipients a chance to
    // cancel the selection.
    if (fireEvents) {
      BeforeSelectionEvent<int> event = BeforeSelectionEvent.fire(this, index);
      if ((event != null) && event.isCanceled()) {
        return;
      }
    }

    // Update the _tabs being selected and unselected.
    if (_selectedIndex != -1) {
      _tabs[_selectedIndex].setSelected(false);
    }

    _deckPanel.showWidgetAt(index);
    _tabs[index].setSelected(true);
    _selectedIndex = index;

    // Fire the selection event.
    if (fireEvents) {
      SelectionEvent.fire(this, index);
    }
  }

//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void selectTab(IsWidget child) {
//    selectTab(asWidgetOrNull(child));
//  }
//
//  /**
//   * Convenience overload to allow {@link IsWidget} to be used directly.
//   */
//  void selectTab(IsWidget child, bool fireEvents) {
//    selectTab(asWidgetOrNull(child), fireEvents);
//  }

  /**
   * Programmatically selects the specified tab.
   *
   * @param child the child whose tab is to be selected
   * @param fireEvents true to fire events, false not to
   */
  void selectTabWidget(Widget child, [bool fireEvents = true]) {
    selectTab(getWidgetIndex(child), fireEvents);
  }

  /**
   * Set the duration of the animated transition between _tabs.
   *
   * @param duration the duration in milliseconds.
   */
  void setAnimationDuration(int duration) {
    _deckPanel.setAnimationDuration(duration);
  }

  /**
   * Set whether or not transitions slide in vertically or horizontally.
   *
   * @param isVertical true for vertical transitions, false for horizontal
   */
  void setAnimationVertical(bool isVertical) {
    _deckPanel.setAnimationVertical(isVertical);
  }

  /**
   * Sets a tab's HTML contents.
   *
   * Use care when setting an object's HTML; it is an easy way to expose
   * script-based security problems. Consider using
   * {@link #setTabHTML(int, SafeHtml)} or
   * {@link #setTabText(int, String)} whenever possible.
   *
   * @param index the index of the tab whose HTML is to be set
   * @param html the tab's new HTML contents
   */
  void setTabHtml(int index, String html) {
    checkIndex(index);
    _tabs[index].setWidget(new Html(html));
  }

//  /**
//   * Sets a tab's HTML contents.
//   *
//   * @param index the index of the tab whose HTML is to be set
//   * @param html the tab's new HTML contents
//   */
//  void setTabHhtml(int index, SafeHtml html) {
//    setTabHTML(index, html.asString());
//  }

  /**
   * Sets a tab's text contents.
   *
   * @param index the index of the tab whose text is to be set
   * @param text the object's new text
   */
  void setTabText(int index, String text) {
    checkIndex(index);
    _tabs[index].setWidget(new Label(text));
  }

  void checkChild(Widget child) {
    assert (getWidgetIndex(child) >= 0); // : "Child is not a part of this panel";
  }

  void checkIndex(int index) {
    assert ((index >= 0) && (index < getWidgetCount())); // : "Index out of bounds";
  }

  void _insert(Widget child, _Tab tab, int beforeIndex) {
    assert ((beforeIndex >= 0) && (beforeIndex <= getWidgetCount())); // : "beforeIndex out of bounds";

    // Check to see if the TabPanel already contains the Widget. If so,
    // remove it and see if we need to shift the position to the left.
    int idx = getWidgetIndex(child);
    if (idx != -1) {
      remove(child);
      if (idx < beforeIndex) {
        beforeIndex--;
      }
    }

    _deckPanel._insertProtected(child, beforeIndex);
    _tabs.insertRange(beforeIndex, 1, tab);
    _tabBar.insertWidget(tab, beforeIndex);
    tab.addClickHandler(new ClickHandlerAdapter((ClickEvent event) {
      selectTabWidget(child);
    }));

    child.addStyleName(_CONTENT_STYLE);

    if (_selectedIndex == -1) {
      selectTab(0);
    } else if (_selectedIndex >= beforeIndex) {
      // If we inserted before the currently selected tab, its index has just
      // increased.
      _selectedIndex++;
    }
  }
}

class _Tab extends SimplePanel {

  TabLayoutPanel _panel;

  dart_html.Element _inner;
  bool _replacingWidget;

  _Tab(this._panel, Widget child) : super.fromElement(new dart_html.DivElement()) {
    getElement().append(_inner = new dart_html.DivElement());

    setWidget(child);
    clearAndSetStyleName(TabLayoutPanel._TAB_STYLE);
    UiObject.setElementStyleName(_inner, TabLayoutPanel._TAB_INNER_STYLE);

    //getElement().addClassName(CommonResources.getInlineBlockStyle());
    getElement().style.position = "relative";
    getElement().style.display = "inline-block";
  }

  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addDomHandler(handler, ClickEvent.TYPE);
  }

  bool remove(Widget w) {
    /*
     * Removal of items from the TabBar is delegated to the TabLayoutPanel to
     * ensure consistency.
     */
    int index = this._panel._tabs.indexOf(this);
    if (_replacingWidget || index < 0) {
      /*
       * The tab contents are being replaced, or this tab is no longer in the
       * panel, so just remove the widget.
       */
      return super.remove(w);
    } else {
      // Delegate to the TabLayoutPanel.
      return this._panel.removeAt(index);
    }
  }

  void setSelected(bool selected) {
    if (selected) {
      addStyleDependentName("selected");
    } else {
      removeStyleDependentName("selected");
    }
  }

  void setWidget(Widget w) {
    _replacingWidget = true;
    super.setWidget(w);
    _replacingWidget = false;
  }

  dart_html.Element getContainerElement() {
    return _inner;
  }
}


/**
 * This extension of DeckLayoutPanel overrides the mutator methods to
 * prevent external callers from adding to the state of the DeckPanel.
 * <p>
 * Removal of Widgets is supported so that WidgetCollection.WidgetIterator
 * operates as expected.
 * </p>
 * <p>
 * We ensure that the DeckLayoutPanel cannot become of of sync with its
 * associated TabBar by delegating all mutations to the TabBar to this
 * implementation of DeckLayoutPanel.
 * </p>
 */
class _TabbedDeckLayoutPanel extends DeckLayoutPanel {

  TabLayoutPanel _panel;

  _TabbedDeckLayoutPanel(this._panel);

  void add(Widget w) {
    throw new Exception("Use TabLayoutPanel.add() to alter the DeckLayoutPanel");
  }

  void clear() {
    throw new Exception("Use TabLayoutPanel.clear() to alter the DeckLayoutPanel");
  }

  void insertWidget(Widget w, int beforeIndex) {
    throw new Exception("Use TabLayoutPanel.insert() to alter the DeckLayoutPanel");
  }

  bool remove(Widget w) {
    /*
     * Removal of items from the DeckLayoutPanel is delegated to the
     * TabLayoutPanel to ensure consistency.
     */
    return this._panel.remove(w);
  }

  void _insertProtected(Widget w, int beforeIndex) {
    super.insertWidget(w, beforeIndex);
  }

  void _removeProtected(Widget w) {
    super.remove(w);
  }
}