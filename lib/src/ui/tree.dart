//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A standard hierarchical tree widget. The tree contains a hierarchy of
 * {@link com.google.gwt.user.client.ui.TreeItem TreeItems} that the user can
 * open, close, and select.
 * <p>
 * <img class='gallery' src='doc-files/Tree.png'/>
 * </p>
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-Tree</dt>
 * <dd>the tree itself</dd>
 * <dt>.gwt-Tree .gwt-TreeItem</dt>
 * <dd>a tree item</dd>
 * <dt>.gwt-Tree .gwt-TreeItem-selected</dt>
 * <dd>a selected tree item</dd>
 * </dl>
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.TreeExample}
 * </p>
 */
class Tree extends Widget implements HasTreeItemsForIsWidget, HasWidgetsForIsWidget,
    Focusable, HasAnimation, HasAllKeyHandlers,
    HasAllFocusHandlers, HasSelectionHandlers<TreeItem>,
    HasOpenHandlers<TreeItem>, HasCloseHandlers<TreeItem>, HasAllMouseHandlers {

  static const int _OTHER_KEY_DOWN = 63233;
  static const int _OTHER_KEY_LEFT = 63234;
  static const int _OTHER_KEY_RIGHT = 63235;
  static const int _OTHER_KEY_UP = 63232;

  static bool shouldTreeDelegateFocusToElement(dart_html.Element elem) {
    String name = ""; //elem.nodeName;
    return ((name == "SELECT") ||
        (name == "INPUT")  ||
        (name == "TEXTAREA") ||
        (name == "OPTION") ||
        (name == "BUTTON") ||
        (name == "LABEL"));
  }

  static bool isArrowKey(int code) {
    switch (code) {
      case _OTHER_KEY_DOWN:
      case _OTHER_KEY_RIGHT:
      case _OTHER_KEY_UP:
      case _OTHER_KEY_LEFT:
      case KeyCodes.KEY_DOWN:
      case KeyCodes.KEY_RIGHT:
      case KeyCodes.KEY_UP:
      case KeyCodes.KEY_LEFT:
        return true;
      default:
        return false;
    }
  }

  /**
   * Normalized key codes. Also switches KEY_RIGHT and KEY_LEFT in RTL
   * languages.
   */
  static int _standardizeKeycode(int code) {
    switch (code) {
      case _OTHER_KEY_DOWN:
        code = KeyCodes.KEY_DOWN;
        break;
      case _OTHER_KEY_RIGHT:
        code = KeyCodes.KEY_RIGHT;
        break;
      case _OTHER_KEY_UP:
        code = KeyCodes.KEY_UP;
        break;
      case _OTHER_KEY_LEFT:
        code = KeyCodes.KEY_LEFT;
        break;
    }
    if (LocaleInfo.getCurrentLocale().isRTL()) {
      if (code == KeyCodes.KEY_RIGHT) {
        code = KeyCodes.KEY_LEFT;
      } else if (code == KeyCodes.KEY_LEFT) {
        code = KeyCodes.KEY_RIGHT;
      }
    }
    return code;
  }

  /**
   * Map of TreeItem.widget -> TreeItem.
   */
  Map<Widget, TreeItem> _childWidgets = new Map<Widget, TreeItem>();

  TreeItem _curSelection;

  dart_html.Element _focusable;

  _ImageAdapter _images;

  String _indentValue = "";

  bool _isAnimationEnabled = false;

  bool _lastWasKeyDown = false;

  TreeItem _root;

  bool _useLeafImages;

  /**
   * Constructs a tree that uses the specified ClientBundle for images. If this
   * tree does not use leaf images, the width of the Resources's leaf image will
   * control the leaf indent.
   *
   * @param resources a bundle that provides tree specific images
   * @param useLeafImages use leaf images from bundle
   */
  Tree([_TreeResource resources = null, bool useLeafImages = false]) {
    if (resources == null) {
      _init(new _ImageAdapter(), useLeafImages);
    } else {
      _init(new _ImageAdapter(resources), useLeafImages);
    }
  }

  /**
   * Adds the widget as a root tree item.
   *
   * @see com.google.gwt.user.client.ui.HasWidgets#add(com.google.gwt.user.client.ui.Widget)
   * @param widget widget to add.
   */

  void add(Widget widget) {
    addWidgetItem(widget);
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #add(Widget)
   */

  void addIsWidget(IsWidget w) {
    this.add(asWidgetOrNull(w));
  }


  HandlerRegistration addBlurHandler(BlurHandler handler) {
    return addDomHandler(handler, BlurEvent.TYPE);
  }


  HandlerRegistration addCloseHandler(CloseHandler<TreeItem> handler) {
    return addHandler(handler, CloseEvent.TYPE);
  }


  HandlerRegistration addFocusHandler(FocusHandler handler) {
    return addDomHandler(handler, FocusEvent.TYPE);
  }

  /**
   * Adds a simple tree item containing the specified html.
   *
   * @param itemHtml the html of the item to be added
   * @return the item that was added
   */

  TreeItem addSafeHtmlItem(SafeHtml itemHtml) {
    return _root.addSafeHtmlItem(itemHtml);
  }

  /**
   * Adds an item to the root level of this tree.
   *
   * @param item the item to be added
   */

  void addItem(TreeItem item) {
    _root.addItem(item);
  }

  /**
   * Adds an item to the root level of this tree.
   *
   * @param isItem the wrapper of item to be added
   */

  void addIsTreeItem(IsTreeItem isItem) {
    _root.addIsTreeItem(isItem);
  }

  /**
   * Adds a new tree item containing the specified widget.
   *
   * @param widget the widget to be added
   * @return the new item
   */

  TreeItem addWidgetItem(Widget widget) {
    return _root.addWidgetItem(widget);
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #addItem(Widget)
   */

  TreeItem addIsWidgetItem(IsWidget w) {
    return this.addIsWidgetItem(asWidgetOrNull(w));
  }

  HandlerRegistration addKeyDownHandler(KeyDownHandler handler) {
    return addDomHandler(handler, KeyDownEvent.TYPE);
  }


  HandlerRegistration addKeyPressHandler(KeyPressHandler handler) {
    return addDomHandler(handler, KeyPressEvent.TYPE);
  }


  HandlerRegistration addKeyUpHandler(KeyUpHandler handler) {
    return addDomHandler(handler, KeyUpEvent.TYPE);
  }


  HandlerRegistration addMouseDownHandler(MouseDownHandler handler) {
    return addHandler(handler, MouseDownEvent.TYPE);
  }

  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler) {
    return addDomHandler(handler, MouseMoveEvent.TYPE);
  }


  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
    return addDomHandler(handler, MouseOutEvent.TYPE);
  }


  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
    return addDomHandler(handler, MouseOverEvent.TYPE);
  }


  HandlerRegistration addMouseUpHandler(MouseUpHandler handler) {
    return addDomHandler(handler, MouseUpEvent.TYPE);
  }


  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler) {
    return addDomHandler(handler, MouseWheelEvent.TYPE);
  }


  HandlerRegistration addOpenHandler(OpenHandler<TreeItem> handler) {
    return addHandler(handler, OpenEvent.TYPE);
  }


  HandlerRegistration addSelectionHandler(
      SelectionHandler<TreeItem> handler) {
    return addHandler(handler, SelectionEvent.TYPE);
  }

  /**
   * Adds a simple tree item containing the specified text.
   *
   * @param itemText the text of the item to be added
   * @return the item that was added
   */

  TreeItem addTextItem(String itemText) {
    return _root.addTextItem(itemText);
  }

  /**
   * Clears all tree items from the current tree.
   */

  void clear() {
    int size = _root.getChildCount();
    for (int i = size - 1; i >= 0; i--) {
      _root.getChild(i).remove();
    }
  }

  /**
   * Ensures that the currently-selected item is visible, opening its parents
   * and scrolling the tree as necessary.
   */
  void ensureSelectedItemVisible() {
    if (_curSelection == null) {
      return;
    }

    TreeItem parent = _curSelection.getParentItem();
    while (parent != null) {
      parent.setState(true);
      parent = parent.getParentItem();
    }
  }

  /**
   * Gets the top-level tree item at the specified index.
   *
   * @param index the index to be retrieved
   * @return the item at that index
   */
  TreeItem getItem(int index) {
    return _root.getChild(index);
  }

  /**
   * Gets the number of items contained at the root of this tree.
   *
   * @return this tree's item count
   */
  int getItemCount() {
    return _root.getChildCount();
  }

  /**
   * Gets the currently selected item.
   *
   * @return the selected item
   */
  TreeItem getSelectedItem() {
    return _curSelection;
  }


  int get tabIndex {
    return FocusPanel.impl.getTabIndex(_focusable);
  }

  /**
   * Inserts a child tree item at the specified index containing the specified
   * html.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param itemHtml the html of the item to be added
   * @return the item that was added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  TreeItem insertSafeHtmlItem(int beforeIndex, SafeHtml itemHtml) {
    return _root.insertSafeHtmlItem(beforeIndex, itemHtml);
  }

  /**
   * Inserts an item into the root level of this tree.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param item the item to be added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  void insertItem(int beforeIndex, TreeItem item) {
    _root.insertItem(beforeIndex, item);
  }

  /**
   * Inserts a child tree item at the specified index containing the specified
   * widget.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param widget the widget to be added
   * @return the item that was added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  TreeItem insertWidgetItem(int beforeIndex, Widget widget) {
    return _root.insertWidgetItem(beforeIndex, widget);
  }

  /**
   * Inserts a child tree item at the specified index containing the specified
   * text.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param itemText the text of the item to be added
   * @return the item that was added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  TreeItem insertTextItem(int beforeIndex, String itemText) {
    return _root.insertTextItem(beforeIndex, itemText);
  }


  bool isAnimationEnabled() {
    return _isAnimationEnabled;
  }


  Iterator<Widget> iterator() {
    List<Widget> widgets = new List<Widget>.from(_childWidgets.keys);
    return WidgetIterators.createWidgetIterator(this, widgets);
  }


//  @SuppressWarnings("fallthrough")
  void onBrowserEvent(dart_html.Event event) {
    int eventType = Dom.eventGetType(event);

    switch (eventType) {
      case IEvent.ONKEYDOWN:
        // If nothing's selected, select the first item.
        if (_curSelection == null) {
          if (_root.getChildCount() > 0) {
            _onSelection(_root.getChild(0), true, true);
          }
          super.onBrowserEvent(event);
          return;
        }
        break;
        // Intentional fallthrough.
      case IEvent.ONKEYPRESS:
      case IEvent.ONKEYUP:
        dart_html.KeyboardEvent kEvent = event as dart_html.KeyboardEvent;
        // Issue 1890: Do not block history navigation via alt+left/right

        if (kEvent.altKey || kEvent.metaKey) {
          super.onBrowserEvent(event);
          return;
        }
        break;
    }

    switch (eventType) {
      case IEvent.ONCLICK:
        dart_html.Element e = event.target as dart_html.Element;
        if (shouldTreeDelegateFocusToElement(e)) {
          // The click event should have given focus to this element already.
          // Avoid moving focus back up to the tree (so that focusable widgets
          // attached to TreeItems can receive keyboard events).
        } else if ((_curSelection != null) && Dom.isOrHasChild(_curSelection.getContentElem(), e)) {
          focus = true;
        }
        break;

      case IEvent.ONMOUSEDOWN:
        // Currently, the way we're using image bundles causes extraneous events
        // to be sunk on individual items' open/close images. This leads to an
        // extra event reaching the Tree, which we will ignore here.
        // Also, ignore middle and right clicks here.
        dart_html.MouseEvent mEvent = event as dart_html.MouseEvent;
        if (mEvent.currentTarget == getElement() && mEvent.button == IEvent.BUTTON_LEFT) {
          _elementClicked(event.target as dart_html.Element);
        }
        break;
      case IEvent.ONKEYDOWN:
        _keyboardNavigation(event);
        _lastWasKeyDown = true;
        break;

      case IEvent.ONKEYPRESS:
        if (!_lastWasKeyDown) {
          _keyboardNavigation(event);
        }
        _lastWasKeyDown = false;
        break;

      case IEvent.ONKEYUP:
        dart_html.KeyboardEvent kEvent = event as dart_html.KeyboardEvent;
        if (kEvent.keyCode == KeyCodes.KEY_TAB) {
          List<dart_html.Element> chain = new List<dart_html.Element>();
          _collectElementChain(chain, getElement(), event.target);
          TreeItem item = _findItemByChain(chain, 0, _root);
          if (item != getSelectedItem()) {
            setSelectedItem(item, true);
          }
        }
        _lastWasKeyDown = false;
        break;
    }

    switch (eventType) {
      case IEvent.ONKEYDOWN:
      case IEvent.ONKEYUP:
        dart_html.KeyboardEvent kEvent = event as dart_html.KeyboardEvent;
        if (isArrowKey(kEvent.keyCode)) {
          event.cancelBubble = true;
          event.preventDefault();
          return;
        }
        break;
    }

    // We must call super for all handlers.
    super.onBrowserEvent(event);
  }


  bool remove(Widget w) {
    // Validate.
    TreeItem item = _childWidgets[w];
    if (item == null) {
      return false;
    }

    // Delegate to TreeItem.setWidget, which performs correct removal.
    item.setWidget(null);
    return true;
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #remove(Widget)
   */

  bool removeIsWidget(IsWidget w) {
    return this.remove(w.asWidget());
  }

  /**
   * Removes an item from the root level of this tree.
   *
   * @param item the item to be removed
   */

  void removeItem(TreeItem item) {
    _root.removeItem(item);
  }

  /**
   * Removes an item from the _root level of this tree.
   *
   * @param isItem the wrapper of item to be removed
   */

  void removeIsTreeItem(IsTreeItem isItem) {
    if (isItem != null) {
      TreeItem item = isItem.asTreeItem();
      removeItem(item);
    }
  }

  /**
   * Removes all items from the root level of this tree.
   */

  void removeItems() {
    while (getItemCount() > 0) {
      removeItem(getItem(0));
    }
  }

  void set accessKey(int key) {
    FocusPanel.impl.setAccessKey(_focusable, key);
  }


  void setAnimationEnabled(bool enable) {
    _isAnimationEnabled = enable;
  }


  void set focus(bool val) {
    if (val) {
      FocusPanel.impl.focus(_focusable);
    } else {
      FocusPanel.impl.blur(_focusable);
    }
  }

  /**
   * Selects a specified item.
   *
   * @param item the item to be selected, or <code>null</code> to deselect all
   *          items
   * @param fireEvents <code>true</code> to allow selection events to be fired
   */
  void setSelectedItem(TreeItem item, [bool fireEvents = true]) {
    if (item == null) {
      if (_curSelection == null) {
        return;
      }
      _curSelection.setSelected(false);
      _curSelection = null;
      return;
    }

    _onSelection(item, fireEvents, true);
  }


  void set tabIndex(int index) {
    FocusPanel.impl.setTabIndex(_focusable, index);
  }

  /**
   * Iterator of tree items.
   *
   * @return the iterator
   */
  Iterator<TreeItem> treeItemIterator() {
    List<TreeItem> accum = new List<TreeItem>();
    _root.addTreeItems(accum);
    return accum.iterator;
  }


  void doAttachChildren() {
    try {
      AttachDetachException.tryCommand(this.iterator(), AttachDetachException.attachCommand);
    } finally {
      Dom.setEventListener(_focusable, this);
    }
  }


  void doDetachChildren() {
    try {
      AttachDetachException.tryCommand(this.iterator(), AttachDetachException.detachCommand);
    } finally {
      Dom.setEventListener(_focusable, null);
    }
  }

  /**
   * Indicates if keyboard navigation is enabled for the Tree and for a given
   * TreeItem. Subclasses of Tree can override this function to selectively
   * enable or disable keyboard navigation.
   *
   * @param currentItem the currently selected TreeItem
   * @return <code>true</code> if the Tree will response to arrow keys by
   *         changing the currently selected item
   */
  bool isKeyboardNavigationEnabled(TreeItem currentItem) {
    return true;
  }

  void onLoad() {
    _root.updateStateRecursive();
  }

  void adopt(Widget widget, TreeItem treeItem) {
    assert (!_childWidgets.containsKey(widget));
    _childWidgets[widget] = treeItem;
    widget.setParent(this);
  }

  void fireStateChanged(TreeItem item, bool open) {
    if (open) {
      OpenEvent.fire(this, item);
    } else {
      CloseEvent.fire(this, item);
    }
  }

  /*
   * This method exists solely to support unit tests.
   */
  Map<Widget, TreeItem> getChildWidgets() {
    return _childWidgets;
  }

  _ImageAdapter getImages() {
    return _images;
  }

  void maybeUpdateSelection(TreeItem itemThatChangedState, bool isItemOpening) {
    /**
     * If we just closed the item, let's check to see if this item is the parent
     * of the currently selected item. If so, we should make this item the
     * currently selected selected item.
     */
    if (!isItemOpening) {
      TreeItem tempItem = _curSelection;
      while (tempItem != null) {
        if (tempItem == itemThatChangedState) {
          setSelectedItem(itemThatChangedState);
          return;
        }
        tempItem = tempItem.getParentItem();
      }
    }
  }

  void orphan(Widget widget) {
    // Validation should already be done.
    assert (widget.getParent() == this);

    // Orphan.
    try {
      widget.setParent(null);
    } finally {
      // Logical detach.
      _childWidgets.remove(widget);
    }
  }

  /**
   * Called only from {@link TreeItem}: Shows the closed image on that tree
   * item.
   *
   * @param treeItem the tree item
   */
  void showClosedImage(TreeItem treeItem) {
    _showImage(treeItem, _images.treeClosed());
  }

  /**
   * Called only from {@link TreeItem}: Shows the leaf image on a tree item.
   *
   * @param treeItem the tree item
   */
  void showLeafImage(TreeItem treeItem) {
    if (_useLeafImages || treeItem.isFullNode()) {
      _showImage(treeItem, _images.treeLeaf());
    } else if (LocaleInfo.getCurrentLocale().isRTL()) {
      treeItem.getElement().style.paddingRight = _indentValue;
    } else {
      treeItem.getElement().style.paddingLeft = _indentValue;
    }
  }

  /**
   * Called only from {@link TreeItem}: Shows the open image on a tree item.
   *
   * @param treeItem the tree item
   */
  void showOpenImage(TreeItem treeItem) {
    _showImage(treeItem, _images.treeOpen());
  }

  /**
   * Collects parents going up the element tree, terminated at the tree root.
   */
  void _collectElementChain(List<dart_html.Element> chain, dart_html.Element hRoot,
      dart_html.Element hElem) {
    if ((hElem == null) || (hElem == hRoot)) {
      return;
    }

    _collectElementChain(chain, hRoot, hElem.parent);
    chain.add(hElem);
  }

  bool _elementClicked(dart_html.Element hElem) {
    List<dart_html.Element> chain = new List<dart_html.Element>();
    _collectElementChain(chain, getElement(), hElem);

    TreeItem item = _findItemByChain(chain, 0, _root);
    if (item != null && item != _root) {
      if (item.getChildCount() > 0
          && Dom.isOrHasChild(item.getImageElement(), hElem)) {
        item.setState(!item.getState(), true);
        return true;
      } else if (Dom.isOrHasChild(item.getElement(), hElem)) {
        _onSelection(item, true, !shouldTreeDelegateFocusToElement(hElem));
        return true;
      }
    }

    return false;
  }

  TreeItem _findDeepestOpenChild(TreeItem item) {
    if (!item.getState()) {
      return item;
    }
    return _findDeepestOpenChild(item.getChild(item.getChildCount() - 1));
  }

  TreeItem _findItemByChain(List<dart_html.Element> chain, int idx,
      TreeItem root) {
    if (idx == chain.length) {
      return root;
    }

    dart_html.Element hCurElem = chain[idx];
    for (int i = 0, n = root.getChildCount(); i < n; ++i) {
      TreeItem child = root.getChild(i);
      if (child.getElement() == hCurElem) {
        TreeItem retItem = _findItemByChain(chain, idx + 1, root.getChild(i));
        if (retItem == null) {
          return child;
        }
        return retItem;
      }
    }

    return _findItemByChain(chain, idx + 1, root);
  }

  /**
   * Get the top parent above this {@link TreeItem} that is in closed state. In
   * other words, get the parent that is guaranteed to be visible.
   *
   * @param item
   * @return the closed parent, or null if all parents are opened
   */
  TreeItem _getTopClosedParent(TreeItem item) {
    TreeItem topClosedParent = null;
    TreeItem parent = item.getParentItem();
    while (parent != null && parent != _root) {
      if (!parent.getState()) {
        topClosedParent = parent;
      }
      parent = parent.getParentItem();
    }
    return topClosedParent;
  }

  void _init(_ImageAdapter images, bool useLeafImages) {
    _setImages(images, useLeafImages);
    setElement(new dart_html.DivElement());

    getElement().style.position = "relative";

    // Fix rendering problem with relatively-positioned elements and their
    // children by
    // forcing the element that is positioned relatively to 'have layout'
    getElement().style.zoom = "1";

    _focusable = FocusPanel.impl.createFocusable();
    _focusable.style.fontSize = "0";
    _focusable.style.position = "absolute";

    // Hide focus outline in Mozilla/Webkit/Opera
    _focusable.style.outline = "0px";

    // Hide focus outline in IE 6/7
    Dom.setElementAttribute(_focusable, "hideFocus", "true");

    Dom.setIntStyleAttribute(_focusable, "zIndex", -1);
    getElement().append(_focusable);

    sinkEvents(IEvent.ONMOUSEDOWN | IEvent.ONCLICK | IEvent.KEYEVENTS);
    Dom.sinkEvents(_focusable, IEvent.FOCUSEVENTS);

    // The 'root' item is invisible and serves only as a container
    // for all top-level items.
    _root = new TreeItem(isRoot:true);
    _root.setTree(this);
    clearAndSetStyleName("dwt-Tree");

    // Add a11y role "tree"
//    Roles.getTreeRole().set(_focusable);
  }

  void _keyboardNavigation(dart_html.Event event) {
    // Handle keyboard events if keyboard navigation is enabled
    if (isKeyboardNavigationEnabled(_curSelection)) {
      dart_html.KeyboardEvent kEvent = event as dart_html.KeyboardEvent;
      int code = kEvent.keyCode;

      switch (_standardizeKeycode(code)) {
        case KeyCodes.KEY_UP:
          _moveSelectionUp(_curSelection);
          break;
        case KeyCodes.KEY_DOWN:
          _moveSelectionDown(_curSelection, true);
          break;
        case KeyCodes.KEY_LEFT:
          _maybeCollapseTreeItem();
          break;
        case KeyCodes.KEY_RIGHT:
          _maybeExpandTreeItem();
          break;
        default:
          return;
      }
    }
  }

  void _maybeCollapseTreeItem() {

    TreeItem topClosedParent = _getTopClosedParent(_curSelection);
    if (topClosedParent != null) {
      // Select the first visible parent if _curSelection is hidden
      setSelectedItem(topClosedParent);
    } else if (_curSelection.getState()) {
      _curSelection.setState(false);
    } else {
      TreeItem parent = _curSelection.getParentItem();
      if (parent != null) {
        setSelectedItem(parent);
      }
    }
  }

  void _maybeExpandTreeItem() {

    TreeItem topClosedParent = _getTopClosedParent(_curSelection);
    if (topClosedParent != null) {
      // Select the first visible parent if _curSelection is hidden
      setSelectedItem(topClosedParent);
    } else if (!_curSelection.getState()) {
      _curSelection.setState(true);
    } else if (_curSelection.getChildCount() > 0) {
      setSelectedItem(_curSelection.getChild(0));
    }
  }

  /**
   * Move the tree focus to the specified selected item.
   */
  void _moveFocus() {
    Focusable focusableWidget = _curSelection.getFocusable();
    if (focusableWidget != null) {
      focusableWidget.focus = true;
      Dom.scrollIntoView((focusableWidget as Widget).getElement());
    } else {
      // Get the location and size of the given item's content element relative
      // to the tree.
      dart_html.Element selectedElem = _curSelection.getContentElem();
      int containerLeft = getAbsoluteLeft();
      int containerTop = getAbsoluteTop();

      int left = Dom.getAbsoluteLeft(selectedElem) - containerLeft;
      int top = Dom.getAbsoluteTop(selectedElem) - containerTop;
      int width = Dom.getElementPropertyInt(selectedElem, "offsetWidth");
      int height = Dom.getElementPropertyInt(selectedElem, "offsetHeight");

      // If the item is not visible, quite here
      if (width == 0 || height == 0) {
        Dom.setIntStyleAttribute(_focusable, "left", 0);
        Dom.setIntStyleAttribute(_focusable, "top", 0);
        return;
      }

      // Set the _focusable element's position and size to exactly underlap the
      // item's content element.
      Dom.setStyleAttribute(_focusable, "left", "${left}px");
      Dom.setStyleAttribute(_focusable, "top", "${top}px");
      Dom.setStyleAttribute(_focusable, "width", "${width}px");
      Dom.setStyleAttribute(_focusable, "height", "${height}px");

      // Scroll it into view.
      Dom.scrollIntoView(_focusable);

      // Update ARIA attributes to reflect the information from the
      // newly-selected item.
      _updateAriaAttributes();

      // Ensure Focus is set, as focus may have been previously delegated by
      // tree.
      focus = true;
    }
  }

  /**
   * Moves to the next item, going into children as if dig is enabled.
   */
  void _moveSelectionDown(TreeItem sel, bool dig) {
    if (sel == _root) {
      return;
    }

    // Find a parent that is visible
    TreeItem topClosedParent = _getTopClosedParent(sel);
    if (topClosedParent != null) {
      _moveSelectionDown(topClosedParent, false);
      return;
    }

    TreeItem parent = sel.getParentItem();
    if (parent == null) {
      parent = _root;
    }
    int idx = parent.getChildIndex(sel);

    if (!dig || !sel.getState()) {
      if (idx < parent.getChildCount() - 1) {
        _onSelection(parent.getChild(idx + 1), true, true);
      } else {
        _moveSelectionDown(parent, false);
      }
    } else if (sel.getChildCount() > 0) {
      _onSelection(sel.getChild(0), true, true);
    }
  }

  /**
   * Moves the selected item up one.
   */
  void _moveSelectionUp(TreeItem sel) {
    // Find a parent that is visible
    TreeItem topClosedParent = _getTopClosedParent(sel);
    if (topClosedParent != null) {
      _onSelection(topClosedParent, true, true);
      return;
    }

    TreeItem parent = sel.getParentItem();
    if (parent == null) {
      parent = _root;
    }
    int idx = parent.getChildIndex(sel);

    if (idx > 0) {
      TreeItem sibling = parent.getChild(idx - 1);
      _onSelection(_findDeepestOpenChild(sibling), true, true);
    } else {
      _onSelection(parent, true, true);
    }
  }

  void _onSelection(TreeItem item, bool fireEvents, bool moveFocus) {
    // 'root' isn't a real item, so don't let it be selected
    // (some cases in the keyboard handler will try to do this)
    if (item == _root) {
      return;
    }

    if (_curSelection != null) {
      _curSelection.setSelected(false);
    }
    _curSelection = item;

    if (_curSelection != null) {
      if (moveFocus) {
        _moveFocus();
      }
      // Select the item and fire the selection event.
      _curSelection.setSelected(true);
      if (fireEvents) {
        SelectionEvent.fire(this, _curSelection);
      }
    }
  }

  void _setImages(_ImageAdapter images, bool useLeafImages) {
    this._images = images;
    this._useLeafImages = useLeafImages;

    if (!useLeafImages) {
      Image image = images.treeLeaf().createImage();
      image.getElement().style.visibility = "hidden";
      RootPanel.get().add(image);
      int size = image.getWidth() + TreeItem.IMAGE_PAD;
      image.removeFromParent();
      _indentValue = "${size}px";
    }
  }

  void _showImage(TreeItem treeItem, AbstractImagePrototype proto) {
    dart_html.Element holder = treeItem.getImageHolderElement();
    dart_html.ImageElement child = Dom.getFirstChild(holder) as dart_html.ImageElement;
    if (child == null) {
      // If no image element has been created yet, create one from the
      // prototype.
      holder.append(proto.createElement());
    } else {
      // Otherwise, simply apply the prototype to the existing element.
      proto.applyToImageElement(child);
    }
  }

  void _updateAriaAttributes() {

    dart_html.Element curSelectionContentElem = _curSelection.getContentElem();

    // Set the 'aria-level' state. To do this, we need to compute the level of
    // the currently selected item.

    // We initialize itemLevel to -1 because the level value is zero-based.
    // Note that the root node is not a part of the TreeItem hierachy, and we
    // do not consider the root node to have a designated level. The level of
    // the root's children is level 0, its children's children is level 1, etc.

    int curSelectionLevel = -1;
    TreeItem tempItem = _curSelection;

    while (tempItem != null) {
      tempItem = tempItem.getParentItem();
      ++curSelectionLevel;
    }

//    Roles.getTreeitemRole().setAriaLevelProperty(curSelectionContentElem, curSelectionLevel + 1);

    // Set the 'aria-setsize' and 'aria-posinset' states. To do this, we need to
    // compute the the number of siblings that the currently selected item has,
    // and the item's position among its siblings.

    TreeItem curSelectionParent = _curSelection.getParentItem();
    if (curSelectionParent == null) {
      curSelectionParent = _root;
    }

//    Roles.getTreeitemRole().setAriaSetsizeProperty(curSelectionContentElem,
//        curSelectionParent.getChildCount());

    int curSelectionIndex = curSelectionParent.getChildIndex(_curSelection);

//    Roles.getTreeitemRole().setAriaPosinsetProperty(curSelectionContentElem,
//        curSelectionIndex + 1);

    // Set the 'aria-expanded' state. This depends on the state of the currently
    // selected item.
    // If the item has no children, we remove the 'aria-expanded' state.

//    if (_curSelection.getChildCount() == 0) {
//      Roles.getTreeitemRole().removeAriaExpandedState(curSelectionContentElem);
//
//    } else {
//      Roles.getTreeitemRole().setAriaExpandedState(curSelectionContentElem,
//            ExpandedValue.of(_curSelection.getState()));
//    }

    // Make sure that 'aria-selected' is true.

//    Roles.getTreeitemRole().setAriaSelectedState(curSelectionContentElem,
//        SelectedValue.of(true));

    // Update the 'aria-activedescendant' state for the focusable element to
    // match the id of the currently selected item

//    Roles.getTreeRole().setAriaActivedescendantProperty(_focusable,
//        IdReference.of(Dom.getElementAttribute(curSelectionContentElem, "id")));
  }
}

/**
 * A ClientBundle that provides images for this widget.
 */
abstract class _TreeResource extends ClientBundle {

  /**
   * An image indicating a closed branch.
   */
  ImageResource treeClosed();

  /**
   * An image indicating a leaf.
   */
  ImageResource treeLeaf();

  /**
   * An image indicating an open branch.
   */
  ImageResource treeOpen();
}

/**
 * Default tree resources
 */
class _TreeResources implements _TreeResource {

  final Map<String, ImageResource> _resources;

  const String TREE_CLOSED = "treeClosed.gif";
  const String TREE_LEAF = "treeLeaf.gif";
  const String TREE_OPEN = "treeOpen.gif";

  _TreeResources() : _resources = new Map<String, ImageResource>();
  
  static _TreeResources _instance;
  
  static _TreeResources get DEFAULT_RESOURCES {
    if (_instance == null) {
      _instance = new _TreeResources();
    }
    return _instance;
  }

  Source get source {
    return new _TreeSource();
  }

  /**
   * An image indicating a closed branch.
   */
  ImageResource treeClosed() {
    if (!_resources.containsKey(TREE_CLOSED)) {
      _resources[TREE_CLOSED] = _getTreeImageResourcePrototype(TREE_CLOSED);
    }
    return _resources[TREE_CLOSED];
  }

  /**
   * An image indicating a leaf.
   */
  ImageResource treeLeaf() {
    if (!_resources.containsKey(TREE_LEAF)) {
      _resources[TREE_LEAF] = _getTreeImageResourcePrototype(TREE_LEAF);
    }
    return _resources[TREE_LEAF];
  }

  /**
   * An image indicating an open branch.
   */
  ImageResource treeOpen() {
    if (!_resources.containsKey(TREE_OPEN)) {
      _resources[TREE_OPEN] = _getTreeImageResourcePrototype(TREE_OPEN);
    }
    return _resources[TREE_OPEN];
  }

  ImageResourcePrototype _getTreeImageResourcePrototype(String name) {
    String uri = DWT.getModuleBaseURL() + "resource/images/" + name;
    ImageResourcePrototype imageResource = new ImageResourcePrototype(name, 
        UriUtils.fromTrustedString(uri), 0, 0, 16, 16, false, false);
    return imageResource;
  }
}


/**
 * Specifies the classpath location of the resource or resources associated
 * with the {@link ResourcePrototype}.
 */
class _TreeSource implements Source {
  List<String> value() {

  }
}

/**
 * There are several ways of configuring images for the Tree widget due to
 * deprecated APIs.
 */
class _ImageAdapter {
  AbstractImagePrototype _treeClosed;
  AbstractImagePrototype _treeLeaf;
  AbstractImagePrototype _treeOpen;

  _ImageAdapter([_TreeResource resources = null]) {
    if (resources == null) {
      resources = _TreeResources.DEFAULT_RESOURCES;
    }
    _treeClosed = AbstractImagePrototype.create(resources.treeClosed());
    _treeLeaf = AbstractImagePrototype.create(resources.treeLeaf());
    _treeOpen = AbstractImagePrototype.create(resources.treeOpen());
  }

  AbstractImagePrototype treeClosed() {
    return _treeClosed;
  }

  AbstractImagePrototype treeLeaf() {
    return _treeLeaf;
  }

  AbstractImagePrototype treeOpen() {
    return _treeOpen;
  }
}