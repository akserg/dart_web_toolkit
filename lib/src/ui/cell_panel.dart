//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel whose child widgets are contained within the cells of a table. Each
 * cell's size may be set independently. Each child widget can take up a subset
 * of its cell and can be aligned within it.
 *
 * <p>
 * Note: This class is not related to the
 * {@link com.google.gwt.cell.client.Cell} based data presentation widgets such
 * as {@link com.google.gwt.user.cellview.client.CellList} and
 * {@link com.google.gwt.user.cellview.client.CellTable}.
 *
 * <h3>Use in UiBinder Templates</h3>
 * <P>
 * When working with CellPanel subclasses in
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates, wrap
 * child widgets in <code>&lt;g:cell></code> elements. (Note the lower case
 * "c", meant to signal that the cell is not a runtime object, and so cannot
 * have a <code>ui:field</code> attribute.) Cell elements can have
 * attributes setting their height, width and alignment.
 * <h4>&lt;g:cell> attributes</h4>
 * <p>
 * <dl>
 * <dt>horizontalAlignment
 * <dd>Interpreted as a static member of {@link HorizontalAlignmentConstant}
 * and used as the <code>align</code> argument to {@link #setCellHorizontalAlignment}
 * <dt>verticalAlignment
 * <dd>Interpreted as a static member of {@link VerticalAlignmentConstant}
 * and used as the <code>align</code> argument to {@link #setCellVerticalAlignment}
 * <dt>width
 * <dd>Used as the <code>width</code> argument to {@link #setCellWidth}
 * <dt>height
 * <dd>Used as the <code>height</code> argument to {@link #setCellHeight}
 * </dl>
 * <p>
 * For example:<pre>
 * &lt;g:HorizontalPanel>
 *   &lt;g:cell width='5em' horizontalAlignment='ALIGN_RIGHT'>
 *     &lt;g:Label ui:field='leftSide' />
 *   &lt;/g:cell>
 *   &lt;g:cell width='15em' horizontalAlignment='ALIGN_LEFT'>
 *     &lt;g:Label ui:field='rightSide' />
 *   &lt;/g:cell>
 * &lt;/g:HorizontalPanel>
 * </pre>
 */
abstract class CellPanel extends ComplexPanel {

  int _spacing;
  dart_html.TableElement _table;
  dart_html.Element _body;

  CellPanel() {
    _table = new dart_html.TableElement();
    _body = _table.createTBody();
    setElement(_table);
  }

  //***********
  // Properties
  //***********

  /**
   * Gets the amount of spacing between this panel's cells.
   *
   * @return the inter-cell spacing, in pixels
   */
  int get spacing => _spacing;

  /**
   * Sets the amount of spacing between this panel's cells.
   *
   * @param spacing the inter-cell spacing, in pixels
   */
  void set spacing(int val) {
    _spacing = val;
    Dom.setElementPropertyInt(_table, "cellSpacing", spacing);
  }

  /**
   * Sets the width of the border to be applied to all cells in this panel. This
   * is particularly useful when debugging layouts, in that it allows you to see
   * explicitly the cells that contain this panel's children.
   *
   * @param width the width of the panel's cell borders, in pixels
   */
  void set borderWidth(int width) {
    assert(width != null);
    Dom.setElementProperty(_table, "border", width.toString());
  }


  dart_html.Element getBody() {
    return _body;
  }

  dart_html.Element getTable() {
    return _table;
  }

  void setCellHorizontalAlignment(dart_html.TableCellElement td, HorizontalAlignmentConstant align) {
    Dom.setElementProperty(td, "align", align.getTextAlignString());
  }

  void setCellVerticalAlignment(dart_html.TableCellElement td, VerticalAlignmentConstant align) {
    Dom.setStyleAttribute(td, "verticalAlign", align.getVerticalAlignString());
  }

  dart_html.Element getWidgetTd(Widget w) {
    if (w.getParent() != this) {
      return null;
    }
    return w.getElement().parent; // DOM.getParent(w.getElement());
  }
  //**************
  // Widget's Cell
  //**************


  /**
   * Sets the height of the cell associated with the given widget, related to
   * the panel as a whole.
   *
   * @param w the widget whose cell height is to be set
   * @param height the cell's height, in CSS units
   */
  void setWidgetCellHeight(Widget w, String height) {
    dart_html.TableCellElement td = getWidgetTd(w);
    if (td != null) {
      td.style.height = height;
    }
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #setCellHeight(Widget,String)
   */
  void setIsWidgetCellHeight(IsWidget w, String height) {
    this.setWidgetCellHeight(w.asWidget(), height);
  }

  /**
   * Sets the horizontal alignment of the given widget within its cell.
   *
   * @param w the widget whose horizontal alignment is to be set
   * @param align the widget's horizontal alignment, as defined in
   *          {@link HasHorizontalAlignment}.
   */
  void setWidgetCellHorizontalAlignment(Widget w, HorizontalAlignmentConstant align) {
    dart_html.Element td = getWidgetTd(w);
    if (td != null) {
      setCellHorizontalAlignment(td, align);
    }
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #setCellHorizontalAlignment(Widget,HasHorizontalAlignment.HorizontalAlignmentConstant)
   */
  void setIsWidgetCellHorizontalAlignment(IsWidget w, HorizontalAlignmentConstant align) {
    this.setWidgetCellHorizontalAlignment(w.asWidget(), align);
  }

  /**
   * Sets the vertical alignment of the given widget within its cell.
   *
   * @param w the widget whose vertical alignment is to be set
   * @param align the widget's vertical alignment, as defined in
   *          {@link HasVerticalAlignment}.
   */
  void setWidgetCellVerticalAlignment(Widget w, VerticalAlignmentConstant align) {
    dart_html.Element td = getWidgetTd(w);
    if (td != null) {
      setCellVerticalAlignment(td, align);
    }
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #setCellVerticalAlignment(Widget,HasVerticalAlignment.VerticalAlignmentConstant)
   */
  void setIsWidgetCellVerticalAlignment(IsWidget w, VerticalAlignmentConstant align) {
    this.setWidgetCellVerticalAlignment(w.asWidget(),align);
  }

  /**
   * Sets the width of the cell associated with the given widget, related to the
   * panel as a whole.
   *
   * @param w the widget whose cell width is to be set
   * @param width the cell's width, in CSS units
   */
  void setWidgetCellWidth(Widget w, String width) {
    dart_html.TableCellElement td = getWidgetTd(w);
    if (td != null) {
      //td.wisetPropertyString("width", width);
      td.style.width = width;
    }
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #setCellWidth(Widget,String)
   */
  void setIsWidgetCellWidth(IsWidget w, String width) {
    this.setWidgetCellWidth(w.asWidget(), width);
  }
}
