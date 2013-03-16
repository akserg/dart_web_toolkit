//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that stacks its children vertically, displaying only one at a time,
 * with a header for each child which the user can click to display.
 *
 * <p>
 * This widget will <em>only</em> work in quirks mode. If your application is in
 * Standards Mode, use {@link StackLayoutPanel} instead.
 * </p>
 *
 * <p>
 * <img class='gallery' src='doc-files/StackPanel.png'/>
 * </p>
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-StackPanel { the panel itself }</li>
 * <li>.gwt-StackPanel .gwt-StackPanelItem { unselected items }</li>
 * <li>.gwt-StackPanel .gwt-StackPanelItem-selected { selected items }</li>
 * <li>.gwt-StackPanel .gwt-StackPanelContent { the wrapper around the contents
 * of the item }</li>
 * </ul>
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.StackPanelExample}
 * </p>
 *
 * @see StackLayoutPanel
 */
class StackPanel extends ComplexPanel implements InsertPanelForIsWidget {
  static final String _DEFAULT_STYLENAME = "dwt-StackPanel";
  static final String _DEFAULT_ITEM_STYLENAME = "dwt-StackPanelItem";

  dart_html.Element _body;
  int _visibleStack = -1;

  /**
   * Creates an empty stack panel.
   */
  StackPanel() {
    dart_html.TableElement table = new dart_html.TableElement();
    setElement(table);

    _body = table.createTBody();
    table.append(_body);
    Dom.setElementPropertyInt(table, "cellSpacing", 0);
    Dom.setElementPropertyInt(table, "cellPadding", 0);

    Dom.sinkEvents(table, Event.ONCLICK);
    clearAndSetStyleName(_DEFAULT_STYLENAME);
  }

  /**
   * Adds a new child with the given widget and header, optionally interpreting
   * the header as HTML.
   *
   * @param w the widget to be added
   * @param stackText the header text associated with this widget
   * @param asHTML <code>true</code> to treat the specified text as HTML
   */
  void add(Widget w, [String stackText = null, bool asHtml = false]) {
    insertWidget(w, getWidgetCount());
    if (stackText != null) {
      setStackText(getWidgetCount() - 1, stackText, asHtml);
    }
  }

  /**
   * Gets the currently selected child index.
   *
   * @return selected child
   */
  int getSelectedIndex() {
    return _visibleStack;
  }

  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertWidget(asWidgetOrNull(w), beforeIndex);
  }

  /**
   * Insert a new child Widget into this Panel at a specified index, attaching
   * its Element to the specified container Element. The child Element will
   * either be attached to the container at the same index, or simply appended
   * to the container, depending on the value of <code>domInsert</code>.
   *
   * @param child the child Widget to be added
   * @param container the Element within which <code>child</code> will be
   *          contained
   * @param beforeIndex the index before which <code>child</code> will be
   *          inserted
   * @param domInsert if <code>true</code>, insert <code>child</code> into
   *          <code>container</code> at <code>beforeIndex</code>; otherwise
   *          append <code>child</code> to the end of <code>container</code>.
   */
  void insertWidget(Widget w, int beforeIndex) {
    // header
    dart_html.TableRowElement trh = new dart_html.TableRowElement();
    dart_html.TableCellElement tdh = new dart_html.TableCellElement();
    trh.append(tdh);
    tdh.append(createHeaderElem());

    // _body
    dart_html.TableRowElement trb = new dart_html.TableRowElement();
    dart_html.TableCellElement tdb = new dart_html.TableCellElement();
    trb.append(tdb);

    // Dom indices are 2x logical indices; 2 dom elements per stack item
    beforeIndex = adjustIndex(w, beforeIndex);
    int effectiveIndex = beforeIndex * 2;

    if (effectiveIndex + 1 < _body.children.length) {
      // this ordering puts the _body below the header
      _body.children.insertRange(effectiveIndex, 2);
      //Dom.insertChild(_body, trb, effectiveIndex);
      //Dom.insertChild(_body, trh, effectiveIndex);
      _body.children[effectiveIndex] = trh;
      _body.children[effectiveIndex + 1] = trb;
    } else {
      _body.children.add(trh);
      _body.children.add(trb);
    }

    // header styling
    UiObject.manageElementStyleName(tdh, _DEFAULT_ITEM_STYLENAME, true);
    Dom.setElementPropertyInt(tdh, "__owner", hashCode);
    Dom.setElementProperty(tdh, "height", "1px");

    // _body styling
    UiObject.manageElementStyleName(tdb, _DEFAULT_STYLENAME.concat("Content"), true);
    Dom.setElementProperty(tdb, "height", "100%");
    Dom.setElementProperty(tdb, "vAlign", "top");

    // Now that the Dom is connected, call insert (this ensures that onLoad() is
    // not fired until the child widget is attached to the Dom).
    insert(w, tdb, beforeIndex, false);

    // Update indices of all elements to the right.
    _updateIndicesFrom(beforeIndex);

    // Correct visible stack for new location.
    if (_visibleStack == -1) {
      showStack(0);
    } else {
      _setStackVisible(beforeIndex, false);
      if (_visibleStack >= beforeIndex) {
        ++_visibleStack;
      }
      // Reshow the stack to apply style names
      _setStackVisible(_visibleStack, true);
    }
  }

  void onBrowserEvent(dart_html.Event event) {
    if (Dom.eventGetType(event) == Event.ONCLICK) {
      dart_html.Element target = (event as dart_html.MouseEvent).target;
      int index = _findDividerIndex(target);
      if (index != -1) {
        showStack(index);
      }
    }
    super.onBrowserEvent(event);
  }

  bool removeAt(int index) {
    return _remove(getWidget(index), index);
  }

  bool remove(Widget child) {
    return _remove(child, getWidgetIndex(child));
  }

  bool _remove(Widget child, int index) {
    // Make sure to call this before disconnecting the DOM.
    bool removed = super.remove(child);
    if (removed) {
      // Calculate which internal table elements to remove.
      int rowIndex = 2 * index;
      dart_html.Element tr = _body.children[rowIndex]; //DOM.getChild(_body, rowIndex);
      //DOM.removeChild(_body, tr);
      tr.remove();
      tr = _body.children[rowIndex]; //tr = DOM.getChild(_body, rowIndex);
      //DOM.removeChild(_body, tr);
      tr.remove();

      // Correct visible stack for new location.
      if (_visibleStack == index) {
        _visibleStack = -1;
      } else if (_visibleStack > index) {
        --_visibleStack;
      }

      // Update indices of all elements to the right.
      _updateIndicesFrom(index);
    }
    return removed;
  }

  /**
   * Sets the text associated with a child by its index.
   *
   * @param index the index of the child whose text is to be set
   * @param text the text to be associated with it
   * @param asHtml <code>true</code> to treat the specified text as HTML
   */
  void setStackText(int index, String text, [bool asHtml = false]) {
    if (index >= getWidgetCount()) {
      return;
    }

    dart_html.Element tr = _body.children[index * 2];
    dart_html.Element tdWrapper = tr.children[0]; //DOM.getChild(DOM.getChild(_body, index * 2), 0);
    dart_html.Element headerElem = tdWrapper.$dom_firstElementChild; // DOM.getFirstChild(tdWrapper);
    if (asHtml) {
      getHeaderTextElem(headerElem).innerHtml = text; // Dom.setInnerHTML(getHeaderTextElem(headerElem), text);
    } else {
      getHeaderTextElem(headerElem).text = text; // Dom.setInnerText(getHeaderTextElem(headerElem), text);
    }
  }

  /**
   * Shows the widget at the specified child index.
   *
   * @param index the index of the child to be shown
   */
  void showStack(int index) {
    if ((index >= getWidgetCount()) || (index < 0) || (index == _visibleStack)) {
      return;
    }

    if (_visibleStack >= 0) {
      _setStackVisible(_visibleStack, false);
    }

    _visibleStack = index;
    _setStackVisible(_visibleStack, true);
  }

  /**
   * Returns a header element.
   */
  dart_html.Element createHeaderElem() {
    return new dart_html.DivElement();
  }

  /**
   * Get the element that holds the header text given the header element created
   * by #createHeaderElement.
   *
   * @param headerElem the header element
   * @return the element around the header text
   */
  dart_html.Element getHeaderTextElem(dart_html.Element headerElem) {
    return headerElem;
  }

  int _findDividerIndex(dart_html.Element elem) {
    while (elem != null && elem != getElement()) {
      String expando = Dom.getElementProperty(elem, "__index");
      if (expando != null) {
        // Make sure it belongs to me!
        int ownerHash = Dom.getElementPropertyInt(elem, "__owner");
        if (ownerHash == hashCode) {
          // Yes, it's mine.
          return int.parse(expando); // Integer.parseInt(expando);
        } else {
          // It must belong to some nested StackPanel.
          return -1;
        }
      }
      elem = elem.parent; //Dom.getParent(elem);
    }
    return -1;
  }

  void _setStackContentVisible(int index, bool visible) {
    dart_html.Element tr = _body.children[(index * 2) + 1]; //  DOM.getChild(_body, (index * 2) + 1);
    UiObject.setVisible(tr, visible);
    getWidget(index).visible = visible;
  }

  void _setStackVisible(int index, bool visible) {
    // Get the first table row containing the widget's selector item.
    dart_html.Element tr = _body.children[index * 2]; // DOM.getChild(_body, (index * 2));
    if (tr == null) {
      return;
    }

    // Style the stack selector item.
    dart_html.Element td = tr.$dom_firstElementChild; //DOM.getFirstChild(tr);
    UiObject.manageElementStyleName(td, _DEFAULT_ITEM_STYLENAME.concat("-selected"), visible);

    // Show/hide the contained widget.
    _setStackContentVisible(index, visible);

    // We must check is next header available before make any changes with his style
    int nextIndex = (index + 1) * 2;
    if (_body.children.length > nextIndex) {
      // Set the style of the next header
      dart_html.Element trNext = _body.children[nextIndex]; //DOM.getChild(_body, ((index + 1) * 2));
      if (trNext != null) {
        dart_html.Element tdNext = trNext.$dom_firstElementChild; //DOM.getFirstChild(trNext);
        UiObject.manageElementStyleName(tdNext, _DEFAULT_ITEM_STYLENAME.concat("-below-selected"), visible);
      }
    }
  }

  void _updateIndicesFrom(int beforeIndex) {
    for (int i = beforeIndex, c = getWidgetCount(); i < c; ++i) {
      dart_html.Element childTR = _body.children[i * 2]; //DOM.getChild(_body, i * 2);
      dart_html.Element childTD = childTR.$dom_firstElementChild; ; //DOM.getFirstChild(childTR);
      Dom.setElementPropertyInt(childTD, "__index", i);

      // Update the special style on the first element
      if (beforeIndex == 0) {
        UiObject.manageElementStyleName(childTD, _DEFAULT_ITEM_STYLENAME.concat("-first"), true);
      } else {
        UiObject.manageElementStyleName(childTD, _DEFAULT_ITEM_STYLENAME.concat("-first"), false);
      }
    }
  }
}
