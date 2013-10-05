//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that stacks its children vertically, displaying only one at a time,
 * with a header for each child which the user can click to display.
 *
 * <p>
 * This widget will <em>only</em> work in standards mode, which requires that
 * the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-StackLayoutPanel <dd> the panel itself
 * <dt>.gwt-StackLayoutPanel .gwt-StackLayoutPanelHeader <dd> applied to each
 * header widget
 * <dt>.gwt-StackLayoutPanel .gwt-StackLayoutPanelHeader-hovering <dd> applied to each
 * header widget on mouse hover
 * <dt>.gwt-StackLayoutPanel .gwt-StackLayoutPanelContent <dd> applied to each
 * child widget
 * </dl>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.StackLayoutPanelExample}
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * A StackLayoutPanel element in a
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} template may have a
 * <code>unit</code> attribute with a
 * {@link com.google.gwt.dom.client.Style.Unit Style.Unit} value (it defaults to
 * PX).
 * <p>
 * The children of a StackLayoutPanel element are laid out in &lt;g:stack>
 * elements. Each stack can have one widget child and one of two types of header
 * elements. A &lt;g:header> element can hold html, or a &lt;g:customHeader>
 * element can hold a widget. (Note that the tags of the header elements are not
 * capitalized. This is meant to signal that the head is not a runtime object,
 * and so cannot have a <code>ui:field</code> attribute.)
 * <p>
 * For example:
 *
 * <pre>
 * &lt;g:StackLayoutPanel unit='PX'>
 *  &lt;g:stack>
 *    &lt;g:header size='3'>&lt;b>HTML&lt;/b> header&lt;/g:header>
 *    &lt;g:Label>able&lt;/g:Label>
 *  &lt;/g:stack>
 *  &lt;g:stack>
 *    &lt;g:customHeader size='3'>
 *      &lt;g:Label>Custom header&lt;/g:Label>
 *    &lt;/g:customHeader>
 *    &lt;g:Label>baker&lt;/g:Label>
 *  &lt;/g:stack>
 * &lt;/g:StackLayoutPanel>
 * </pre>
 */
class StackLayoutPanel extends ResizeComposite implements HasWidgets,
  ProvidesResize, IndexedPanelForIsWidget, AnimatedLayout,
  HasBeforeSelectionHandlers<int>, HasSelectionHandlers<int> {

  static final String _WIDGET_STYLE = "dwt-StackLayoutPanel";
  static final String _CONTENT_STYLE = "dwt-StackLayoutPanelContent";
  static final String _HEADER_STYLE = "dwt-StackLayoutPanelHeader";
  static final String _HEADER_STYLE_HOVERING = "dwt-StackLayoutPanelHeader-hovering";

  static final int _ANIMATION_TIME = 250;

  int _animationDuration = _ANIMATION_TIME;
  LayoutPanel layoutPanel;
  final Unit _unit;
  final List<_LayoutData> _layoutData = new List<_LayoutData>();
  int _selectedIndex = -1;

  /**
   * Creates an empty stack panel.
   *
   * @param unit the unit to be used for layout
   */
  StackLayoutPanel(this._unit) : layoutPanel = new LayoutPanel() {
    initWidget(layoutPanel);
    clearAndSetStyleName(_WIDGET_STYLE);
  }

  void add(Widget w) {
    assert (false); // : "Single-argument add() is not supported for this widget";
  }

  /**
   * Adds a child widget to this stack, along with a widget representing the
   * stack header.
   *
   * @param widget the child widget to be added
   * @param header the text to be shown on its header
   * @param asHtml <code>true</code> to treat the specified text as HTML
   * @param headerSize the size of the header widget
   */
  void addWidget(Widget widget, String header, bool asHtml, double headerSize) {
    insertAsText(widget, header, asHtml, headerSize, getWidgetCount());
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #add(Widget,String,boolean,double)
   */
  void addIsWidget(IsWidget widget, String header, bool asHtml, double headerSize) {
    this.addWidget(widget.asWidget(), header, asHtml, headerSize);
  }

  HandlerRegistration addBeforeSelectionHandler(BeforeSelectionHandler<int> handler) {
    return addHandler(handler, BeforeSelectionEvent.TYPE);
  }

  HandlerRegistration addSelectionHandler(SelectionHandler<int> handler) {
    return addHandler(handler, SelectionEvent.TYPE);
  }

  void animate(int duration, [LayoutAnimationCallback callback = null]) {
    // Don't try to animate zero widgets.
    if (_layoutData.length == 0) {
      if (callback != null) {
        callback.onAnimationComplete();
      }
      return;
    }

    double top = 0.0, bottom = 0.0;
    int i = 0;
    for (; i < _layoutData.length; ++i) {
      _LayoutData data = _layoutData[i];
      layoutPanel.setWidgetTopHeight(data.header, top, _unit, data.headerSize,
          _unit);

      top += data.headerSize;

      layoutPanel.setWidgetTopHeight(data.widget, top, _unit, 0.0, _unit);

      if (i == _selectedIndex) {
        break;
      }
    }

    for (int j = _layoutData.length - 1; j > i; --j) {
      _LayoutData data = _layoutData[j];
      layoutPanel.setWidgetBottomHeight(data.header, bottom, _unit, data.headerSize, _unit);
      layoutPanel.setWidgetBottomHeight(data.widget, bottom, _unit, 0.0, _unit);
      bottom += data.headerSize;
    }

    _LayoutData data = _layoutData[_selectedIndex];
    layoutPanel.setWidgetTopBottom(data.widget, top, _unit, bottom, _unit);

    layoutPanel.animate(duration, callback);
  }

  void clear() {
    layoutPanel.clear();
    _layoutData.clear();
    _selectedIndex = -1;
  }

  void forceLayout() {
    layoutPanel.forceLayout();
  }

  /**
   * Get the duration of the animated transition between children.
   *
   * @return the duration in milliseconds
   */
  int getAnimationDuration() {
    return _animationDuration;
  }

  /**
   * Gets the widget in the stack header at the given index.
   *
   * @param index the index of the stack header to be retrieved
   * @return the header widget
   */
  Widget getHeaderWidgetAt(int index) {
    checkIndex(index);
    return _layoutData[index].header.getWidget();
  }

  /**
   * Gets the widget in the stack header associated with the given child widget.
   *
   * @param child the child whose stack header is to be retrieved
   * @return the header widget
   */
  Widget getHeaderWidget(Widget child) {
    checkChild(child);
    return getHeaderWidgetAt(getWidgetIndex(child));
  }

  /**
   * Gets the currently-selected index.
   *
   * @return the selected index, or <code>-1</code> if none is selected
   */
  int getVisibleIndex() {
    return _selectedIndex;
  }

  /**
   * Gets the currently-selected widget.
   *
   * @return the selected widget, or <code>null</code> if none exist
   */
  Widget getVisibleWidget() {
    if (_selectedIndex == -1) {
      return null;
    }
    return getWidgetAt(_selectedIndex);
  }

  Widget getWidgetAt(int index) {
    return layoutPanel.getWidgetAt(index * 2 + 1);
  }

  int getWidgetCount() {
    return layoutPanel.getWidgetCount() ~/ 2;
  }

  int getWidgetIndexIsWidget(IsWidget child) {
    return getWidgetIndex(Widget.asWidgetOrNull(child));
  }

  int getWidgetIndex(Widget child) {
    int index = layoutPanel.getWidgetIndex(child);
    if (index == -1) {
      return index;
    }
    return (index - 1) ~/ 2;
  }

  /**
   * Inserts a widget into the panel. If the Widget is already attached, it will
   * be moved to the requested index.
   *
   * @param child the widget to be added
   * @param text the text to be shown on its header
   * @param asHtml <code>true</code> to treat the specified text as HTML
   * @param headerSize the size of the header widget
   * @param beforeIndex the index before which it will be inserted
   */
  void insertAsText(Widget child, String text, bool asHtml, double headerSize, int beforeIndex) {
    Html contents = new Html();
    if (asHtml) {
      contents.html = text;
    } else {
      contents.text = text;
    }
    insert(child, new _Header(contents), headerSize, beforeIndex);
  }

  Iterator<Widget> iterator() {
    return new _Iterator(this);
  }

  void onResize() {
    layoutPanel.onResize();
  }

  bool removeAt(int index) {
    return remove(getWidgetAt(index));
  }

  bool remove(Widget child) {
    if (child.getParent() != layoutPanel) {
      return false;
    }

    // Find the layoutData associated with this widget and remove it.
    for (int i = 0; i < _layoutData.length; ++i) {
      _LayoutData data = _layoutData[i];
      if (data.widget == child) {
        layoutPanel.remove(data.header);
        layoutPanel.remove(data.widget);

        data.header.removeStyleName(_HEADER_STYLE);
        data.widget.removeStyleName(_CONTENT_STYLE);

        _layoutData.removeAt(i);

        if (_selectedIndex == i) {
          _selectedIndex = -1;
          if (_layoutData.length > 0) {
            showWidgetAt(getWidgetIndex(_layoutData[0].widget));
          }
        } else {
          if (i <= _selectedIndex) {
            _selectedIndex--;
          }
          animate(_animationDuration);
        }
        return true;
      }
    }

    return false;
  }

  /**
   * Set the duration of the animated transition between children.
   *
   * @param duration the duration in milliseconds.
   */
  void setAnimationDuration(int duration) {
    this._animationDuration = duration;
  }

  /**
   * Sets a stack header's HTML contents.
   *
   * Use care when setting an object's HTML; it is an easy way to expose
   * script-based security problems. Consider using
   * {@link #setHeaderHTML(int, SafeHtml)} or
   * {@link #setHeaderText(int, String)} whenever possible.
   *
   * @param index the index of the header whose HTML is to be set
   * @param html the header's new HTML contents
   */
  void setHeaderHtml(int index, String html) {
    checkIndex(index);
    _LayoutData data = _layoutData[index];

    Widget headerWidget = data.header.getWidget();
    assert (headerWidget is HasHtml); // : "Header widget does not implement HasHTML";
    (headerWidget as HasHtml).html = html;
  }

  /**
   * Sets a stack header's text contents.
   *
   * @param index the index of the header whose text is to be set
   * @param text the object's new text
   */
  void setHeaderText(int index, String text) {
    checkIndex(index);
    _LayoutData data = _layoutData[index];

    Widget headerWidget = data.header.getWidget();
    assert (headerWidget is HasText); // : "Header widget does not implement HasText";
    (headerWidget as HasText).text = text;
  }

  /**
   * Shows the specified widget.
   *
   * @param child the child widget to be shown.
   * @param fireEvents true to fire events, false not to
   */
  void showWidget(Widget child, [bool fireEvents = false]) {
    showWidgetAt(getWidgetIndex(child), _animationDuration, fireEvents);
  }

  void onLoad() {
    // When the widget becomes attached, update its layout.
    animate(0);
  }

  void checkChild(Widget child) {
    assert (layoutPanel.getChildren().contains(child));
  }

  void checkIndex(int index) {
    assert ((index >= 0) && (index < getWidgetCount())); // : "Index out of bounds";
  }

  void insert(Widget child, _Header header, double headerSize, int beforeIndex) {
    assert ((beforeIndex >= 0) && (beforeIndex <= getWidgetCount())); // : "beforeIndex out of bounds";

    // Check to see if the StackPanel already contains the Widget. If so,
    // remove it and see if we need to shift the position to the left.
    int idx = getWidgetIndex(child);
    if (idx != -1) {
      remove(child);
      if (idx < beforeIndex) {
        beforeIndex--;
      }
    }

    int widgetIndex = beforeIndex * 2;
    layoutPanel.insertAt(child, widgetIndex);
    layoutPanel.insertAt(header, widgetIndex);

    layoutPanel.setWidgetLeftRight(header, 0.0, Unit.PX, 0.0, Unit.PX);
    layoutPanel.setWidgetLeftRight(child, 0.0, Unit.PX, 0.0, Unit.PX);

    _LayoutData data = new _LayoutData(child, header, headerSize);
    if (beforeIndex < _layoutData.length) {
//      _layoutData.insertRange(beforeIndex, 1);
//      _layoutData[beforeIndex] = data;
      _layoutData.insert(beforeIndex, data);
    } else {
      _layoutData.add(data);
    }

    header.addStyleName(_HEADER_STYLE);
    child.addStyleName(_CONTENT_STYLE);

    header.addClickHandler(new ClickHandlerAdapter((ClickEvent event) {
        showWidget(child);
    }));

    header.addMouseOutHandler(new MouseOutHandlerAdapter((MouseOutEvent event) {
        header.removeStyleName(_HEADER_STYLE_HOVERING);
    }));

    header.addMouseOverHandler(new MouseOverHandlerAdapter((MouseOverEvent event) {
        header.addStyleName(_HEADER_STYLE_HOVERING);
    }));

    if (_selectedIndex == -1) {
      // If there's no visible widget, display the first one. The layout will
      // be updated onLoad().
      showWidgetAt(0);
    } else if (beforeIndex <= _selectedIndex) {
      // If we inserted an item before the selected index, increment it.
      _selectedIndex++;
    }

    // If the widget is already attached, we must call animate() to update the
    // layout (if it's not yet attached, then onLoad() will do this).
    if (isAttached()) {
      animate(_animationDuration);
    }
  }

  void showWidgetAt(int index, [int duration = null, bool fireEvents = false]) {
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

    _selectedIndex = index;

    if (isAttached()) {
      animate(duration == null ? _animationDuration : duration);
    }

    // Fire the selection event.
    if (fireEvents) {
      SelectionEvent.fire(this, index);
    }
  }
}

class _Header extends Composite implements HasClickHandlers {

  _Header(Widget child) {
    initWidget(child);
  }

  HandlerRegistration addClickHandler(ClickHandler handler) {
    return this.addDomHandler(handler, ClickEvent.TYPE);
  }

  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
    return this.addDomHandler(handler, MouseOutEvent.TYPE);
  }

  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
    return this.addDomHandler(handler, MouseOverEvent.TYPE);
  }
}

class _LayoutData {

  double headerSize;
  _Header header;
  Widget widget;

  _LayoutData(this.widget, this.header, this.headerSize);
}

class _Iterator extends Iterator<Widget> {

  int i = 0, last = -1;
  StackLayoutPanel _panel;

  _Iterator(this._panel);

  bool moveNext() {
    return i < _panel._layoutData.length;
  }

  Widget get current => _getCurrent();

  Widget _getCurrent() {
    if (!moveNext()) {
      throw new Exception("NoSuchElement");
    }
    return _panel._layoutData[last = i++].widget;
  }

  void remove() {
    if (last < 0) {
      throw new Exception("IllegalState");
    }

    _panel.remove(_panel._layoutData[last].widget);
    i = last;
    last = -1;
  }
}