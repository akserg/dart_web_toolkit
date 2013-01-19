//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A rectangular grid that can contain text, html, or a child
 * {@link com.google.gwt.user.client.ui.Widget} within its cells. It must be
 * resized explicitly to the desired number of rows and columns.
 * <p>
 * <img class='gallery' src='doc-files/Table.png'/>
 * </p>
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.GridExample}
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * Grid widget consists of &lt;g:row> elements. Each &lt;g:row> element
 * can contain one or more &lt;g:cell> or &lt;g:customCell> elements.
 * Using &lt;g:cell> attribute it is possible to place pure HTML content.
 * &lt;g:customCell> is used as a container for
 * {@link com.google.gwt.user.client.ui.Widget} type objects. (Note that the
 * tags of the row, cell and customCell elements are not capitalized. This
 * is meant to signal that the item is not a runtime object, and so cannot
 * have a <code>ui:field</code> attribute.)
 * <p>
 * For example:
 *
 * <pre>
 * &lt;g:Grid>
 *  &lt;g:row styleName="optionalHeaderStyle">
 *    &lt;g:customCell styleName="optionalFooCellStyle">
 *      &lt;g:Label>foo&lt;/g:Label>
 *    &lt;/g:customCell>
 *    &lt;g:customCell styleName="optionalBarCellStyle">
 *      &lt;g:Label>bar&lt;/g:Label>
 *    &lt;/g:customCell>
 *  &lt;/g:row>
 *  &lt;g:row>
 *    &lt;g:cell>
 *      &lt;div>foo&lt;/div>
 *    &lt;/g:cell>
 *    &lt;g:cell>
 *      &lt;div>bar&lt;/div>
 *    &lt;/g:cell>
 *  &lt;/g:row>
 * &lt;/g:Grid>
 * </pre>
 */
class Grid extends HtmlTable {

  /**
   * Native method to add rows into a table with a given number of columns.
   *
   * @param table the table element
   * @param rows number of rows to add
   * @param columns the number of columns per row
   */
  static void addRows(dart_html.Element table, int rows, int columns) {
    dart_html.TableCellElement td = new dart_html.TableCellElement();
     td.innerHtml = "&nbsp;";
     dart_html.TableRowElement row = new dart_html.TableRowElement();
     for(var cellNum = 0; cellNum < columns; cellNum++) {
       var cell = td.clone(true);
       row.append(cell);
     }
     table.append(row);
     for(var rowNum = 1; rowNum < rows; rowNum++) {
       table.append(row.clone(true));
     }
   }

  /**
   * Number of columns in the current grid.
   */
  int numColumns = 0;

  /**
   * Number of rows in the current grid.
   */
  int numRows = 0;

  /**
   * Constructor for <code>Grid</code>. If [rows] and [cols] specified grid will
   * constructs with the requested size.
   */
  Grid([int rows = null, int columns = null]) : super() {
    setCellFormatter(new CellFormatter(this));
    setRowFormatter(new RowFormatter());
    setColumnFormatter(new ColumnFormatter());
    //
    if (rows != null && columns != null) {
      resize(rows, columns);
    }
  }

  /**
   * Replaces the contents of the specified cell with a single space.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @throws IndexOutOfBoundsException
   */

  bool clearCell(int row, int column) {
    dart_html.Element td = getCellFormatter().getElement(row, column);
    bool b = internalClearCell(td, false);
    td.innerHtml = "&nbsp;";
    return b;
  }

  /**
   * Return number of columns. For grid, row argument is ignored as all grids
   * are rectangular.
   */

  int getCellCount(int row) {
    return numColumns;
  }

  /**
   * Gets the number of columns in this grid.
   *
   * @return the number of columns
   */
  int getColumnCount() {
    return numColumns;
  }

  /**
   * Return number of rows.
   */

  int getRowCount() {
    return numRows;
  }

  /**
   * Inserts a new row into the table. If you want to add multiple rows at once,
   * use {@link #resize(int, int)} or {@link #resizeRows(int)} as they are more
   * efficient.
   *
   * @param beforeRow the index before which the new row will be inserted
   * @return the index of the newly-created row
   * @throws IndexOutOfBoundsException
   */

  int insertRow(int beforeRow) {
    // Physically insert the row
    int index = super.insertRow(beforeRow);
    numRows++;

    // Add the columns to the new row
    for (int i = 0; i < numColumns; i++) {
      insertCell(index, i);
    }

    return index;
  }


  void removeRow(int row) {
    super.removeRow(row);
    numRows--;
  }

  /**
   * Resizes the grid.
   *
   * @param rows the number of rows
   * @param columns the number of columns
   * @throws IndexOutOfBoundsException
   */
  void resize(int rows, int columns) {
    resizeColumns(columns);
    resizeRows(rows);
  }

  /**
   * Resizes the grid to the specified number of columns.
   *
   * @param columns the number of columns
   * @throws IndexOutOfBoundsException
   */
  void resizeColumns(int columns) {
    if (numColumns == columns) {
      return;
    }
    if (columns < 0) {
      throw new Exception("IndexOutOfBounds. Cannot set number of columns to $columns");
    }

    if (numColumns > columns) {
      // Fewer columns. Remove extraneous cells.
      for (int i = 0; i < numRows; i++) {
        for (int j = numColumns - 1; j >= columns; j--) {
          removeCell(i, j);
        }
      }
    } else {
      // More columns. add cells where necessary.
      for (int i = 0; i < numRows; i++) {
        for (int j = numColumns; j < columns; j++) {
          insertCell(i, j);
        }
      }
    }
    numColumns = columns;

    // Update the size of the colgroup.
    getColumnFormatter().resizeColumnGroup(columns, false);
  }

  /**
   * Resizes the grid to the specified number of rows.
   *
   * @param rows the number of rows
   * @throws IndexOutOfBoundsException
   */
  void resizeRows(int rows) {
    if (numRows == rows) {
      return;
    }
    if (rows < 0) {
      throw new Exception("IndexOutOfBounds. Cannot set number of rows to $rows");
    }
    if (numRows < rows) {
      addRows(getBodyElement(), rows - numRows, numColumns);
      numRows = rows;
    } else {
      while (numRows > rows) {
        // Fewer rows. Remove extraneous ones.
        removeRow(numRows - 1);
      }
    }
  }

  /**
   * Creates a new, empty cell.
   */

  dart_html.Element createCell() {
    dart_html.Element td = super.createCell();

    // Add a non-breaking space to the TD. This ensures that the cell is
    // displayed.
    td.innerHtml= "&nbsp;";
    return td;
  }

  /**
   * Checks that a cell is a valid cell in the table.
   *
   * @param row the cell's row
   * @param column the cell's column
   * @throws IndexOutOfBoundsException
   */

  void prepareCell(int row, int column) {
    // Ensure that the indices are not negative.
    prepareRow(row);
    if (column < 0) {
      throw new Exception("IndexOutOfBounds. Cannot access a column with a negative index: $column");
    }

    if (column >= numColumns) {
      throw new Exception("IndexOutOfBounds. Column index: $column, Column size: $numColumns");
    }
  }

  /**
   * Checks that the column index is valid.
   *
   * @param column The column index to be checked
   * @throws IndexOutOfBoundsException if the column is negative
   */

  void prepareColumn(int column) {
    super.prepareColumn(column);

    /**
     * Grid does not lazily create cells, so simply ensure that the requested
     * column and column are valid
     */
    if (column >= numColumns) {
      throw new Exception("IndexOutOfBounds. Column index: $column, Column size: $numColumns");
    }
  }

  /**
   * Checks that the row index is valid.
   *
   * @param row The row index to be checked
   * @throws IndexOutOfBoundsException if the row is negative
   */

  void prepareRow(int row) {
    // Ensure that the indices are not negative.
    if (row < 0) {
      throw new Exception("IndexOutOfBounds. Cannot access a row with a negative index: $row");
    }

    /**
     * Grid does not lazily create cells, so simply ensure that the requested
     * row and column are valid
     */
    if (row >= numRows) {
      throw new Exception("IndexOutOfBounds. Row index: $row, Row size: $numRows");
    }
  }
}
