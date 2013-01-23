//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * HTMLTable contains the common table algorithms for
 * {@link com.google.gwt.user.client.ui.Grid} and
 * {@link com.google.gwt.user.client.ui.FlexTable}.
 * <p>
 * <img class='gallery' src='doc-files/Table.png'/>
 * </p>
 */
abstract class HtmlTable extends Panel implements HasAllDragAndDropHandlers, HasClickHandlers, HasDoubleClickHandlers {

  /**
   * Table's body.
   */
  dart_html.Element bodyElem;

  /**
   * Current cell formatter.
   */
  CellFormatter cellFormatter;

  /**
   * Column Formatter.
   */
  ColumnFormatter columnFormatter;

  /**
   * Current row formatter.
   */
  RowFormatter rowFormatter;

  /**
   * Table element.
   */
  dart_html.TableElement tableElem;

  ElementMapperImpl<Widget> widgetMap = new ElementMapperImpl<Widget>();

  /**
   * Create a new empty HTML Table.
   */
  HtmlTable() {
    tableElem = new dart_html.TableElement();
    bodyElem = tableElem.createTBody();
    tableElem.append(bodyElem);
    setElement(tableElem);
  }

  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addDomHandler(handler, ClickEvent.TYPE);
  }

  HandlerRegistration addDoubleClickHandler(DoubleClickHandler handler) {
    return addDomHandler(handler, DoubleClickEvent.TYPE);
  }

  HandlerRegistration addDragEndHandler(DragEndHandler handler) {
    return addDomHandler(handler, DragEndEvent.TYPE);
  }

  HandlerRegistration addDragEnterHandler(DragEnterHandler handler) {
    return addDomHandler(handler, DragEnterEvent.TYPE);
  }

  HandlerRegistration addDragHandler(DragHandler handler) {
    return addDomHandler(handler, DragEvent.TYPE);
  }

  HandlerRegistration addDragLeaveHandler(DragLeaveHandler handler) {
    return addDomHandler(handler, DragLeaveEvent.TYPE);
  }

  HandlerRegistration addDragOverHandler(DragOverHandler handler) {
    return addDomHandler(handler, DragOverEvent.TYPE);
  }

  HandlerRegistration addDragStartHandler(DragStartHandler handler) {
    return addDomHandler(handler, DragStartEvent.TYPE);
  }

  HandlerRegistration addDropHandler(DropHandler handler) {
    return addDomHandler(handler, DropEvent.TYPE);
  }

  /**
   * Removes all widgets from this table, optionally clearing the inner HTML of
   * each cell.  Note that this method does not remove any cells or rows.
   *
   * @param clearInnerHTML should the cell's inner html be cleared?
   */
  void clear([bool clearInnerHTML = false]) {
    for (int row = 0; row < getRowCount(); ++row) {
      for (int col = 0; col < getCellCount(row); ++col) {
        cleanCell(row, col, clearInnerHTML);
      }
    }
  }

  /**
   * Clears the cell at the given row and column. If it contains a Widget, it
   * will be removed from the table. If not, its contents will simply be
   * cleared.
   *
   * @param row the widget's row
   * @param column the widget's column
   * @return true if a widget was removed
   * @throws IndexOutOfBoundsException
   */
  bool clearCell(int row, int column) {
    dart_html.Element td = getCellFormatter().getElement(row, column);
    return internalClearCell(td, true);
  }

  /**
   * Gets the number of cells in a given row.
   *
   * @param row the row whose cells are to be counted
   * @return the number of cells present in the row
   */
  int getCellCount(int row);

  /**
   * Given a click event, return the Cell that was clicked, or null if the event
   * did not hit this table.  The cell can also be null if the click event does
   * not occur on a specific cell.
   *
   * @param event A click event of indeterminate origin
   * @return The appropriate cell, or null
   */
  Cell getCellForEvent(ClickEvent event) {
    dart_html.Element td = getEventTargetCell(event.getNativeEvent());
    if (td == null) {
      return null;
    }

    int row = (td.parent as dart_html.TableRowElement).sectionRowIndex;
    int column = (td as dart_html.TableCellElement).cellIndex;
    return new Cell(this, row, column);
  }

  /**
   * Gets the {@link CellFormatter} associated with this table. Use casting to
   * get subclass-specific functionality
   *
   * @return this table's cell formatter
   */
  CellFormatter getCellFormatter() {
    return cellFormatter;
  }

  /**
   * Gets the amount of padding that is added around all cells.
   *
   * @return the cell padding, in pixels
   */
  int getCellPadding() {
    return Dom.getElementPropertyInt(tableElem, "cellPadding");
  }

  /**
   * Gets the amount of spacing that is added around all cells.
   *
   * @return the cell spacing, in pixels
   */
  int getCellSpacing() {
    return Dom.getElementPropertyInt(tableElem, "cellSpacing");
  }

  /**
   * Gets the column formatter.
   *
   * @return the column formatter
   */
  ColumnFormatter getColumnFormatter() {
    return columnFormatter;
  }

  /**
   * Gets the HTML contents of the specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the cell's HTML contents
   * @throws IndexOutOfBoundsException
   */
  String getHTML(int row, int column) {
    return cellFormatter.getElement(row, column).innerHtml;
  }

  /**
   * Gets the number of rows present in this table.
   *
   * @return the table's row count
   */
  int getRowCount();

  /**
   * Gets the RowFormatter associated with this table.
   *
   * @return the table's row formatter
   */
  RowFormatter getRowFormatter() {
    return rowFormatter;
  }

  /**
   * Gets the text within the specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the cell's text contents
   * @throws IndexOutOfBoundsException
   */
  String getText(int row, int column) {
    checkCellBounds(row, column);
    return cellFormatter.getElement(row, column).text;
  }

  /**
   * Gets the widget in the specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the widget in the specified cell, or <code>null</code> if none is
   *         present
   * @throws IndexOutOfBoundsException
   */
  Widget getWidget(int row, int column) {
    checkCellBounds(row, column);
    return getWidgetImpl(row, column);
  }

  /**
   * Determines whether the specified cell exists.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return <code>true</code> if the specified cell exists
   */
  bool isCellPresent(int row, int column) {
    if ((row >= getRowCount()) || (row < 0)) {
      return false;
    }
    if ((column < 0) || (column >= getCellCount(row))) {
      return false;
    } else {
      return true;
    }
  }

  /**
   * Returns an iterator containing all the widgets in this table.
   *
   * @return the iterator
   */
  Iterator<Widget> iterator() {
    return new _WidgetIterator(this);
  }

  /**
   * Remove the specified widget from the table.
   *
   * @param widget widget to remove
   * @return was the widget removed from the table.
   */

  bool remove(Widget widget) {
    // Validate.
    if (widget.getParent() != this) {
      return false;
    }

    // Orphan.
    try {
      orphan(widget);
    } finally {
      // Physical detach.
      dart_html.Element elem = widget.getElement();
      //Dom.removeChild(Dom.getParent(elem), elem);
      elem.remove();

      // Logical detach.
      widgetMap.removeByElement(elem);
    }
    return true;
  }

  /**
   * Sets the width of the table's border. This border is displayed around all
   * cells in the table.
   *
   * @param width the width of the border, in pixels
   */
  void setBorderWidth(int width) {
    Dom.setElementProperty(tableElem, "border", width.toString());
  }

  /**
   * Sets the amount of padding to be added around all cells.
   *
   * @param padding the cell padding, in pixels
   */
  void setCellPadding(int padding) {
    Dom.setElementPropertyInt(tableElem, "cellPadding", padding);
  }

  /**
   * Sets the amount of spacing to be added around all cells.
   *
   * @param spacing the cell spacing, in pixels
   */
  void setCellSpacing(int spacing) {
    Dom.setElementPropertyInt(tableElem, "cellSpacing", spacing);
  }

  /**
   * Sets the HTML contents of the specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @param html the cell's HTML contents
   * @throws IndexOutOfBoundsException
   */
  void setHtml(int row, int column, String html) {
    prepareCell(row, column);
    dart_html.Element td = cleanCell(row, column, html == null);
    if (html != null) {
      td.innerHtml = html;
    }
  }

//  /**
//   * Sets the HTML contents of the specified cell.
//   *
//   * @param row the cell's row
//   * @param column the cell's column
//   * @param html the cell's safe html contents
//   * @throws IndexOutOfBoundsException
//   */
//  void setHTML(int row, int column, SafeHtml html) {
//    setHTML(row, column, html.asString());
//  }

  /**
   * Sets the text within the specified cell.
   *
   * @param row the cell's row
   * @param column cell's column
   * @param text the cell's text contents
   * @throws IndexOutOfBoundsException
   */
  void setText(int row, int column, String text) {
    prepareCell(row, column);
    dart_html.Element td;
    td = cleanCell(row, column, text == null);
    if (text != null) {
      //Dom.setInnerText(td, text);
      td.text = text;
    }
  }

  /**
   * Sets the widget within the specified cell.
   * <p>
   * Inherited implementations may either throw IndexOutOfBounds exception if
   * the cell does not exist, or allocate a new cell to store the content.
   * </p>
   * <p>
   * FlexTable will automatically allocate the cell at the correct location and
   * then set the widget. Grid will set the widget if and only if the cell is
   * within the Grid's bounding box.
   * </p>
   *
   * @param widget The widget to be added, or null to clear the cell
   * @param row the cell's row
   * @param column the cell's column
   * @throws IndexOutOfBoundsException
   */
  void setWidget(int row, int column, Widget widget) {
    prepareCell(row, column);

    // Removes any existing widget.
    dart_html.Element td = cleanCell(row, column, true);

    if (widget != null) {
      widget.removeFromParent();

      // Logical attach.
      widgetMap.put(widget);

      // Physical attach.
      td.append(widget.getElement());

      adopt(widget);
    }
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #setWidget(int,int,Widget)
   */
  void setIsWidget(int row, int column, IsWidget widget) {
    this.setWidget(row, column, asWidgetOrNull(widget));
  }

  /**
   * Bounds checks that the cell exists at the specified location.
   *
   * @param row cell's row
   * @param column cell's column
   * @throws IndexOutOfBoundsException
   */
  void checkCellBounds(int row, int column) {
    checkRowBounds(row);
    if (column < 0) {
      throw new Exception("IndexOutOfBounds. Column ${column} must be non-negative: $column");
    }
    int cellSize = getCellCount(row);
    if (cellSize <= column) {
      throw new Exception("IndexOutOfBounds. Column index: $column, Column size: ${getCellCount(row)}");
    }
  }

  /**
   * Checks that the row is within the correct bounds.
   *
   * @param row row index to check
   * @throws IndexOutOfBoundsException
   */
  void checkRowBounds(int row) {
    int rowSize = getRowCount();
    if ((row >= rowSize) || (row < 0)) {
      throw new Exception("IndexOutOfBounds. Row index: $row, Row size: $rowSize");
    }
  }

  /**
   * Creates a new cell. Override this method if the cell should have initial
   * contents.
   *
   * @return the newly created TD
   */
  dart_html.Element createCell() {
    return new dart_html.TableCellElement();
  }

  /**
   * Gets the table's TBODY element.
   *
   * @return the TBODY element
   */
  dart_html.Element getBodyElement() {
    return bodyElem;
  }

  /**
   * Directly ask the underlying Dom what the cell count on the given row is.
   *
   * @param tableBody the element
   * @param row the row
   * @return number of columns in the row
   */
  int getDomCellCount(int row, [dart_html.Element tableBody = null]) {
    if (tableBody == null) {
      return ((bodyElem.parent as dart_html.TableElement).rows[row] as dart_html.TableRowElement).cells.length;
    } else {
      return ((tableBody.parent as dart_html.TableElement).rows[row] as dart_html.TableRowElement).cells.length;
    }
  }

  /**
   * Directly ask the underlying Dom what the row count is.
   *
   * @return Returns the number of rows in the table
   */
  int getDomRowCount([dart_html.Element elem = null]) {
    if (elem == null) {
      return (bodyElem.parent as dart_html.TableElement).rows.length;
    } else {
      return (elem.parent as dart_html.TableElement).rows.length;
    }
  }

  /**
   * Determines the TD associated with the specified event.
   *
   * @param event the event to be queried
   * @return the TD associated with the event, or <code>null</code> if none is
   *         found.
   */
  dart_html.Element getEventTargetCell(dart_html.Event event) {
    for (dart_html.Element td = event.target; td != null; td = td.parent) {
      // If it's a TD, it might be the one we're looking for.
      if (td is dart_html.TableCellElement) {
        // Make sure it's directly a part of this table before returning it.
        dart_html.Element tr = td.parent;
        dart_html.Element body = tr.parent;
        if (body == bodyElem) {
          return td;
        }
      }
      // If we run into this table's body, we're out of options.
      if (td == bodyElem) {
        return null;
      }
    }
    return null;
  }

  /**
   * Inserts a new cell into the specified row.
   *
   * @param row the row into which the new cell will be inserted
   * @param column the column before which the cell will be inserted
   * @throws IndexOutOfBoundsException
   */
  void insertCell(int row, int column) {
    dart_html.Element tr = rowFormatter.getRow(bodyElem, row);
    dart_html.Element td = createCell();
    Dom.insertChild(tr, td, column);
  }

  /**
   * Inserts a number of cells before the specified cell.
   *
   * @param row the row into which the new cells will be inserted
   * @param column the column before which the new cells will be inserted
   * @param count number of cells to be inserted
   * @throws IndexOutOfBoundsException
   */
  void insertCells(int row, int column, int count) {
    dart_html.Element tr = rowFormatter.getRow(bodyElem, row);
    for (int i = column; i < column + count; i++) {
      dart_html.Element td = createCell();
      Dom.insertChild(tr, td, i);
    }
  }

  /**
   * Inserts a new row into the table.
   *
   * @param beforeRow the index before which the new row will be inserted
   * @return the index of the newly-created row
   * @throws IndexOutOfBoundsException
   */
  int insertRow(int beforeRow) {
    // Specifically allow the row count as an insert position.
    if (beforeRow != getRowCount()) {
      checkRowBounds(beforeRow);
    }
    dart_html.Element tr = new dart_html.TableRowElement();
    Dom.insertChild(bodyElem, tr, beforeRow);
    return beforeRow;
  }

  /**
   * Does actual clearing, used by clearCell and cleanCell. All HTMLTable
   * methods should use internalClearCell rather than clearCell, as clearCell
   * may be overridden in subclasses to format an empty cell.
   *
   * @param td element to clear
   * @param clearInnerHTML should the cell's inner html be cleared?
   * @return returns whether a widget was cleared
   */
  bool internalClearCell(dart_html.Element td, bool clearInnerHTML) {
    var maybeChild = td.$dom_firstChild;
    Widget widget = null;
    if (maybeChild != null && maybeChild is dart_html.Element) {
      widget = widgetMap.get(maybeChild as dart_html.Element);
    }
    if (widget != null) {
      // If there is a widget, remove it.
      remove(widget);
      return true;
    } else {
      // Otherwise, simply clear whatever text and/or HTML may be there.
      if (clearInnerHTML) {
        td.innerHtml = "";
      }
      return false;
    }
  }

  /**
   * Subclasses must implement this method. It allows them to decide what to do
   * just before a cell is accessed. If the cell already exists, this method
   * must do nothing. Otherwise, a subclass must either ensure that the cell
   * exists or throw an {@link IndexOutOfBoundsException}.
   *
   * @param row the cell's row
   * @param column the cell's column
   */
  void prepareCell(int row, int column);

  /**
   * Subclasses can implement this method. It allows them to decide what to do
   * just before a column is accessed. For classes, such as
   * <code>FlexTable</code>, that do not have a concept of a global column
   * length can ignore this method.
   *
   * @param column the cell's column
   * @throws IndexOutOfBoundsException
   */
  void prepareColumn(int column) {
    // Ensure that the indices are not negative.
    if (column < 0) {
      throw new Exception("IndexOutOfBounds. Cannot access a column with a negative index: $column");
    }
  }

  /**
   * Subclasses must implement this method. If the row already exists, this
   * method must do nothing. Otherwise, a subclass must either ensure that the
   * row exists or throw an {@link IndexOutOfBoundsException}.
   *
   * @param row the cell's row
   */
  void prepareRow(int row);

  /**
   * Removes the specified cell from the table.
   *
   * @param row the row of the cell to remove
   * @param column the column of cell to remove
   * @throws IndexOutOfBoundsException
   */
  void removeCell(int row, int column) {
    checkCellBounds(row, column);
    dart_html.Element td = cleanCell(row, column, false);
    dart_html.Element tr = rowFormatter.getRow(bodyElem, row);
    td.remove();
  }

  /**
   * Removes the specified row from the table.
   *
   * @param row the index of the row to be removed
   * @throws IndexOutOfBoundsException
   */
  void removeRow(int row) {
    int columnCount = getCellCount(row);
    for (int column = 0; column < columnCount; ++column) {
      cleanCell(row, column, false);
    }
    rowFormatter.getRow(bodyElem, row).remove();
  }

  /**
   * Sets the table's CellFormatter.
   *
   * @param cellFormatter the table's cell formatter
   */
  void setCellFormatter(CellFormatter cellFormatter) {
    this.cellFormatter = cellFormatter;
  }

  void setColumnFormatter(ColumnFormatter formatter) {
    // Copy the columnGroup element to the new formatter so we don't create a
    // second colgroup element.
    if (columnFormatter != null) {
      formatter.columnGroup = columnFormatter.columnGroup;
    }
    columnFormatter = formatter;
    columnFormatter._table = this;
    columnFormatter.prepareColumnGroup();
  }

  /**
   * Sets the table's RowFormatter.
   *
   * @param rowFormatter the table's row formatter
   */
  void setRowFormatter(RowFormatter rowFormatter) {
    this.rowFormatter = rowFormatter;
    this.rowFormatter._table = this;
  }

  /**
   * Removes any widgets, text, and HTML within the cell. This method assumes
   * that the requested cell already exists.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @param clearInnerHTML should the cell's inner html be cleared?
   * @return element that has been cleaned
   */
  dart_html.Element cleanCell(int row, int column, bool clearInnerHTML) {
    // Clear whatever is in the cell.
    dart_html.Element td = getCellFormatter().getRawElement(row, column);
    internalClearCell(td, clearInnerHTML);
    return td;
  }

  /**
   * Gets the Widget associated with the given cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the widget
   */
  Widget getWidgetImpl(int row, int column) {
    dart_html.Element e = cellFormatter.getRawElement(row, column);
    dart_html.Element child = e.$dom_firstChild;
    if (child == null) {
      return null;
    } else {
      return widgetMap.get(child);
    }
  }
}

/**
 * Return value for {@link HTMLTable#getCellForEvent}.
 */
class Cell {

  HtmlTable _table;

  final int rowIndex;
  final int cellIndex;

  /**
   * Creates a cell.
   *
   * @param rowIndex the cell's row
   * @param cellIndex the cell's index
   */
  Cell(this._table, this.rowIndex, this.cellIndex);

  /**
   * Gets the cell index.
   *
   * @return the cell index
   */
  int getCellIndex() {
    return cellIndex;
  }

  /**
   * Gets the cell's element.
   *
   * @return the cell's element.
   */
  dart_html.Element getElement() {
    return _table.getCellFormatter().getElement(rowIndex, cellIndex);
  }

  /**
   * Get row index.
   *
   * @return the row index
   */
  int getRowIndex() {
    return rowIndex;
  }
}

/**
 * This class contains methods used to format a table's cells.
 */
class CellFormatter {

  HtmlTable _table;

  CellFormatter(this._table);

  /**
   * Adds a style to the specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @param styleName the style name to be added
   * @see UiObject#addStyleName(String)
   */
  void addStyleName(int row, int column, String styleName) {
    _table.prepareCell(row, column);
    dart_html.Element td = getCellElement(_table.bodyElem, row, column);
    UiObject.manageElementStyleName(td, styleName, true);
  }

  /**
   * Gets the TD element representing the specified cell.
   *
   * @param row the row of the cell to be retrieved
   * @param column the column of the cell to be retrieved
   * @return the column's TD element
   * @throws IndexOutOfBoundsException
   */
  dart_html.Element getElement(int row, int column) {
    _table.checkCellBounds(row, column);
    return getCellElement(_table.bodyElem, row, column);
  }

  /**
   * Gets the style of a specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @see UiObject#getStyleName()
   * @return returns the style name
   * @throws IndexOutOfBoundsException
   */
  String getStyleName(int row, int column) {
    return UiObject.getElementStyleName(getElement(row, column));
  }

  /**
   * Gets the primary style of a specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @see UiObject#getStylePrimaryName()
   * @return returns the style name
   * @throws IndexOutOfBoundsException
   */
  String getStylePrimaryName(int row, int column) {
    return UiObject.getElementStylePrimaryName(getElement(row, column));
  }

  /**
   * Determines whether or not this cell is visible.
   *
   * @param row the row of the cell whose visibility is to be set
   * @param column the column of the cell whose visibility is to be set
   * @return <code>true</code> if the object is visible
   */
  bool isVisible(int row, int column) {
    dart_html.Element e = getElement(row, column);
    return UiObject.isVisible(e);
  }

  /**
   * Removes a style from the specified cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @param styleName the style name to be removed
   * @see UiObject#removeStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void removeStyleName(int row, int column, String styleName) {
    _table.checkCellBounds(row, column);
    dart_html.Element td = getCellElement(_table.bodyElem, row, column);
    UiObject.manageElementStyleName(td, styleName, false);
  }

  /**
   * Sets the horizontal and vertical alignment of the specified cell's
   * contents.
   *
   * @param row the row of the cell whose alignment is to be set
   * @param column the column of the cell whose alignment is to be set
   * @param hAlign the cell's new horizontal alignment as specified in
   *          {@link HasHorizontalAlignment}
   * @param vAlign the cell's new vertical alignment as specified in
   *          {@link HasVerticalAlignment}
   * @throws IndexOutOfBoundsException
   */
  void setAlignment(int row, int column,
                           HorizontalAlignmentConstant hAlign, VerticalAlignmentConstant vAlign) {
    setHorizontalAlignment(row, column, hAlign);
    setVerticalAlignment(row, column, vAlign);
  }

  /**
   * Sets the height of the specified cell.
   *
   * @param row the row of the cell whose height is to be set
   * @param column the column of the cell whose height is to be set
   * @param height the cell's new height, in CSS units
   * @throws IndexOutOfBoundsException
   */
  void setHeight(int row, int column, String height) {
    _table.prepareCell(row, column);
    dart_html.Element elem = getCellElement(_table.bodyElem, row, column);
    Dom.setElementProperty(elem, "height", height);
  }

  /**
   * Sets the horizontal alignment of the specified cell.
   *
   * @param row the row of the cell whose alignment is to be set
   * @param column the column of the cell whose alignment is to be set
   * @param align the cell's new horizontal alignment as specified in
   *          {@link HasHorizontalAlignment}.
   * @throws IndexOutOfBoundsException
   */
  void setHorizontalAlignment(int row, int column,
                                     HorizontalAlignmentConstant align) {
    _table.prepareCell(row, column);
    dart_html.Element elem = getCellElement(_table.bodyElem, row, column);
    Dom.setElementProperty(elem, "align", align.getTextAlignString());
  }

  /**
   * Sets the style name associated with the specified cell.
  *
   * @param row the row of the cell whose style name is to be set
   * @param column the column of the cell whose style name is to be set
   * @param styleName the new style name
   * @see UiObject#setStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void setStyleName(int row, int column, String styleName) {
    _table.prepareCell(row, column);
    UiObject.setElementStyleName(getCellElement(_table.bodyElem, row, column), styleName);
  }

  /**
   * Sets the primary style name associated with the specified cell.
   *
   * @param row the row of the cell whose style name is to be set
   * @param column the column of the cell whose style name is to be set
   * @param styleName the new style name
   * @see UiObject#setStylePrimaryName(String)
   * @throws IndexOutOfBoundsException
   */
  void setStylePrimaryName(int row, int column, String styleName) {
    UiObject.setElementStylePrimaryName(getCellElement(_table.bodyElem, row, column), styleName);
  }

  /**
   * Sets the vertical alignment of the specified cell.
   *
   * @param row the row of the cell whose alignment is to be set
   * @param column the column of the cell whose alignment is to be set
   * @param align the cell's new vertical alignment as specified in
   *          {@link HasVerticalAlignment}.
   * @throws IndexOutOfBoundsException
   */
  void setVerticalAlignment(int row, int column,
                                   VerticalAlignmentConstant align) {
    _table.prepareCell(row, column);
    Dom.setStyleAttribute(getCellElement(_table.bodyElem, row, column),
        "verticalAlign", align.getVerticalAlignString());
  }

  /**
   * Sets whether this cell is visible via the display style property. The
   * other cells in the row will all shift left to fill the cell's space. So,
   * for example a table with (0,1,2) will become (1,2) if cell 1 is hidden.
   *
   * @param row the row of the cell whose visibility is to be set
   * @param column the column of the cell whose visibility is to be set
   * @param visible <code>true</code> to show the cell, <code>false</code> to
   *          hide it
   */
  void setVisible(int row, int column, bool visible) {
    dart_html.Element e = ensureElement(row, column);
    UiObject.setVisible(e, visible);
  }

  /**
   * Sets the width of the specified cell.
   *
   * @param row the row of the cell whose width is to be set
   * @param column the column of the cell whose width is to be set
   * @param width the cell's new width, in CSS units
   * @throws IndexOutOfBoundsException
   */
  void setWidth(int row, int column, String width) {
    // Give the subclass a chance to prepare the cell.
    _table.prepareCell(row, column);
    Dom.setElementProperty(getCellElement(_table.bodyElem, row, column), "width",
        width);
  }

  /**
   * Sets whether the specified cell will allow word wrapping of its contents.
   *
   * @param row the row of the cell whose word-wrap is to be set
   * @param column the column of the cell whose word-wrap is to be set
   * @param wrap <code>false </code> to disable word wrapping in this cell
   * @throws IndexOutOfBoundsException
   */
  void setWordWrap(int row, int column, bool wrap) {
    _table.prepareCell(row, column);
    String wrapValue = wrap ? "" : "nowrap";
    Dom.setStyleAttribute(getElement(row, column), "whiteSpace", wrapValue);
  }

  /**
   * Gets the element associated with a cell. If it does not exist and the
   * subtype allows creation of elements, creates it.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the cell's element
   * @throws IndexOutOfBoundsException
   */
  dart_html.Element ensureElement(int row, int column) {
    _table.prepareCell(row, column);
    return getCellElement(_table.bodyElem, row, column);
  }

  /**
   * Convenience methods to get an attribute on a cell.
   *
   * @param row cell's row
   * @param column cell's column
   * @param attr attribute to get
   * @return the attribute's value
   * @throws IndexOutOfBoundsException
   */
  String getAttr(int row, int column, String attr) {
    dart_html.Element elem = getElement(row, column);
    return elem.attributes[attr];
  }

  /**
   * Convenience methods to set an attribute on a cell.
   *
   * @param row cell's row
   * @param column cell's column
   * @param attrName attribute to set
   * @param value value to set
   * @throws IndexOutOfBoundsException
   */
  void setAttr(int row, int column, String attrName, String value) {
    dart_html.Element elem = ensureElement(row, column);
    Dom.setElementAttribute(elem, attrName, value);
  }

  /**
   * Native method to get a cell's element.
   *
   * @param table the table element
   * @param row the row of the cell
   * @param col the column of the cell
   * @return the element
   */
  dart_html.Element getCellElement(dart_html.TableElement table, int row, int col) {
    return (table.rows[row] as dart_html.TableRowElement).cells[col];
  }

  /**
   * Gets the TD element representing the specified cell unsafely (meaning
   * that it doesn't ensure that <code>row</code> and <code>column</code> are
   * valid).
   *
   * @param row the row of the cell to be retrieved
   * @param column the column of the cell to be retrieved
   * @return the cell's TD element
   */
  dart_html.Element getRawElement(int row, int column) {
    return getCellElement(_table.bodyElem, row, column);
  }
}


/**
 * This class contains methods used to format a table's columns. It is limited
 * by the support cross-browser HTML support for column formatting.
 */
class ColumnFormatter {
  dart_html.Element columnGroup;
  HtmlTable _table;

  /**
   * Adds a style to the specified column.
   *
   * @param col the col to which the style will be added
   * @param styleName the style name to be added
   * @see UiObject#addStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void addStyleName(int col, String styleName) {
    UiObject.manageElementStyleName(ensureColumn(col), styleName, true);
  }

  /**
   * Get the col element for the column.
   *
   * @param column the column index
   * @return the col element
   */
  dart_html.Element getElement(int column) {
    return ensureColumn(column);
  }

  /**
   * Gets the style of the specified column.
   *
   * @param column the column to be queried
   * @return the style name
   * @see UiObject#getStyleName()
   * @throws IndexOutOfBoundsException
   */
  String getStyleName(int column) {
    return UiObject.getElementStyleName(ensureColumn(column));
  }

  /**
   * Gets the primary style of the specified column.
   *
   * @param column the column to be queried
   * @return the style name
   * @see UiObject#getStylePrimaryName()
   * @throws IndexOutOfBoundsException
   */
  String getStylePrimaryName(int column) {
    return UiObject.getElementStylePrimaryName(ensureColumn(column));
  }

  /**
   * Removes a style from the specified column.
   *
   * @param column the column from which the style will be removed
   * @param styleName the style name to be removed
   * @see UiObject#removeStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void removeStyleName(int column, String styleName) {
    UiObject.manageElementStyleName(ensureColumn(column), styleName, false);
  }

  /**
   * Sets the style name associated with the specified column.
   *
   * @param column the column whose style name is to be set
   * @param styleName the new style name
   * @see UiObject#setStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void setStyleName(int column, String styleName) {
    UiObject.setElementStyleName(ensureColumn(column), styleName);
  }

  /**
   * Sets the primary style name associated with the specified column.
   *
   * @param column the column whose style name is to be set
   * @param styleName the new style name
   * @see UiObject#setStylePrimaryName(String)
   * @throws IndexOutOfBoundsException
   */
  void setStylePrimaryName(int column, String styleName) {
    UiObject.setElementStylePrimaryName(ensureColumn(column), styleName);
  }

  /**
   * Sets the width of the specified column.
   *
   * @param column the column of the cell whose width is to be set
   * @param width the cell's new width, in percentage or pixel units
   * @throws IndexOutOfBoundsException
   */
  void setWidth(int column, String width) {
    Dom.setElementProperty(ensureColumn(column), "width", width);
  }

  /**
   * Resize the column group element.
   *
   * @param columns the number of columns
   * @param growOnly true to only grow, false to shrink if needed
   */
  void resizeColumnGroup(int columns, bool growOnly) {
    // The colgroup should always have at least one element.  See
    // prepareColumnGroup() for more details.
    columns = dart_math.max(columns, 1);

    int num = columnGroup.children.length;
    if (num < columns) {
      for (int i = num; i < columns; i++) {
        columnGroup.append(new dart_html.TableColElement());
      }
    } else if (!growOnly && num > columns) {
      for (int i = num; i > columns; i--) {
        columnGroup.$dom_lastChild.remove();
      }
    }
  }

  dart_html.Element ensureColumn(int col) {
    _table.prepareColumn(col);
    prepareColumnGroup();
    resizeColumnGroup(col + 1, true);
    return columnGroup.children[col];
  }

  /**
   * Prepare the colgroup tag for the first time, guaranteeing that it exists
   * and has at least one col tag in it. This method corrects a Mozilla issue
   * where the col tag will affect the wrong column if a col tag doesn't exist
   * when the element is attached to the page.
   */
  void prepareColumnGroup() {
    if (columnGroup == null) {
      columnGroup = new dart_html.Element.tag("colgroup");
      Dom.insertChild(_table.tableElem, columnGroup, 0);
      columnGroup.append(new dart_html.TableColElement());
    }
  }
}

/**
 * This class contains methods used to format a table's rows.
 */
class RowFormatter {

  HtmlTable _table;

  /**
   * Adds a style to the specified row.
   *
   * @param row the row to which the style will be added
   * @param styleName the style name to be added
   * @see UiObject#addStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void addStyleName(int row, String styleName) {
    UiObject.manageElementStyleName(ensureElement(row), styleName, true);
  }

  /**
   * Gets the TR element representing the specified row.
   *
   * @param row the row whose TR element is to be retrieved
   * @return the row's TR element
   * @throws IndexOutOfBoundsException
   */
  dart_html.Element getElement(int row) {
    _table.checkRowBounds(row);
    return getRow(_table.bodyElem, row);
  }

  /**
   * Gets the style of the specified row.
   *
   * @param row the row to be queried
   * @return the style name
   * @see UiObject#getStyleName()
   * @throws IndexOutOfBoundsException
   */
  String getStyleName(int row) {
    return UiObject.getElementStyleName(getElement(row));
  }

  /**
   * Gets the primary style of the specified row.
   *
   * @param row the row to be queried
   * @return the style name
   * @see UiObject#getStylePrimaryName()
   * @throws IndexOutOfBoundsException
   */
  String getStylePrimaryName(int row) {
    return UiObject.getElementStylePrimaryName(getElement(row));
  }

  /**
   * Determines whether or not this row is visible via the display style
   * attribute.
   *
   * @param row the row whose visibility is to be set
   * @return <code>true</code> if the row is visible
   */
  bool isVisible(int row) {
    dart_html.Element e = getElement(row);
    return UiObject.isVisible(e);
  }

  /**
   * Removes a style from the specified row.
   *
   * @param row the row from which the style will be removed
   * @param styleName the style name to be removed
   * @see UiObject#removeStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void removeStyleName(int row, String styleName) {
    UiObject.manageElementStyleName(ensureElement(row), styleName, false);
  }

  /**
   * Sets the style name associated with the specified row.
   *
   * @param row the row whose style name is to be set
   * @param styleName the new style name
   * @see UiObject#setStyleName(String)
   * @throws IndexOutOfBoundsException
   */
  void setStyleName(int row, String styleName) {
    UiObject.setElementStyleName(ensureElement(row), styleName);
  }

  /**
   * Sets the primary style name associated with the specified row.
   *
   * @param row the row whose style name is to be set
   * @param styleName the new style name
   * @see UiObject#setStylePrimaryName(String)
   * @throws IndexOutOfBoundsException
   */
  void setStylePrimaryName(int row, String styleName) {
    UiObject.setElementStylePrimaryName(ensureElement(row), styleName);
  }

  /**
   * Sets the vertical alignment of the specified row.
   *
   * @param row the row whose alignment is to be set
   * @param align the row's new vertical alignment as specified in
   *          {@link HasVerticalAlignment}
   * @throws IndexOutOfBoundsException
   */
  void setVerticalAlign(int row, VerticalAlignmentConstant align) {
    Dom.setStyleAttribute(ensureElement(row), "verticalAlign",
        align.getVerticalAlignString());
  }

  /**
   * Sets whether this row is visible.
   *
   * @param row the row whose visibility is to be set
   * @param visible <code>true</code> to show the row, <code>false</code> to
   *          hide it
   */
  void setVisible(int row, bool visible) {
    dart_html.Element e = ensureElement(row);
    UiObject.setVisible(e, visible);
  }

  /**
   * Ensure the TR element representing the specified row exists for
   * subclasses that allow dynamic addition of elements.
   *
   * @param row the row whose TR element is to be retrieved
   * @return the row's TR element
   * @throws IndexOutOfBoundsException
   */
  dart_html.Element ensureElement(int row) {
    _table.prepareRow(row);
    return getRow(_table.bodyElem, row);
  }

  dart_html.Element getRow(dart_html.Element elem, int row) {
    return (elem.parent as dart_html.TableElement).rows[row];
  }

  /**
   * Convenience methods to set an attribute on a row.
   *
   * @param row cell's row
   * @param attrName attribute to set
   * @param value value to set
   * @throws IndexOutOfBoundsException
   */
  void setAttr(int row, String attrName, String value) {
    dart_html.Element elem = ensureElement(row);
    Dom.setElementAttribute(elem, attrName, value);
  }
}

class _WidgetIterator implements Iterator<Widget> {

  HtmlTable _table;

  List<Widget> widgetList;
  int lastIndex = -1;
  int nextIndex = -1;

  _WidgetIterator(this._table) {
    widgetList = _table.widgetMap.getObjectList();
    findNext();
  }

  bool moveNext() {
    return nextIndex < widgetList.length;
  }

  Widget get current => _getCurrent();
  
  Widget _getCurrent() {
    if (!moveNext()) {
      throw new Exception("NoSuchElement");
    }
    Widget result = widgetList[nextIndex];
    lastIndex = nextIndex;
    findNext();
    return result;
  }

  void remove() {
    if (lastIndex < 0) {
      throw new Exception("IllegalState");
    }
    Widget w = widgetList[lastIndex];
    assert (w.getParent() is HtmlTable);
    w.removeFromParent();
    lastIndex = -1;
  }

  void findNext() {
    while (++nextIndex < widgetList.length) {
      if (widgetList[nextIndex] != null) {
        return;
      }
    }
  }
}