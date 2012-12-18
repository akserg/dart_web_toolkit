//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that includes a header (top), footer (bottom), and content (middle)
 * area. The header and footer areas resize naturally. The content area is
 * allocated all of the remaining space between the header and footer area.
 */
class HeaderPanel extends Panel implements RequiresResize {

  Widget content;
  dart_html.Element contentContainer;
  Widget footer;
  dart_html.Element footerContainer;
  ResizeLayoutPanelImpl footerImpl;
  Widget header;
  dart_html.Element headerContainer;
  ResizeLayoutPanelImpl headerImpl;
  ScheduledCommand layoutCmd;
  bool layoutScheduled = false;

  HeaderPanel() {
    layoutCmd = new HeaderPanelScheduledCommand(this);
    // Create the outer element
    dart_html.DivElement elem = new dart_html.DivElement();
    elem.style.position = Position.RELATIVE;
    elem.style.overflow = Overflow.HIDDEN;
    setElement(elem);

    footerImpl = new ResizeLayoutPanelImpl.browserDependent();
    headerImpl = new ResizeLayoutPanelImpl.browserDependent();

    // Create a delegate to handle resize from the header and footer.
    ResizeDelegate resizeDelegate = new HeaderPanelResizeDelegate(this);

    // Create the header container.
    headerContainer = createContainer();
    headerContainer.style.top = "0.0".concat(Unit.PX);
    headerImpl.init(headerContainer, resizeDelegate);
    elem.append(headerContainer);

    // Create the footer container.
    footerContainer = createContainer();
    footerContainer.style.bottom = "0.0".concat(Unit.PX);
    footerImpl.init(footerContainer, resizeDelegate);
    elem.append(footerContainer);

    // Create the content container.
    contentContainer = createContainer();
    contentContainer.style.overflow = Overflow.HIDDEN;
    contentContainer.style.top = "0.0".concat(Unit.PX);
    contentContainer.style.height = "0.0".concat(Unit.PX);
    elem.append(contentContainer);
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
    if (header == null) {
      setHeaderWidget(w);
    } else if (content == null) {
      setContentWidget(w);
    } else if (footer == null) {
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
      w.getElement().removeFromParent();

      // Logical detach.
      if (w == content) {
        content = null;
        contentContainer.style.display = Display.NONE;
      } else if (w == header) {
        header = null;
        headerContainer.style.display = Display.NONE;
      } else if (w == footer) {
        footer = null;
        footerContainer.style.display = Display.NONE;
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
    return content;
  }

  /**
   * Set the widget in the content portion between the header and footer.
   *
   * @param w the widget to use as the content
   */
  void setContentWidget(Widget w) {
    contentContainer.style.display = "";
    _put(w, content, contentContainer);

    // Logical attach.
    content = w;
    scheduledLayout();
  }

  /**
   * Get the footer widget at the bottom of the panel.
   *
   * @return the footer {@link Widget}
   */
  Widget getFooterWidget() {
    return footer;
  }

  /**
   * Set the widget in the footer portion at the bottom of the panel.
   *
   * @param w the widget to use as the footer
   */
  void setFooterWidget(Widget w) {
    footerContainer.style.display = "";
    _put(w, footer, footerContainer);

    // Logical attach.
    footer = w;
    scheduledLayout();
  }

  /**
   * Get the header widget at the top of the panel.
   *
   * @return the header {@link Widget}
   */
  Widget getHeaderWidget() {
    return header;
  }

  /**
   * Set the widget in the header portion at the top of the panel.
   *
   * @param w the widget to use as the header
   */
  void setHeaderWidget(Widget w) {
    headerContainer.style.display = "";
    _put(w, header, headerContainer);

    // Logical attach.
    header = w;
    scheduledLayout();
  }

  /**
   * Add a widget to the panel in the specified container. Note that this method
   * does not do the logical attach.
   *
   * @param w the widget to add
   * @param toReplace the widget to replace
   * @param container the container in which to place the widget
   */
  void _put(Widget w, Widget toReplace, dart_html.Element container) {
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

  dart_html.Element createContainer() {
    dart_html.DivElement container = new dart_html.DivElement();
    container.style.position = Position.ABSOLUTE;
    container.style.display = Display.NONE;
    container.style.left = "0.0".concat(Unit.PX);
    container.style.width = "100.0".concat(Unit.PX);
    return container;
  }

  Iterator<Widget> iterator() {
    return new FiniteWidgetIterator(new WidgetProviderImpl(this), 3);
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
    headerImpl.onAttach();
    footerImpl.onAttach();
    scheduledLayout();
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
    headerImpl.onDetach();
    footerImpl.onDetach();
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
    scheduledLayout();
  }

  //*******
  // Layout
  //*******

  /**
   * Update the layout.
   */
  void forceLayout() {
    // No sense in doing layout if we aren't attached or have no content.
    if (!isAttached() || content == null) {
      return;
    }

    // Resize the content area to fit between the header and footer.
    int remainingHeight = getElement().clientHeight;
    if (header != null) {
      int height = dart_math.max(0, headerContainer.offsetHeight);
      remainingHeight -= height;
      contentContainer.style.top = height.toString().concat(Unit.PX);
    } else {
      contentContainer.style.top = "0.0".concat(Unit.PX);
    }
    if (footer != null) {
      remainingHeight -= footerContainer.offsetHeight;
    }
    contentContainer.style.height = dart_math.max(0, remainingHeight).toString().concat(Unit.PX);

    // Provide resize to child.
    if (content is RequiresResize) {
      (content as RequiresResize).onResize();
    }
  }

  /**
   * Schedule layout to adjust the height of the content area.
   */
  void scheduledLayout() {
    if (isAttached() && !layoutScheduled) {
      layoutScheduled = true;
      Scheduler.get().scheduleDeferred(layoutCmd);
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
    _panel.layoutScheduled = false;
    _panel.forceLayout();
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
    _panel.scheduledLayout();
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
class WidgetProviderImpl implements WidgetProvider {

  HeaderPanel _panel;

  WidgetProviderImpl(this._panel);

  Widget get(int index) {
    switch (index) {
      case 0:
        return _panel.header;
      case 1:
        return _panel.content;
      case 2:
        return _panel.footer;
    }
    throw new Exception("Array Index Out Of Bounds $index");
  }
}