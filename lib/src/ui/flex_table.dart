//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A flexible table that creates cells on demand. It can be jagged (that is,
 * each row can contain a different number of cells) and individual cells can be
 * set to span multiple rows or columns.
 * <p>
 * <img class='gallery' src='doc-files/Table.png'/>
 * </p>
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.FlexTableExample}
 * </p>
 */
class FlexTable extends HtmlTable {

  static void addCells(dart_html.Element table, int row, int num){
    if (table is! dart_html.TableElement) {
      table = table.parent as dart_html.TableElement;
    }
    assert (table is dart_html.TableElement);
    dart_html.TableRowElement rowElem = table.rows[row];
    for(int i = 0; i < num; i++) {
      rowElem.append(new dart_html.TableCellElement());
    }
  }

  FlexTable() : super() {
    setCellFormatter(new FlexCellFormatter(this));
    setRowFormatter(new RowFormatter());
    setColumnFormatter(new ColumnFormatter());
  }

  /**
   * Appends a cell to the specified row.
   *
   * @param row the row to which the new cell will be added
   * @throws IndexOutOfBoundsException
   */
  void addCell(int row) {
    insertCell(row, getCellCount(row));
  }

  /**
   * Gets the number of cells on a given row.
   *
   * @param row the row whose cells are to be counted
   * @return the number of cells present
   * @throws IndexOutOfBoundsException
   */

  int getCellCount(int row) {
    checkRowBounds(row);
    return getDomCellCount(row, getBodyElement());
  }

  /**
   * Explicitly gets the {@link FlexCellFormatter}. The results of
   * {@link HTMLTable#getCellFormatter()} may also be downcast to a
   * {@link FlexCellFormatter}.
   *
   * @return the FlexTable's cell formatter
   */
  FlexCellFormatter getFlexCellFormatter() {
    return getCellFormatter() as FlexCellFormatter;
  }

  /**
   * Gets the number of rows.
   *
   * @return number of rows
   */

  int getRowCount() {
    return getDomRowCount();
  }

  /**
   * Inserts a cell into the FlexTable.
   *
   * @param beforeRow the cell's row
   * @param beforeColumn the cell's column
   */

  void insertCell(int beforeRow, int beforeColumn) {
    super.insertCell(beforeRow, beforeColumn);
  }

  /**
   * Inserts a row into the FlexTable.
   *
   * @param beforeRow the row to insert
   */

  int insertRow(int beforeRow) {
    return super.insertRow(beforeRow);
  }

  /**
   * Remove all rows in this table.
   */
  void removeAllRows() {
    int numRows = getRowCount();
    for (int i = 0; i < numRows; i++) {
      removeRow(0);
    }
  }


  void removeCell(int row, int col) {
    super.removeCell(row, col);
  }

  /**
   * Removes a number of cells from a row in the table.
   *
   * @param row the row of the cells to be removed
   * @param column the column of the first cell to be removed
   * @param num the number of cells to be removed
   * @throws IndexOutOfBoundsException
   */
  void removeCells(int row, int column, int num) {
    for (int i = 0; i < num; i++) {
      removeCell(row, column);
    }
  }


  void removeRow(int row) {
    super.removeRow(row);
  }

  /**
   * Ensure that the cell exists.
   *
   * @param row the row to prepare.
   * @param column the column to prepare.
   * @throws IndexOutOfBoundsException if the row is negative
   */

  void prepareCell(int row, int column) {
    prepareRow(row);
    if (column < 0) {
      throw new Exception("IndexOutOfBounds. Cannot create a column with a negative index: $column");
    }

    // Ensure that the requested column exists.
    int cellCount = getCellCount(row);
    int required = column + 1 - cellCount;
    if (required > 0) {
      addCells(getBodyElement(), row, required);
    }
  }

  /**
   * Ensure that the row exists.
   *
   * @param row The row to prepare.
   * @throws IndexOutOfBoundsException if the row is negative
   */

  void prepareRow(int row) {
    if (row < 0) {
      throw new Exception("IndexOutOfBounds. Cannot create a row with a negative index: $row");
    }

    // Ensure that the requested row exists.
    int rowCount = getRowCount();
    for (int i = rowCount; i <= row; i++) {
      insertRow(i);
    }
  }
}

/**
 * FlexTable-specific implementation of {@link HTMLTable.CellFormatter}. The
 * formatter retrieved from {@link HTMLTable#getCellFormatter()} may be cast
 * to this class.
 */
class FlexCellFormatter extends CellFormatter {

  FlexCellFormatter(HtmlTable table) : super(table);

  /**
   * Gets the column span for the given cell. This is the number of logical
   * columns covered by the cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the cell's column span
   * @throws IndexOutOfBoundsException
   */
  int getColSpan(int row, int column) {
    return Dom.getElementPropertyInt(getElement(row, column), "colSpan");
  }

  /**
   * Gets the row span for the given cell. This is the number of logical rows
   * covered by the cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @return the cell's row span
   * @throws IndexOutOfBoundsException
   */
  int getRowSpan(int row, int column) {
    return Dom.getElementPropertyInt(getElement(row, column), "rowSpan");
  }

  /**
   * Sets the column span for the given cell. This is the number of logical
   * columns covered by the cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @param colSpan the cell's column span
   * @throws IndexOutOfBoundsException
   */
  void setColSpan(int row, int column, int colSpan) {
    Dom.setElementPropertyInt(ensureElement(row, column), "colSpan", colSpan);
  }

  /**
   * Sets the row span for the given cell. This is the number of logical rows
   * covered by the cell.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @param rowSpan the cell's row span
   * @throws IndexOutOfBoundsException
   */
  void setRowSpan(int row, int column, int rowSpan) {
    Dom.setElementPropertyInt(ensureElement(row, column), "rowSpan", rowSpan);
  }
}
