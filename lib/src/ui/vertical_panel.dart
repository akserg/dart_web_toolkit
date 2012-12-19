//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that lays all of its widgets out in a single vertical column.
 * 
 * <p>
 * <img class='gallery' src='doc-files/VerticalPanel.png'/>
 * </p>
 */
class VerticalPanel extends CellPanel implements HasAlignment, InsertPanelForIsWidget {
  
  String _horzAlign = "left"; //ALIGN_DEFAULT;
  String _vertAlign = "top"; //ALIGN_TOP;
  
  /**
   * Creates an empty vertical panel.
   */
  VerticalPanel() {
    Dom.setElementProperty(getTable(), "cellSpacing", "0");
    Dom.setElementProperty(getTable(), "cellPadding", "0");
  }
  
  void add(Widget w) {
    dart_html.Element tr = new dart_html.TableRowElement();
    dart_html.Element td = _createAlignedTd();
    tr.append(td);
    getBody().append(tr);
    addWidget(w, td);
  }
  
  String getHorizontalAlignment() {
    return _horzAlign;
  }
  
  /**
   * Sets the default horizontal alignment to be used for widgets added to this
   * panel. It only applies to widgets added after this property is set.
   * 
   * @see HasHorizontalAlignment#setHorizontalAlignment(HasHorizontalAlignment.HorizontalAlignmentConstant)
   */
  void setHorizontalAlignment(String align) {
    _horzAlign = align;
  }

  String getVerticalAlignment() {
    return _vertAlign;
  }
  
  /**
   * Sets the default vertical alignment to be used for widgets added to this
   * panel. It only applies to widgets added after this property is set.
   * 
   * @see HasVerticalAlignment#setVerticalAlignment(HasVerticalAlignment.VerticalAlignmentConstant)
   */
  void setVerticalAlignment(String align) {
    _vertAlign = align;
  }
  
  void insertIsWidget(IsWidget w, int beforeIndex) {
    insertWidget(asWidgetOrNull(w), beforeIndex);
  }
  
  void insertWidget(Widget w, int beforeIndex) {
    checkIndexBoundsForInsertion(beforeIndex);

    dart_html.Element tr = new dart_html.TableRowElement();
    dart_html.Element td = _createAlignedTd();
    tr.append(td);

    /*
     * The case where we reinsert an already existing child is tricky.
     * 
     * For the WIDGET, it ultimately removes first and inserts second, so we
     * have to adjust the index within ComplexPanel.insert(). But for the DOM,
     * we insert first and remove second, which means we DON'T need to adjust
     * the index.
     */
    Dom.insertChild(getBody(), tr, beforeIndex);
    insert(w, td, beforeIndex, false);
  }
  
  bool remove(Widget w) {
    /*
     * Get the TR to be removed before calling super.remove() because
     * super.remove() will detach the child widget's element from its parent.
     */
    dart_html.Element td = w.getElement().parent;//DOM.getParent(w.getElement());
    bool removed = super.remove(w);
    if (removed) {
      //DOM.removeChild(getBody(), DOM.getParent(td));
      getBody().$dom_removeChild(td.parent);
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
