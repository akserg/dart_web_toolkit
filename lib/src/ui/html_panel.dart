//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that contains HTML, and which can attach child widgets to identified
 * elements within that HTML.
 */
class HtmlPanel extends ComplexPanel {

  static dart_html.DivElement hiddenDiv;

  /**
   * A helper method for creating unique IDs for elements within dynamically-
   * generated HTML. This is important because no two elements in a document
   * should have the same id.
   *
   * @return a new unique identifier
   */
  static String createUniqueId() {
    return Dom.createUniqueId();
  }

  /**
   * Creates an HTML panel that wraps an existing element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory HtmlPanel.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    HtmlPanel html = new HtmlPanel.fromElement(element);

    // Mark it attached and remember it for cleanup.
    html.onAttach();
    RootPanel.detachOnWindowClose(html);

    return html;
  }

  /**
   * Creates an HTML panel with the specified HTML contents inside a DIV
   * element. Any element within this HTML that has a specified id can contain a
   * child widget.
   *
   * @param html the panel's HTML
   */
  HtmlPanel(String html) {
    /*
     * Normally would call this("div", html), but that method
     * has some slightly expensive IE defensiveness that we just
     * don't need for a div
     */
    setElement(new dart_html.DivElement());
    getElement().innerHtml = html;
  }

//  /**
//   * Initializes the panel's HTML from a given {@link SafeHtml} object.
//   *
//   * Similar to {@link #HTMLPanel(String)}
//   *
//   * @param safeHtml the html to set.
//   */
//  HtmlPanel.fromSafeHtml(SafeHtml safeHtml) : this(safeHtml.asString());

  /**
   * Creates an HTML panel whose root element has the given tag, and with the
   * specified HTML contents. Any element within this HTML that has a specified
   * id can contain a child widget.
   *
   * @param tag the tag of the root element
   * @param html the panel's HTML
   */
  HtmlPanel.fromTag(String tag, [String html = ""]) {
    // Optimization for when the HTML is empty.
    if ("" == html) {
      setElement(new dart_html.Element.tag(tag));
      return;
    }

    /*
     * IE has very arbitrary rules about what will and will not accept
     * innerHTML. <table> and <tbody> simply won't, the property is read only.
     * <p> will explode if you incorrectly try to put another <p> inside of it.
     * And who knows what else.
     *
     * However, if you cram a complete, possibly incorrect structure inside a
     * div, IE will swallow it gladly. So that's what we do here in the name of
     * IE robustification.
     */
    StringBuffer b = new StringBuffer();
    b.write('<');
    b.write(tag);
    b.write('>');
    b.write(html);
    b.write("</");
    b.write(tag);
    b.write('>');

    // We could use the static hiddenDiv, but that thing is attached
    // to the document. The caller might not want that.

    dart_html.DivElement scratchDiv = new dart_html.DivElement();
    scratchDiv.innerHtml = b.toString();
    setElement(scratchDiv.$dom_firstElementChild);
    getElement().remove(); //FromParent();
  }

  /**
   * Construct a new {@link HTMLPanel} with the specified element.
   *
   * @param elem the element at the root of the panel
   */
  HtmlPanel.fromElement(dart_html.Element elem) {
    setElement(elem);
  }

  /**
   * Adds a child widget to the panel.
   *
   * @param widget the widget to be added
   */
  void add(Widget widget) {
    addWidget(widget, getElement());
  }

  /**
   * Adds a child widget to the panel, contained within the HTML element
   * specified by a given id.
   *
   * @param widget the widget to be added
   * @param id the id of the element within which it will be contained
   */
  void addById(Widget widget, String id) {
    dart_html.Element elem = getElementById(id);

    if (elem == null) {
      throw new Exception("NoSuchElement $id");
    }

    addWidget(widget, elem);
  }

  /**
   * Adds a child widget to the panel, contained within an HTML
   * element.  It is up to the caller to ensure that the given element
   * is a child of this panel's root element.
   *
   * @param widget the widget to be added
   * @param elem the element within which it will be contained
   */
//  void add(Widget widget, dart_html.Element elem) {
//    super.addWidget(widget, clientElem);
//  }

  /**
   * Adds a child widget to the panel, replacing the HTML element.
   *
   * @param widget the widget to be added
   * @param toReplace the element to be replaced by the widget
   */
  void addAndReplaceElement(Widget widget, dart_html.Element toReplace) {
    /*
     * Early exit if the element to replace and the replacement are the same. If
     * we remove the new widget, we would also remove the element to replace.
     */
    if (toReplace == widget.getElement()) {
      return;
    }

    // Logic pulled from super.add(), replacing the element rather than adding.

    // Detach new child. Okay if its a child of the element to replace.
    widget.removeFromParent();

    // Logical detach of all children of the element to replace.
    Widget toRemove = null;
    for (Widget widget in getChildren()) {
      if (Dom.isOrHasChild(toReplace, widget.getElement())) {
        if (widget.getElement() == toReplace) {
          /*
           * If the element that we are replacing is itself a widget, then we
           * cannot remove it until the new widget has been inserted, or we lose
           * the location of the element to replace. Save the widget to remove
           * for now, and remove it after inserting the new widget.
           */
          toRemove = widget;
          break;
        }
        remove(widget);
      }
    }
//    Iterator<Widget> children = getChildren().iterator();
//    while (children.hasNext) {
//      Widget next = children.next();
//      if (toReplace.isOrHasChild(next.getElement())) {
//        if (next.getElement() == toReplace) {
//          /*
//           * If the element that we are replacing is itself a widget, then we
//           * cannot remove it until the new widget has been inserted, or we lose
//           * the location of the element to replace. Save the widget to remove
//           * for now, and remove it after inserting the new widget.
//           */
//          toRemove = next;
//          break;
//        }
//        children.remove();
//      }
//    }

    // Logical attach.
    getChildren().add(widget);

    // Physical attach.
    if (toRemove == null) {
      widget.getElement().replaceWith(toReplace);
    } else {
      /*
       * The element being replaced is a widget, which needs to be removed.
       * First insert the new widget at the same location, then remove the old
       * widget.
       */
      toReplace.parent.insertBefore(widget.getElement(), toReplace);
      remove(toRemove);
    }

    // Adopt.
    adopt(widget);
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #addAndReplaceElement(Widget,Element)
   */
  void addAndReplaceElementIsWidget(IsWidget widget, dart_html.Element toReplace) {
    this.addAndReplaceElement(widget.asWidget(), toReplace);
  }

  /**
   * Adds a child widget to the panel, replacing the HTML element specified by a
   * given id.
   *
   * @param widget the widget to be added
   * @param id the id of the element to be replaced by the widget
   */
  void addAndReplaceElementById(Widget widget, String id) {
    dart_html.Element toReplace = getElementById(id);

    if (toReplace == null) {
      throw new Exception("NoSuchElement $id");
    }

    addAndReplaceElement(widget, toReplace);
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #addAndReplaceElement(Widget,String)
   */
  void addAndReplaceElementIsWidgetById(IsWidget widget, String id) {
    this.addAndReplaceElementById(widget.asWidget(), id);
  }

  /**
   * Finds an {@link Element element} within this panel by its id.
   *
   * This method uses
   * {@link com.google.gwt.dom.client.Document#getElementById(String)}, so the
   * id must still be unique within the document.
   *
   * @param id the id of the element to be found
   * @return the element with the given id, or <code>null</code> if none is found
   * element.query('#id');
   */
  dart_html.Element getElementById(String id) {
    dart_html.Element elem = isAttached() ? dart_html.document.getElementById(id) : _attachToDomAndGetElement(id);
    return elem;
  }

  /**
   * Performs a {@link Document#getElementById(String)} after attaching the panel's
   * element into a hidden DIV in the document's body. Attachment is necessary
   * to be able to use the native getElementById. The panel's element will be
   * re-attached to its original parent (if any) after the method returns.
   *
   * @param id the id whose associated element is to be retrieved
   * @return the associated element, or <code>null</code> if none is found
   */
  dart_html.Element _attachToDomAndGetElement(String id) {
    // If the hidden DIV has not been created, create it.
    if (hiddenDiv == null) {
      hiddenDiv = new dart_html.DivElement();
      UiObject.setVisible(hiddenDiv, false);
      RootPanel.getBodyElement().append(hiddenDiv);
    }

    // Hang on to the panel's original parent and sibling elements so that it
    // can be replaced.
    dart_html.Element origParent = getElement().parent;
    dart_html.Element origSibling = getElement().nextElementSibling;

    // Attach the panel's element to the hidden div.
    hiddenDiv.append(getElement());

    // Now that we're attached to the DOM, we can use getElementById.
    dart_html.Element child = dart_html.document.getElementById(id);

    // Put the panel's element back where it was.
    if (origParent != null) {
      origParent.insertBefore(getElement(), origSibling);
    } else {
      //hiddenDiv.removeChild(getElement());
      getElement().remove();
    }

    return child;
  }
}
