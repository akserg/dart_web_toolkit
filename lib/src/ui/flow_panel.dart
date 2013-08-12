//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that formats its child widgets using the default HTML layout
 * behavior.
 *
 * <p>
 * <img class='gallery' src='doc-files/FlowPanel.png'/>
 * </p>
 */
class FlowPanel extends ComplexPanel implements InsertPanelForIsWidget, HasClickHandlers, HasDoubleClickHandlers, HasAllMouseHandlers, HasHtml {

  /**
   * Creates a Hyperlink widget that wraps an existing [AhncorElement].
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory FlowPanel.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert (Document.get().getBody().isOrHasChild(element));

    FlowPanel flowPanel = new FlowPanel.fromElement(element);

    // Mark it attached and remember it for cleanup.
    flowPanel.onAttach();
    RootPanel.detachOnWindowClose(flowPanel);

    return flowPanel;
  }
  
  /**
   * Creates an empty flow panel.
   */
  FlowPanel() : this.fromElement(new dart_html.DivElement());
  
  /**
   * Create FlowPanel with specified [DivElement].
   */
  FlowPanel.fromElement(dart_html.Element element) {
    setElement(element);
  }

  /**
   * Adds a new child widget to the panel.
   *
   * @param w the widget to be added
   */
  void add(Widget w) {
    addWidget(w, getElement());
  }

  void clear() {
    try {
      doLogicalClear();
    } finally {
      // Remove all existing child nodes.
      for (dart_html.Element element in getElement().children) {
        element.remove();
      }
    }
  }

  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertAt(asWidgetOrNull(w), beforeIndex);
  }

  /**
   * Inserts a widget before the specified index.
   *
   * @param w the widget to be inserted
   * @param beforeIndex the index before which it will be inserted
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  void insertAt(Widget w, int beforeIndex) {
    insert(w, getElement(), beforeIndex, true);
  }
  
  //***********************************
  // Implementation of HasClickHandlers
  //***********************************

  /**
   * Adds a {@link ClickEvent} handler.
   *
   * @param handler the click handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addDomHandler(handler, ClickEvent.TYPE);
  }
  
  HandlerRegistration addDoubleClickHandler(DoubleClickHandler handler) {
    return addDomHandler(handler, DoubleClickEvent.TYPE);
  }
  
  //**************************
  // Implementation of HasHtml
  //**************************
  
  String get text {
    if (isAttached()) {
      return getElement().parent.text;
    } else {
      dart_html.Element ele = new dart_html.DivElement();
      dart_html.Node clone = getElement().clone(true);
      ele.append(clone);
      return ele.text;
    }
  }

  void set text(String value) {
    if (isAttached()) {
      getElement().parent.text = value;
    } else {
      throw new Exception("FlowPanel is not attached");
    }
  }
  
  String get html {
    if (isAttached()) {
      return getElement().parent.innerHtml;
    } else {
      dart_html.Element ele = new dart_html.DivElement();
      dart_html.Node clone = getElement().clone(true);
      ele.append(clone);
      return ele.innerHtml;
    }
  }
  
  void set html(String value) {
    if (isAttached()) {
      getElement().parent.innerHtml = value;
    } else {
      throw new Exception("FlowPanel is not attached");
    }
  }
  
  //**************************************
  // Implementation of HasAllMouseHandlers
  //**************************************
  
  HandlerRegistration addMouseDownHandler(MouseDownHandler handler) {
    return addDomHandler(handler, MouseDownEvent.TYPE);
  }

  HandlerRegistration addMouseUpHandler(MouseUpHandler handler) {
    return addDomHandler(handler, MouseUpEvent.TYPE);
  }

  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
    return addDomHandler(handler, MouseOutEvent.TYPE); }

  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
    return addDomHandler(handler, MouseOverEvent.TYPE);  }

  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler) {
    return addDomHandler(handler, MouseMoveEvent.TYPE);
  }

  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler) {
    return addDomHandler(handler, MouseWheelEvent.TYPE);
  }
}
