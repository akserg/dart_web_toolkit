//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that lays all of its widgets out in a single horizontal column.
 *
 * <p>
 * <img class='gallery' src='doc-files/HorizontalPanel.png'/>
 * </p>
 */
class HorizontalPanel extends CellPanel implements HasAlignment, InsertPanelForIsWidget {

  HorizontalAlignmentConstant _horzAlign = HasHorizontalAlignment.ALIGN_DEFAULT;
  VerticalAlignmentConstant _vertAlign = HasVerticalAlignment.ALIGN_TOP;
  dart_html.Element _tableRow;

  /**
   * Creates an empty horizontal panel.
   */
  HorizontalPanel() {
    _tableRow = new dart_html.TableRowElement();
    getBody().append(_tableRow);

    Dom.setElementProperty(getTable(), "cellSpacing", "0");
    Dom.setElementProperty(getTable(), "cellPadding", "0");
  }

  void add(Widget w) {
    dart_html.Element td = _createAlignedTd();
    _tableRow.append(td);
    addWidget(w, td);
  }

  HorizontalAlignmentConstant getHorizontalAlignment() {
    return _horzAlign;
  }

  /**
   * Sets the default horizontal alignment to be used for widgets added to this
   * panel. It only applies to widgets added after this property is set.
   *
   * @see HasHorizontalAlignment#setHorizontalAlignment(HasHorizontalAlignment.HorizontalAlignmentConstant)
   */
  void setHorizontalAlignment(HorizontalAlignmentConstant align) {
    _horzAlign = align;
  }

  VerticalAlignmentConstant getVerticalAlignment() {
    return _vertAlign;
  }

  /**
   * Sets the default vertical alignment to be used for widgets added to this
   * panel. It only applies to widgets added after this property is set.
   *
   * @see HasVerticalAlignment#setVerticalAlignment(HasVerticalAlignment.VerticalAlignmentConstant)
   */
  void setVerticalAlignment(VerticalAlignmentConstant align) {
    _vertAlign = align;
  }

  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertAt(Widget.asWidgetOrNull(w), beforeIndex);
  }

  void insertAt(Widget w, int beforeIndex) {
    checkIndexBoundsForInsertion(beforeIndex);

    /*
     * The case where we reinsert an already existing child is tricky.
     *
     * For the WIDGET, it ultimately removes first and inserts second, so we
     * have to adjust the index within ComplexPanel.insert(). But for the DOM,
     * we insert first and remove second, which means we DON'T need to adjust
     * the index.
     */
    dart_html.Element td = _createAlignedTd();
    Dom.insertChild(_tableRow, td, beforeIndex);
    insert(w, td, beforeIndex, false);
  }

  bool remove(Widget w) {
    // Get the TD to be removed, before calling super.remove(), because
    // super.remove() will detach the child widget's element from its parent.
    dart_html.Element td = w.getElement().parent;
    bool removed = super.remove(w);
    if (removed) {
      //_tableRow.$dom_removeChild(td);
      td.remove();
    }
    return removed;
  }

  dart_html.Element _createAlignedTd() {
    dart_html.Element td = new dart_html.TableCellElement();
    setCellHorizontalAlignment(td, _horzAlign);
    setCellVerticalAlignment(td, _vertAlign);
    return td;
  }
}
