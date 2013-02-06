//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * An item that can be contained within a
 * {@link com.google.gwt.user.client.ui.Tree}.
 *
 * Each tree item is assigned a unique Dom id in order to support ARIA. See
 * {@link com.google.gwt.user.client.ui.Accessibility} for more information.
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.TreeExample}
 * </p>
 */
class TreeItem extends UiObject implements IsTreeItem, HasTreeItems, HasHtml, HasSafeHtml {
  /*
   * For compatibility with UiBinder interface HasTreeItems should be declared
   * before HasHTML, so that children items and widgets are processed before
   * interpreting HTML.
   */

  /**
   * The margin applied to child items.
   */
  static double _CHILD_MARGIN = 16.0;

  // By not overwriting the default tree padding and spacing, we traditionally
  // added 7 pixels between our image and content.
  // <2>|<1>image<1>|<2>|<1>content
  // So to preserve the current spacing we must add a 7 pixel pad when no image
  // is supplied.
  static int IMAGE_PAD = 7;

  /**
   * The duration of the animation.
   */
  static int _ANIMATION_DURATION = 200;

  /**
   * The duration of the animation per child {@link TreeItem}. If the per item
   * duration times the number of child items is less than the duration above,
   * the smaller duration will be used.
   */
  static int _ANIMATION_DURATION_PER_ITEM = 75;

  /**
   * The static animation used to open {@link TreeItem TreeItems}.
   */
  static TreeItemAnimation _itemAnimation = new TreeItemAnimation();

  /**
   * The structured table to hold images.
   */

  static dart_html.Element _BASE_INTERNAL_ELEM;
  /**
   * The base tree item element that will be cloned.
   */
  static dart_html.Element _BASE_BARE_ELEM;

  static TreeItemImpl _impl = new TreeItemImpl(); //GWT.create(TreeItemImpl.class);

  List<TreeItem> _children;
  dart_html.Element _contentElem, _childSpanElem, _imageHolder;

  /**
   * Indicates that this item is a root item in a tree.
   */
  bool _isRoot;

  bool _open;
  TreeItem _parent;
  bool _selected;

  Object _userObject;

  Tree _tree;

  Widget _widget;

  TreeItem({this._isRoot : false, SafeHtml html, Widget widget}) {
    dart_html.Element elem = Dom.clone(_BASE_BARE_ELEM, true);
    setElement(elem);
    _contentElem = Dom.getFirstChild(elem);
    Dom.setElementAttribute(_contentElem, "id", Dom.createUniqueId());

    // The root item always has children.
    if (_isRoot) {
      initChildren();
    }

    // Check widget
    if (?widget) {
      setWidget(widget);
    }
  }

  /**
   * Adds a child tree item containing the specified html.
   *
   * @param itemHtml the item's HTML
   * @return the item that was added
   */
  TreeItem addSafeHtmlItem(SafeHtml itemHtml) {
    TreeItem ret = new TreeItem(html:itemHtml);
    addItem(ret);
    return ret;
  }

  /**
   * Adds another item as a child to this one.
   *
   * @param item the item to be added
   */
  void addItem(TreeItem item) {
    // If this is the item's parent, removing the item will affect the child
    // count.
    maybeRemoveItemFromParent(item);
    insertItem(getChildCount(), item);
  }

  /**
   * Adds another item as a child to this one.
   *
   * @param isItem the wrapper of item to be added
   */

  void addIsTreeItem(IsTreeItem isItem) {
    TreeItem item = isItem.asTreeItem();
    addItem(item);
  }

  /**
   * Adds a child tree item containing the specified widget.
   *
   * @param widget the widget to be added
   * @return the item that was added
   */

  TreeItem addWidgetItem(Widget widget) {
    TreeItem ret = new TreeItem(widget:widget);
    addItem(ret);
    return ret;
  }

  /**
   * Adds a child tree item containing the specified text.
   *
   * @param itemText the text of the item to be added
   * @return the item that was added
   */

  TreeItem addTextItem(String itemText) {
    TreeItem ret = new TreeItem();
    ret.text = itemText;
    addItem(ret);
    return ret;
  }


  TreeItem asTreeItem() {
    return this;
  }

  /**
   * Gets the child at the specified index.
   *
   * @param index the index to be retrieved
   * @return the item at that index
   */

  TreeItem getChild(int index) {
    if ((index < 0) || (index >= getChildCount())) {
      return null;
    }

    return _children[index];
  }

  /**
   * Gets the number of children contained in this item.
   *
   * @return this item's child count.
   */

  int getChildCount() {
    if (_children == null) {
      return 0;
    }
    return _children.length;
  }

  /**
   * Gets the index of the specified child item.
   *
   * @param child the child item to be found
   * @return the child's index, or <code>-1</code> if none is found
   */

  int getChildIndex(TreeItem child) {
    if (_children == null) {
      return -1;
    }
    return _children.indexOf(child);
  }


  String get html {
    return _contentElem.innerHtml;
  }

  /**
   * Gets this item's parent.
   *
   * @return the parent item
   */
  TreeItem getParentItem() {
    return _parent;
  }

  /**
   * Gets whether this item's children are displayed.
   *
   * @return <code>true</code> if the item is open
   */
  bool getState() {
    return _open;
  }


  String get text {
    return _contentElem.text;
  }

  /**
   * Gets the tree that contains this item.
   *
   * @return the containing tree
   */
  Tree getTree() {
    return _tree;
  }

  /**
   * Gets the user-defined object associated with this item.
   *
   * @return the item's user-defined object
   */
  Object getUserObject() {
    return _userObject;
  }

  /**
   * Gets the <code>Widget</code> associated with this tree item.
   *
   * @return the widget
   */
  Widget getWidget() {
    return _widget;
  }

  /**
   * Inserts a child tree item at the specified index containing the specified
   * html.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param itemHtml the item's HTML
   * @return the item that was added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  TreeItem insertSafeHtmlItem(int beforeIndex, SafeHtml itemHtml) {
    TreeItem ret = new TreeItem(html:itemHtml);
    insertItem(beforeIndex, ret);
    return ret;
  }

  /**
   * Inserts an item as a child to this one.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param item the item to be added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  void insertItem(int beforeIndex, TreeItem item) {
    // Detach item from existing parent.
    maybeRemoveItemFromParent(item);

    // Check the index after detaching in case this item was already the parent.
    int childCount = getChildCount();
    if (beforeIndex < 0 || beforeIndex > childCount) {
      throw new Exception("IndexOutOfBounds");
    }

    if (_children == null) {
      initChildren();
    }

    // Set the margin.
    // Use no margin on top-most items.
    double margin = _isRoot ? 0.0 : TreeItem._CHILD_MARGIN;
    if (LocaleInfo.getCurrentLocale().isRTL()) {
      item.getElement().style.marginRight = margin.toString().concat(Unit.PX.value);
    } else {
      item.getElement().style.marginLeft = margin.toString().concat(Unit.PX.value);
    }

    // Physical attach.
    dart_html.Element childContainer = _isRoot ? _tree.getElement() : _childSpanElem;
    if (beforeIndex == childCount) {
      childContainer.append(item.getElement());
    } else {
      dart_html.Element beforeElem = getChild(beforeIndex).getElement();
      childContainer.insertBefore(item.getElement(), beforeElem);
    }

    // Logical attach.
    // Explicitly set top-level items' parents to null if this is root.
    item.setParentItem(_isRoot ? null : this);
    _children.insertRange(beforeIndex, 1, item);

    // Adopt.
    item.setTree(_tree);

    if (!_isRoot && _children.length == 1) {
      updateState(false, false);
    }
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
    TreeItem ret = new TreeItem(widget:widget);
    insertItem(beforeIndex, ret);
    return ret;
  }

  /**
   * Inserts a child tree item at the specified index containing the specified
   * text.
   *
   * @param beforeIndex the index where the item will be inserted
   * @param itemText the item's text
   * @return the item that was added
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  TreeItem insertTextItem(int beforeIndex, String itemText) {
    TreeItem ret = new TreeItem();
    ret.text = itemText;
    insertItem(beforeIndex, ret);
    return ret;
  }

  /**
   * Determines whether this item is currently selected.
   *
   * @return <code>true</code> if it is selected
   */
  bool isSelected() {
    return _selected;
  }

  /**
   * Removes this item from its tree.
   */
  void remove() {
    if (_parent != null) {
      // If this item has a parent, remove self from it.
      _parent.removeItem(this);
    } else if (_tree != null) {
      // If the item has no parent, but is in the Tree, it must be a top-level
      // element.
      _tree.removeItem(this);
    }
  }

  /**
   * Removes one of this item's children.
   *
   * @param item the item to be removed
   */

  void removeItem(TreeItem item) {
    // Validate.
    if (_children == null || !_children.contains(item)) {
      return;
    }

    // Orphan.
    Tree oldTree = _tree;
    item.setTree(null);

    // Physical detach.
    if (_isRoot) {
      //oldTree.getElement().removeChild(item.getElement());
      item.getElement().remove();
    } else {
      //_childSpanElem.removeChild(item.getElement());
      item.getElement().remove();
    }

    // Logical detach.
    item.setParentItem(null);
    _children.remove(item);

    if (!_isRoot && _children.length == 0) {
      updateState(false, false);
    }
  }

  /**
   * Removes one of this item's children.
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
   * Removes all of this item's children.
   */

  void removeItems() {
    while (getChildCount() > 0) {
      removeItem(getChild(0));
    }
  }


  void set html(String val) {
    setWidget(null);
    _contentElem.innerHtml = val;
  }


  void setSafeHtml(SafeHtml val) {
    html = val.asString();
  }

  /**
   * Selects or deselects this item.
   *
   * @param selected <code>true</code> to select the item, <code>false</code> to
   *          deselect it
   */
  void setSelected(bool selected) {
    if (this._selected == selected) {
      return;
    }
    this._selected = selected;
    UiObject.manageElementStyleName(getContentElem(), "gwt-TreeItem-selected", selected);
  }

  /**
   * Sets whether this item's children are displayed.
   *
   * @param open whether the item is open
   * @param fireEvents <code>true</code> to allow open/close events to be
   */
  void setState(bool open, [bool fireEvents = true]) {
    if (open && getChildCount() == 0) {
      return;
    }

    // Only do the physical update if it changes
    if (this._open != open) {
      this._open = open;
      updateState(true, true);

      if (fireEvents && _tree != null) {
        _tree.fireStateChanged(this, open);
      }
    }
  }


  void set text(String val) {
    setWidget(null);
    _contentElem.text = val;
  }

  /**
   * Sets the user-defined object associated with this item.
   *
   * @param userObj the item's user-defined object
   */
  void setUserObject(Object userObj) {
    _userObject = userObj;
  }

  /**
   * Sets the current widget. Any existing child widget will be removed.
   *
   * @param newWidget Widget to set
   */
  void setWidget(Widget newWidget) {
    // Detach new child from old parent.
    if (newWidget != null) {
      newWidget.removeFromParent();
    }

    // Detach old child from _tree.
    if (_widget != null) {
      try {
        if (_tree != null) {
          _tree.orphan(_widget);
        }
      } finally {
        // Physical detach old child.
        //_contentElem.removeChild(_widget.getElement());
        _widget.getElement().remove();
        _widget = null;
      }
    }

    // Clear out any existing content before adding a widget.
    _contentElem.innerHtml = "";

    // Logical detach old/attach new.
    _widget = newWidget;

    if (newWidget != null) {
      // Physical attach new.
      _contentElem.append(newWidget.getElement());

      // Attach child to tree.
      if (_tree != null) {
        _tree.adopt(_widget, this);
      }

      // Set tabIndex on the widget to -1, so that it doesn't mess up the tab
      // order of the entire tree

      if (Tree.shouldTreeDelegateFocusToElement(_widget.getElement())) {
        _widget.getElement().tabIndex = -1;
      }
    }
  }

  /**
   * Returns a suggested {@link Focusable} instance to use when this tree item
   * is selected. The tree maintains focus if this method returns null. By
   * default, if the tree item contains a focusable widget, that widget is
   * returned.
   *
   * Note, the {@link Tree} will ignore this value if the user clicked on an
   * input element such as a button or text area when selecting this item.
   *
   * @return the focusable item
   */
  Focusable getFocusable() {
    Widget w = getWidget();
    if (w is Focusable) {
      return w as Focusable;
    }
    return null;
  }

  void addTreeItems(List<TreeItem> accum) {
    int size = getChildCount();
    for (int i = 0; i < size; i++) {
      TreeItem item = _children[i];
      accum.add(item);
      item.addTreeItems(accum);
    }
  }

  List<TreeItem> getChildren() {
    return _children;
  }

  dart_html.Element getContentElem() {
    return _contentElem;
  }

  dart_html.Element getImageElement() {
    return Dom.getFirstChild(getImageHolderElement());
  }

  dart_html.Element getImageHolderElement() {
    if (!isFullNode()) {
      convertToFullNode();
    }
    return _imageHolder;
  }

  void initChildren() {
    convertToFullNode();
    _childSpanElem = new dart_html.DivElement();
    getElement().append(_childSpanElem);
    _childSpanElem.style.whiteSpace = "nowrap";
    _children = new List<TreeItem>();
  }

  bool isFullNode() {
    return _imageHolder != null;
  }

  /**
   * Remove a tree item from its parent if it has one.
   *
   * @param item the tree item to remove from its parent
   */
  void maybeRemoveItemFromParent(TreeItem item) {
    if ((item.getParentItem() != null) || (item.getTree() != null)) {
      item.remove();
    }
  }

  void setParentItem(TreeItem parent) {
    this._parent = parent;
  }

  void setTree(Tree newTree) {
    // Early out.
    if (_tree == newTree) {
      return;
    }

    // Remove this item from existing tree.
    if (_tree != null) {
      if (_tree.getSelectedItem() == this) {
        _tree.setSelectedItem(null);
      }

      if (_widget != null) {
        _tree.orphan(_widget);
      }
    }

    _tree = newTree;
    for (int i = 0, n = getChildCount(); i < n; ++i) {
      _children[i].setTree(newTree);
    }
    updateState(false, true);

    if (newTree != null) {
      if (_widget != null) {
        // Add my _widget to the new tree.
        newTree.adopt(_widget, this);
      }
    }
  }

  void updateState(bool animate, bool updateTreeSelection) {
    // If the tree hasn't been set, there is no visual state to update.
    // If the tree is not attached, then update will be called on attach.
    if (_tree == null || _tree.isAttached() == false) {
      return;
    }

    if (getChildCount() == 0) {
      if (_childSpanElem != null) {
        UiObject.setVisible(_childSpanElem, false);
      }
      _tree.showLeafImage(this);
      return;
    }

    // We must use 'display' rather than 'visibility' here,
    // or the children will always take up space.
    if (animate && (_tree != null) && (_tree.isAttached())) {
      _itemAnimation.setItemState(this, _tree.isAnimationEnabled());
    } else {
      _itemAnimation.setItemState(this, false);
    }

    // Change the status image
    if (_open) {
      _tree.showOpenImage(this);
    } else {
      _tree.showClosedImage(this);
    }

    // We may need to update the tree's selection in response to a tree state
    // change. For example, if the tree's currently selected item is a
    // descendant of an item whose branch was just collapsed, then the item
    // itself should become the newly-selected item.
    if (updateTreeSelection) {
      _tree.maybeUpdateSelection(this, this._open);
    }
  }

  void updateStateRecursive() {
    updateStateRecursiveHelper();
    _tree.maybeUpdateSelection(this, this._open);
  }

  void convertToFullNode() {
    _impl.convertToFullNode(this);
  }

  void updateStateRecursiveHelper() {
    updateState(false, false);
    for (int i = 0, n = getChildCount(); i < n; ++i) {
      _children[i].updateStateRecursiveHelper();
    }
  }
}

/**
 * Implementation class for {@link TreeItem}.
 */
class TreeItemImpl {
  TreeItemImpl() {
    initializeClonableElements();
  }

  void convertToFullNode(TreeItem item) {
    if (item._imageHolder == null) {
      // Extract the Elements from the object
      dart_html.Element itemTable = Dom.clone(TreeItem._BASE_INTERNAL_ELEM, true);
      item.getElement().append(itemTable);
      dart_html.Element tr = Dom.getFirstChild(Dom.getFirstChild(itemTable));
      dart_html.Element tdImg = Dom.getFirstChild(tr);
      dart_html.Element tdContent = tdImg.nextElementSibling;

      // Undoes padding from table element.
      item.getElement().style.padding = "0px";
      tdContent.append(item._contentElem);
      item._imageHolder = tdImg;
    }
  }

  /**
   * Setup clonable elements.
   */
  void initializeClonableElements() {
    // Create the base table element that will be cloned.
    TreeItem._BASE_INTERNAL_ELEM = new dart_html.TableElement();
    dart_html.Element contentElem = new dart_html.DivElement();
    dart_html.Element tbody = (TreeItem._BASE_INTERNAL_ELEM as dart_html.TableElement).createTBody();
    dart_html.Element tr = new dart_html.TableRowElement();
    dart_html.Element tdImg = new dart_html.TableCellElement(), tdContent = new dart_html.TableCellElement();
    TreeItem._BASE_INTERNAL_ELEM.append(tbody);
    tbody.append(tr);
    tr.append(tdImg);
    tr.append(tdContent);
    tdImg.style.verticalAlign = "middle";
    tdContent.style.verticalAlign = "middle";
    tdContent.append(contentElem);
    contentElem.style.display = "inline";
    UiObject.setElementStyleName(contentElem, "gwt-TreeItem");
    TreeItem._BASE_INTERNAL_ELEM.style.whiteSpace = "nowrap";

    // Create the base element that will be cloned
    TreeItem._BASE_BARE_ELEM = new dart_html.DivElement();

    // Simulates padding from table element.
    TreeItem._BASE_BARE_ELEM.style.padding = "3px";
    TreeItem._BASE_BARE_ELEM.append(contentElem);
//    Roles.getTreeitemRole().set(contentElem);
  }
}

/**
 * IE specific implementation class for {@link TreeItem}.
 */
class TreeItemImplIE6 extends TreeItemImpl {
  void convertToFullNode(TreeItem item) {
    super.convertToFullNode(item);
    item.getElement().style.marginBottom = "0px";
  }
}

/**
 * An {@link Animation} used to open the child elements. If a {@link TreeItem}
 * is in the process of opening, it will immediately be opened and the new
 * {@link TreeItem} will use this animation.
 */
class TreeItemAnimation extends Animation {

  /**
   * The {@link TreeItem} currently being affected.
   */
  TreeItem _curItem = null;

  /**
   * Whether the item is being opened or closed.
   */
  bool _opening = true;

  /**
   * The target height of the child items.
   */
  int _scrollHeight = 0;

  TreeItemAnimation([AnimationScheduler scheduler = null]) : super(scheduler);

  /**
   * Open the specified {@link TreeItem}.
  *
   * @param item the {@link TreeItem} to open
   * @param animate true to animate, false to open instantly
   */
  void setItemState(TreeItem item,  animate) {
    // Immediately complete previous open
    cancel();

    // Open the new item
    if (animate) {
      _curItem = item;
      _opening = item._open;
      run(dart_math.min(TreeItem._ANIMATION_DURATION, TreeItem._ANIMATION_DURATION_PER_ITEM
                   * _curItem.getChildCount()));
    } else {
      UiObject.setVisible(item._childSpanElem, item._open);
    }
  }


  void onComplete() {
    if (_curItem != null) {
      if (_opening) {
        UiObject.setVisible(_curItem._childSpanElem, true);
        onUpdate(1.0);
        Dom.setStyleAttribute(_curItem._childSpanElem, "height", "auto");
      } else {
        UiObject.setVisible(_curItem._childSpanElem, false);
      }
      Dom.setStyleAttribute(_curItem._childSpanElem, "overflow", "visible");
      Dom.setStyleAttribute(_curItem._childSpanElem, "width", "auto");
      _curItem = null;
    }
  }


  void onStart() {
    _scrollHeight = 0;

    // If the TreeItem is already open, we can get its scrollHeight
    // immediately.
    if (!_opening) {
      _scrollHeight = _curItem._childSpanElem.scrollHeight;
    }
    Dom.setStyleAttribute(_curItem._childSpanElem, "overflow", "hidden");

    // If the TreeItem is already open, onStart will set its height to its
    // natural height. If the TreeItem is currently closed, onStart will set
    // its height to 1px (see onUpdate below), and then we make the TreeItem
    // visible so we can get its correct scrollHeight.
    super.onStart();

    // If the TreeItem is currently closed, we need to make it visible before
    // we can get its height.
    if (_opening) {
      UiObject.setVisible(_curItem._childSpanElem, true);
      _scrollHeight = _curItem._childSpanElem.scrollHeight;
    }
  }


  void onUpdate(double progress) {
    int height = (progress * _scrollHeight).toInt();
    if (!_opening) {
      height = _scrollHeight - height;
    }

    // Issue 2338: If the height is 0px, IE7 will display all of the children
    // instead of hiding them completely.
    height = dart_math.max(height, 1);

    _curItem._childSpanElem.style.height = "$height px";

    // We need to set the width explicitly of the item might be cropped
    int scrollWidth = Dom.getElementPropertyInt(_curItem._childSpanElem, "scrollWidth");
    _curItem._childSpanElem.style.width = "$scrollWidth px";
  }
}