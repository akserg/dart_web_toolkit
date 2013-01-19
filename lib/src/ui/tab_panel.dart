//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that represents a tabbed set of pages, each of which contains another
 * widget. Its child widgets are shown as the user selects the various tabs
 * associated with them. The tabs can contain arbitrary HTML.
 *
 * <p>
 * This widget will <em>only</em> work in quirks mode. If your application is in
 * Standards Mode, use {@link TabLayoutPanel} instead.
 * </p>
 *
 * <p>
 * <img class='gallery' src='doc-files/TabPanel.png'/>
 * </p>
 *
 * <p>
 * Note that this widget is not a panel per se, but rather a
 * {@link com.google.dwt.user.client.ui.Composite} that aggregates a
 * {@link com.google.dwt.user.client.ui.TabBar} and a
 * {@link com.google.dwt.user.client.ui.DeckPanel}. It does, however, implement
 * {@link com.google.dwt.user.client.ui.HasWidgets}.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.dwt-TabPanel { the tab panel itself }</li>
 * <li>.dwt-TabPanelBottom { the bottom section of the tab panel
 * (the deck containing the widget) }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.dwt.examples.TabPanelExample}
 * </p>
 *
 * @see TabLayoutPanel
 */

// Cannot do anything about tab panel implementing TabListener until next
// release
class TabPanel extends Composite implements /*TabListener, *SourcesTabEvents,*/ HasWidgets,
  HasAnimation, IndexedPanelForIsWidget, HasBeforeSelectionHandlers<int>,
  HasSelectionHandlers<int> {

  _UnmodifiableTabBar tabBar;
  TabbedDeckPanel deck;

  /**
   * Creates an empty tab panel.
   */
  TabPanel() {
    tabBar = new _UnmodifiableTabBar(this);
    deck = new TabbedDeckPanel(tabBar);
    //
    VerticalPanel panel = new VerticalPanel();
    panel.add(tabBar);
    panel.add(deck);

    panel.setWidgetCellHeight(deck, "100%");
    tabBar.setWidth("100%");

//    tabBar.addTabListener(this);
    initWidget(panel);
    clearAndSetStyleName("dwt-TabPanel");
    deck.clearAndSetStyleName("dwt-TabPanelBottom");
    // Add a11y role "tabpanel"
//    Roles.getTabpanelRole().set(deck.getElement());
  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
//  void add(IsWidget w, IsWidget tabWidget) {
//    add(asWidgetOrNull(w), asWidgetOrNull(tabWidget));
//  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
//  void add(IsWidget w, String tabText) {
//    add(asWidgetOrNull(w), tabText);
//  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
//  void add(IsWidget w, String tabText, bool asHtml) {
//    add(asWidgetOrNull(w), tabText, asHtml);
//  }


  void add(Widget w) {
    throw new Exception("A tabText parameter must be specified with add().");
  }

  /**
   * Adds a widget to the tab panel. If the Widget is already attached to the
   * TabPanel, it will be moved to the right-most index.
   *
   * @param w the widget to be added
   * @param tabText the text to be shown on its tab
   */
//  void add(Widget w, String tabText) {
//    insert(w, tabText, getWidgetCount());
//  }

  /**
   * Adds a widget to the tab panel. If the Widget is already attached to the
   * TabPanel, it will be moved to the right-most index.
   *
   * @param w the widget to be added
   * @param tabText the text to be shown on its tab
   * @param asHtml <code>true</code> to treat the specified text as HTML
   */
  void addTabText(Widget w, String tabText, [bool asHtml = false]) {
    insertTabText(w, tabText, getWidgetCount(), asHtml);
  }

  /**
   * Adds a widget to the tab panel. If the Widget is already attached to the
   * TabPanel, it will be moved to the right-most index.
   *
   * @param w the widget to be added
   * @param tabWidget the widget to be shown in the tab
   */
  void addTabWidget(Widget w, Widget tabWidget) {
    insertTabWidget(w, tabWidget, getWidgetCount());
  }


  HandlerRegistration addBeforeSelectionHandler(BeforeSelectionHandler<int> handler) {
    return addHandler(handler, BeforeSelectionEvent.TYPE);
  }


  HandlerRegistration addSelectionHandler(SelectionHandler<int> handler) {
    return addHandler(handler, SelectionEvent.TYPE);
  }

  /**
   * @deprecated Use {@link #addBeforeSelectionHandler} and {@link
   * #addSelectionHandler} instead
   */

//  @Deprecated
//  void addTabListener(TabListener listener) {
//    ListenerWrapper.WrappedTabListener.add(this, listener);
//  }


  void clear() {
    while (getWidgetCount() > 0) {
      remove(getWidgetAt(0));
    }
  }

  /**
   * Gets the deck panel within this tab panel. Adding or removing Widgets from
   * the DeckPanel is not supported and will throw
   * UnsupportedOperationExceptions.
   *
   * @return the deck panel
   */
  DeckPanel getDeckPanel() {
    return deck;
  }

  /**
   * Gets the tab bar within this tab panel. Adding or removing tabs from from
   * the TabBar is not supported and will throw UnsupportedOperationExceptions.
   *
   * @return the tab bar
   */
  TabBar getTabBar() {
    return tabBar;
  }


  Widget getWidgetAt(int index) {
    return deck.getWidget(index);
  }


  int getWidgetCount() {
    return deck.getWidgetCount();
  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */

  int getWidgetIndexIsWidget(IsWidget child) {
    return getWidgetIndex(asWidgetOrNull(child));
  }


  int getWidgetIndex(Widget widget) {
    return deck.getWidgetIndex(widget);
  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
//  void insert(IsWidget widget, IsWidget tabWidget, int beforeIndex) {
//    insert(asWidgetOrNull(widget), asWidgetOrNull(tabWidget), beforeIndex);
//  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
//  void insert(IsWidget widget, String tabText, bool asHtml,
//      int beforeIndex) {
//    insert(asWidgetOrNull(widget), tabText, asHtml, beforeIndex);
//  }

  /**
   * Convenience overload to allow {@link IsWidget} to be used directly.
   */
//  void insert(IsWidget widget, String tabText, int beforeIndex) {
//    insert(asWidgetOrNull(widget), tabText, beforeIndex);
//  }

  /**
   * Inserts a widget into the tab panel. If the Widget is already attached to
   * the TabPanel, it will be moved to the requested index.
   *
   * @param widget the widget to be inserted
   * @param tabText the text to be shown on its tab
   * @param asHtml <code>true</code> to treat the specified text as HTML
   * @param beforeIndex the index before which it will be inserted
   */
  void insertTabText(Widget widget, String tabText, int beforeIndex, [bool asHtml = false]) {
    // Delegate updates to the TabBar to our DeckPanel implementation
    deck.insertProtectedTabText(widget, tabText, asHtml, beforeIndex);
  }

  /**
   * Inserts a widget into the tab panel. If the Widget is already attached to
   * the TabPanel, it will be moved to the requested index.
   *
   * @param widget the widget to be inserted
   * @param tabText the text to be shown on its tab
   * @param beforeIndex the index before which it will be inserted
   */
//  void insert(Widget widget, String tabText, int beforeIndex) {
//    insert(widget, tabText, false, beforeIndex);
//  }

  /**
   * Inserts a widget into the tab panel. If the Widget is already attached to
   * the TabPanel, it will be moved to the requested index.
   *
   * @param widget the widget to be inserted.
   * @param tabWidget the widget to be shown on its tab.
   * @param beforeIndex the index before which it will be inserted.
   */
  void insertTabWidget(Widget widget, Widget tabWidget, int beforeIndex) {
    // Delegate updates to the TabBar to our DeckPanel implementation
    deck.insertProtectedTabWidget(widget, tabWidget, beforeIndex);
  }


  bool isAnimationEnabled() {
    return deck.isAnimationEnabled();
  }


  Iterator<Widget> iterator() {
    // The Iterator returned by DeckPanel supports removal and will invoke
    // TabbedDeckPanel.remove(), which is an active function.
    return deck.iterator();
  }

  /**
   * @deprecated Use {@link BeforeSelectionHandler#onBeforeSelection} instead
   */

//  @Deprecated
//  bool onBeforeTabSelected(SourcesTabEvents sender, int tabIndex) {
//    BeforeSelectionEvent<int> event = BeforeSelectionEvent.fire(this, tabIndex);
//    return event == null || !event.isCanceled();
//  }

  /**
   * @deprecated Use {@link SelectionHandler#onSelection} instead
   */

//  @Deprecated
//  void onTabSelected(SourcesTabEvents sender, int tabIndex) {
//    deck.showWidget(tabIndex);
//    SelectionEvent.fire(this, tabIndex);
//  }


  bool removeAt(int index) {
    // Delegate updates to the TabBar to our DeckPanel implementation
    return deck.removeAt(index);
  }

  /**
   * Removes the given widget, and its associated tab.
   *
   * @param widget the widget to be removed
   */

  bool remove(Widget widget) {
    // Delegate updates to the TabBar to our DeckPanel implementation
    return deck.remove(widget);
  }

  /**
   * @deprecated Use the {@link HandlerRegistration#removeHandler}
   * method on the object returned by and add*Handler method instead
   */

//  @Deprecated
//  void removeTabListener(TabListener listener) {
//    ListenerWrapper.WrappedTabListener.remove(this, listener);
//  }

  /**
   * Programmatically selects the specified tab and fires events.
   *
   * @param index the index of the tab to be selected
   */
//  void selectTab(int index) {
//    selectTab(index, true);
//  }

  /**
   * Programmatically selects the specified tab.
   *
   * @param index the index of the tab to be selected
   * @param fireEvents true to fire events, false not to
   */
  void selectTab(int index, [bool fireEvents = true]) {
    tabBar.selectTab(index, fireEvents);
  }


  void setAnimationEnabled(bool enable) {
    deck.setAnimationEnabled(enable);
  }

  /**
   * Create a {@link SimplePanel} that will wrap the contents in a tab.
   * Subclasses can use this method to wrap tabs in decorator panels.
   *
   * @return a {@link SimplePanel} to wrap the tab contents, or null to leave
   *         tabs unwrapped
   */
  SimplePanel createTabTextWrapper() {
    return null;
  }

  /**
   * <b>Affected Elements:</b>
   * <ul>
   * <li>-bar = The tab bar.</li>
   * <li>-bar-tab# = The element containing the content of the tab itself.</li>
   * <li>-bar-tab-wrapper# = The cell containing the tab at the index.</li>
   * <li>-bottom = The panel beneath the tab bar.</li>
   * </ul>
   *
   * @see UIObject#onEnsureDebugId(String)
   */

//  void onEnsureDebugId(String baseID) {
//    super.onEnsureDebugId(baseID);
//    tabBar.ensureDebugId(baseID + "-bar");
//    deck.ensureDebugId(baseID + "-bottom");
//  }
}

/**
 * This extension of DeckPanel overrides the mutator methods to prevent
 * external callers from adding to the state of the DeckPanel.
 * <p>
 * Removal of Widgets is supported so that WidgetCollection.WidgetIterator
 * operates as expected.
 * </p>
 * <p>
 * We ensure that the DeckPanel cannot become of of sync with its associated
 * TabBar by delegating all mutations to the TabBar to this implementation of
 * DeckPanel.
 * </p>
 */
class TabbedDeckPanel extends DeckPanel {

  final _UnmodifiableTabBar _tabBar;

  TabbedDeckPanel(this._tabBar);


  void add(Widget w) {
    throw new Exception("Use TabPanel.add() to alter the DeckPanel");
  }


  void clear() {
    throw new Exception("Use TabPanel.clear() to alter the DeckPanel");
  }


  void insertAt(Widget w, int beforeIndex) {
    throw new Exception("Use TabPanel.insert() to alter the DeckPanel");
  }


  bool remove(Widget w) {
    // Removal of items from the TabBar is delegated to the DeckPanel
    // to ensure consistency
    int idx = getWidgetIndex(w);
    if (idx != -1) {
      _tabBar.removeTabProtected(idx);
      return super.remove(w);
    }

    return false;
  }

  void insertProtectedTabText(Widget w, String tabText, bool asHtml, int beforeIndex) {

    // Check to see if the TabPanel already contains the Widget. If so,
    // remove it and see if we need to shift the position to the left.
    int idx = getWidgetIndex(w);
    if (idx != -1) {
      remove(w);
      if (idx < beforeIndex) {
        beforeIndex--;
      }
    }

    _tabBar.insertTabTextProtected(tabText, asHtml, beforeIndex);
    super.insertAt(w, beforeIndex);
  }

  void insertProtectedTabWidget(Widget w, Widget tabWidget, int beforeIndex) {

    // Check to see if the TabPanel already contains the Widget. If so,
    // remove it and see if we need to shift the position to the left.
    int idx = getWidgetIndex(w);
    if (idx != -1) {
      remove(w);
      if (idx < beforeIndex) {
        beforeIndex--;
      }
    }

    _tabBar.insertTabWidgetProtected(tabWidget, beforeIndex);
    super.insertAt(w, beforeIndex);
  }
}

/**
 * This extension of TabPanel overrides the mutator methods to prevent
 * external callers from modifying the state of the TabBar.
 */
class _UnmodifiableTabBar extends TabBar {

  TabPanel _panel;

  _UnmodifiableTabBar(this._panel);

  void insertTabText(String text, int beforeIndex, [bool asHtml = false]) {
    throw new Exception("Use TabPanel.insert() to alter the TabBar");
  }


  void insertTabWidget(Widget widget, int beforeIndex) {
    throw new Exception("Use TabPanel.insert() to alter the TabBar");
  }

  void insertTabTextProtected(String text, bool asHtml, int beforeIndex) {
    super.insertTabText(text, beforeIndex, asHtml);
  }

  void insertTabWidgetProtected(Widget widget, int beforeIndex) {
    super.insertTabWidget(widget, beforeIndex);
  }


  void removeTab(int index) {
    // It's possible for removeTab() to function correctly, but it's
    // preferable to have only TabbedDeckPanel.remove() be operable,
    // especially since TabBar does not export an Iterator over its values.
    throw new Exception("Use TabPanel.remove() to alter the TabBar");
  }

  void removeTabProtected(int index) {
    super.removeTab(index);
  }


  SimplePanel createTabTextWrapper() {
    return _panel.createTabTextWrapper();
  }
}
