//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that includes a header (top), footer (bottom), and content (middle)
 * area. The header and footer areas resize naturally. The content area is
 * allocated all of the remaining space between the header and footer area.
 */
class HeaderPanel extends Panel implements RequiresResize {

  Widget _content;
  dart_html.Element _contentContainer;
  Widget _footer;
  dart_html.Element _footerContainer;
  ResizeLayoutPanelImpl _footerImpl;
  Widget _header;
  dart_html.Element _headerContainer;
  ResizeLayoutPanelImpl _headerImpl;
  ScheduledCommand _layoutCmd;
  bool _layoutScheduled = false;

  HeaderPanel() {
    _layoutCmd = new HeaderPanelScheduledCommand(this);
    // Create the outer element
    dart_html.DivElement elem = new dart_html.DivElement();
    elem.style.position = Position.RELATIVE.value;
    elem.style.overflow = Overflow.HIDDEN.value;
    setElement(elem);

    _footerImpl = new ResizeLayoutPanelImpl.browserDependent();
    _headerImpl = new ResizeLayoutPanelImpl.browserDependent();

    // Create a delegate to handle resize from the header and footer.
    ResizeDelegate resizeDelegate = new HeaderPanelResizeDelegate(this);

    // Create the header container.
    _headerContainer = _createContainer();
    _headerContainer.style.top = "0.0".concat(Unit.PX.value);
    _headerImpl.init(_headerContainer, resizeDelegate);
    elem.append(_headerContainer);

    // Create the footer container.
    _footerContainer = _createContainer();
    _footerContainer.style.bottom = "0.0".concat(Unit.PX.value);
    _footerImpl.init(_footerContainer, resizeDelegate);
    elem.append(_footerContainer);

    // Create the content container.
    _contentContainer = _createContainer();
    _contentContainer.style.overflow = Overflow.HIDDEN.value;
    _contentContainer.style.top = "0.0".concat(Unit.PX.value);
    _contentContainer.style.height = "0.0".concat(Unit.PX.value);
    elem.append(_contentContainer);
  }

  //*********
  // Children
  //*********

  /**
   * Adds a widget to this panel.
   *
   * @param w the child widget to be added
   */
  void add(Widget w) {
    // Add widgets in the order that they appear.
    if (_header == null) {
      setHeaderWidget(w);
    } else if (_content == null) {
      setContentWidget(w);
    } else if (_footer == null) {
      setFooterWidget(w);
    } else {
      throw new Exception("HeaderPanel already contains header, content, and footer widgets.");
    }
  }

  bool remove(Widget w) {
    // Validate.
    if (w.getParent() != this) {
      return false;
    }
    // Orphan.
    try {
      orphan(w);
    } finally {
      // Physical detach.
      w.getElement().remove();

      // Logical detach.
      if (w == _content) {
        _content = null;
        _contentContainer.style.display = Display.NONE.value;
      } else if (w == _header) {
        _header = null;
        _headerContainer.style.display = Display.NONE.value;
      } else if (w == _footer) {
        _footer = null;
        _footerContainer.style.display = Display.NONE.value;
      }
    }
    return true;
  }

  //********
  // Content
  //********

  /**
   * Get the content widget that appears between the header and footer.
   *
   * @return the content {@link Widget}
   */
  Widget getContentWidget() {
    return _content;
  }

  /**
   * Set the widget in the content portion between the header and footer.
   *
   * @param w the widget to use as the content
   */
  void setContentWidget(Widget w) {
    _contentContainer.style.display = "";
    _add(w, _content, _contentContainer);

    // Logical attach.
    _content = w;
    _scheduledLayout();
  }

  /**
   * Get the footer widget at the bottom of the panel.
   *
   * @return the footer {@link Widget}
   */
  Widget getFooterWidget() {
    return _footer;
  }

  /**
   * Set the widget in the footer portion at the bottom of the panel.
   *
   * @param w the widget to use as the footer
   */
  void setFooterWidget(Widget w) {
    _footerContainer.style.display = "";
    _add(w, _footer, _footerContainer);

    // Logical attach.
    _footer = w;
    _scheduledLayout();
  }

  /**
   * Get the header widget at the top of the panel.
   *
   * @return the header {@link Widget}
   */
  Widget getHeaderWidget() {
    return _header;
  }

  /**
   * Set the widget in the header portion at the top of the panel.
   *
   * @param w the widget to use as the header
   */
  void setHeaderWidget(Widget w) {
    _headerContainer.style.display = "";
    _add(w, _header, _headerContainer);

    // Logical attach.
    _header = w;
    _scheduledLayout();
  }

  /**
   * Add a widget to the panel in the specified container. Note that this method
   * does not do the logical attach.
   *
   * @param w the widget to add
   * @param toReplace the widget to replace
   * @param container the container in which to place the widget
   */
  void _add(Widget w, Widget toReplace, dart_html.Element container) {
    // Validate.
    if (w == toReplace) {
      return;
    }

    // Detach new child.
    if (w != null) {
      w.removeFromParent();
    }

    // Remove old child.
    if (toReplace != null) {
      remove(toReplace);
    }

    if (w != null) {
      // Physical attach.
      container.append(w.getElement());

      adopt(w);
    }
  }

  dart_html.Element _createContainer() {
    dart_html.DivElement container = new dart_html.DivElement();
    container.style.position = Position.ABSOLUTE.value;
    container.style.display = Display.NONE.value;
    container.style.left = "0.0".concat(Unit.PX.value);
    container.style.width = "100.0".concat(Unit.PX.value);
    return container;
  }

  Iterator<Widget> iterator() {
    return new FiniteWidgetIterator(new _WidgetProviderImpl(this), 3);
  }

  //************
  // Attachments
  //************

  /**
   * <p>
   * This method is called when a widget is attached to the browser's document.
   * To receive notification after a Widget has been added to the document,
   * override the {@link #onLoad} method or use {@link #addAttachHandler}.
   * </p>
   * <p>
   * It is strongly recommended that you override {@link #onLoad()} or
   * {@link #doAttachChildren()} instead of this method to avoid inconsistencies
   * between logical and physical attachment states.
   * </p>
   * <p>
   * Subclasses that override this method must call
   * <code>super.onAttach()</code> to ensure that the Widget has been attached
   * to its underlying Element.
   * </p>
   *
   * @throws IllegalStateException if this widget is already attached
   * @see #onLoad()
   * @see #doAttachChildren()
   */
  void onAttach() {
    super.onAttach();
    _headerImpl.onAttach();
    _footerImpl.onAttach();
    _scheduledLayout();
  }

  /**
   * <p>
   * This method is called when a widget is detached from the browser's
   * document. To receive notification before a Widget is removed from the
   * document, override the {@link #onUnload} method or use {@link #addAttachHandler}.
   * </p>
   * <p>
   * It is strongly recommended that you override {@link #onUnload()} or
   * {@link #doDetachChildren()} instead of this method to avoid inconsistencies
   * between logical and physical attachment states.
   * </p>
   * <p>
   * Subclasses that override this method must call
   * <code>super.onDetach()</code> to ensure that the Widget has been detached
   * from the underlying Element. Failure to do so will result in application
   * memory leaks due to circular references between DOM Elements and JavaScript
   * objects.
   * </p>
   *
   * @throws IllegalStateException if this widget is already detached
   * @see #onUnload()
   * @see #doDetachChildren()
   */
  void onDetach() {
    super.onDetach();
    _headerImpl.onDetach();
    _footerImpl.onDetach();
  }

  //*********************************
  // Implementation of RequiresResize
  //*********************************

  /**
   * This method must be called whenever the implementor's size has been
   * modified.
   */
  void onResize() {
    // Handle the outer element resizing.
    _scheduledLayout();
  }

  //*******
  // Layout
  //*******

  /**
   * Update the layout.
   */
  void _forceLayout() {
    // No sense in doing layout if we aren't attached or have no content.
    if (!isAttached() || _content == null) {
      return;
    }

    // Resize the content area to fit between the header and footer.
    int remainingHeight = getElement().clientHeight;
    if (_header != null) {
      int height = dart_math.max(0, _headerContainer.offsetHeight);
      remainingHeight -= height;
      _contentContainer.style.top = height.toString().concat(Unit.PX.value);
    } else {
      _contentContainer.style.top = "0.0".concat(Unit.PX.value);
    }
    if (_footer != null) {
      remainingHeight -= _footerContainer.offsetHeight;
    }
    _contentContainer.style.height = dart_math.max(0, remainingHeight).toString().concat(Unit.PX.value);

    // Provide resize to child.
    if (_content is RequiresResize) {
      (_content as RequiresResize).onResize();
    }
  }

  /**
   * Schedule layout to adjust the height of the content area.
   */
  void _scheduledLayout() {
    if (isAttached() && !_layoutScheduled) {
      _layoutScheduled = true;
      Scheduler.get().scheduleDeferred(_layoutCmd);
    }
  }
}


class HeaderPanelScheduledCommand implements ScheduledCommand {

  HeaderPanel _panel;

  HeaderPanelScheduledCommand(this._panel);

  /**
   * Causes the Command to perform its encapsulated behavior.
   */
  void execute() {
    _panel._layoutScheduled = false;
    _panel._forceLayout();
  }
}

/**
 * Delegate event handler.
 */
class HeaderPanelResizeDelegate extends ResizeDelegate {

  HeaderPanel _panel;

  HeaderPanelResizeDelegate(this._panel);


  /**
   * Called when the element is resized.
   */
  void onResize() {
    _panel._scheduledLayout();
  }
}

/**
 * The widget provider for this panel.
 *
 * <p>
 * Widgets are returned in the following order:
 * <ol>
 * <li>Header widget</li>
 * <li>Content widget</li>
 * <li>Footer widget</li>
 * </ol>
 */
class _WidgetProviderImpl implements WidgetProvider {

  HeaderPanel _panel;

  _WidgetProviderImpl(this._panel);

  Widget get(int index) {
    switch (index) {
      case 0:
        return _panel._header;
      case 1:
        return _panel._content;
      case 2:
        return _panel._footer;
    }
    throw new Exception("Array Index Out Of Bounds $index");
  }
}