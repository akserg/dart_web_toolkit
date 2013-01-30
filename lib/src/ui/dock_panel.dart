//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that lays its child widgets out "docked" at its outer edges, and
 * allows its last widget to take up the remaining space in its center.
 *
 * <p>
 * This widget has limitations in standards mode that did not exist in quirks
 * mode. The child Widgets contained within a DockPanel cannot be sized using
 * percentages. Setting a child widget's height to <code>100%</code> will
 * <em>NOT</em> cause the child to fill the available height.
 * </p>
 *
 * <p>
 * If you need to work around these limitations, use {@link DockLayoutPanel}
 * instead, but understand that it is not a drop in replacement for this class.
 * It requires standards mode, and is most easily used under a
 * {@link RootLayoutPanel} (as opposed to a {@link RootPanel}).
 * </p>
 *
 * <p>
 * <img class='gallery' src='doc-files/DockPanel.png'/>
 * </p>
 *
 * @see DockLayoutPanel
 */
class DockPanel extends CellPanel implements HasAlignment {

  HorizontalAlignmentConstant _horzAlign = HasHorizontalAlignment.ALIGN_DEFAULT;
  VerticalAlignmentConstant _vertAlign = HasVerticalAlignment.ALIGN_TOP;
  Widget _center;

  /**
   * Creates an empty dock panel.
   */
  DockPanel() {
    Dom.setElementPropertyInt(getTable(), "cellSpacing", 0);
    Dom.setElementPropertyInt(getTable(), "cellPadding", 0);
  }

  /**
   * Adds a widget to the specified edge of the dock. If the widget is already a
   * child of this panel, this method behaves as though {@link #remove(Widget)}
   * had already been called.
   *
   * @param widget the widget to be added
   * @param direction the widget's direction in the dock
   *
   * @throws Exception when adding to the {@link #CENTER} and
   *           there is already a different widget there
   */
  void addWidgetTo(Widget widget, DockLayoutConstant direction) {
    // Validate
    if (direction == DockLayoutConstant.CENTER) {
      // Early out on the case of reinserting the center at the center.
      if (widget == _center) {
        return;
      } else if (_center != null) {
        // Ensure a second 'center' widget is not being added.
        throw new Exception(
            "Only one CENTER widget may be added");
      }
    }

    // Detach new child.
    widget.removeFromParent();

    // Logical attach.
    getChildren().add(widget);
    if (direction == DockLayoutConstant.CENTER) {
      _center = widget;
    }

    // Physical attach.
    DockPanelLayoutData layout = new DockPanelLayoutData(direction);
    widget.setLayoutData(layout);
    setWidgetCellHorizontalAlignment(widget, _horzAlign);
    setWidgetCellVerticalAlignment(widget, _vertAlign);
    realizeTable();

    // Adopt.
    adopt(widget);
  }

  /**
   * Overloaded version for IsWidget.
   *
   * @see #add(Widget,DockLayoutConstant)
   */
  void addIsWidgetTo(IsWidget widget, DockLayoutConstant direction) {
   this.addWidgetTo(widget.asWidget(), direction);
  }

  HorizontalAlignmentConstant getHorizontalAlignment() {
    return _horzAlign;
  }

  VerticalAlignmentConstant getVerticalAlignment() {
    return _vertAlign;
  }

  /**
   * Gets the layout direction of the given child widget.
   *
   * @param w the widget to be queried
   * @return the widget's layout direction, or <code>null</code> if it is not
   *         a child of this panel
   */
  DockLayoutConstant getWidgetDirection(Widget w) {
    if (w.getParent() != this) {
      return null;
    }
    return (w.getLayoutData() as DockPanelLayoutData).direction;
  }


  bool remove(Widget w) {
    bool removed = super.remove(w);
    if (removed) {
      // Clear the center widget.
      if (w == _center) {
        _center = null;
      }
      realizeTable();
    }
    return removed;
  }


  void setCellHeight(Widget w, String height) {
    DockPanelLayoutData data = w.getLayoutData() as DockPanelLayoutData;
    data.height = height;
    if (data.td != null) {
      Dom.setStyleAttribute(data.td, "height", data.height);
    }
  }


  void setWidgetCellHorizontalAlignment(Widget w,
      HorizontalAlignmentConstant align) {
    DockPanelLayoutData data = w.getLayoutData() as DockPanelLayoutData;
    data.hAlign = align.getTextAlignString();
    if (data.td != null) {
      setCellHorizontalAlignment(data.td, align);
    }
  }


  void setWidgetCellVerticalAlignment(Widget w, VerticalAlignmentConstant align) {
    DockPanelLayoutData data = w.getLayoutData() as DockPanelLayoutData;
    data.vAlign = align.getVerticalAlignString();
    if (data.td != null) {
      setCellVerticalAlignment(data.td, align);
    }
  }


  void setCellWidth(Widget w, String width) {
    DockPanelLayoutData data = w.getLayoutData() as DockPanelLayoutData;
    data.width = width;
    if (data.td != null) {
      Dom.setStyleAttribute(data.td, "width", data.width);
    }
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

  /**
   * Sets the default vertical alignment to be used for widgets added to this
   * panel. It only applies to widgets added after this property is set.
   *
   * @see HasVerticalAlignment#setVerticalAlignment(HasVerticalAlignment.VerticalAlignmentConstant)
   */
  void setVerticalAlignment(VerticalAlignmentConstant align) {
    _vertAlign = align;
  }

  /**
   * {@link DockPanel} supports adding more than one cell in a direction, so an
   * integer will be appended to the end of the debug id. For example, the first
   * north cell is labeled "north1", the second is "north2", and the third is
   * "north3".
   *
   * This widget recreates its structure every time a {@link Widget} is added,
   * so you must call this method after adding a new {@link Widget} or all debug
   * IDs will be lost.
   *
   * <p>
   * <b>Affected Elements:</b>
   * <ul>
   * <li>-center = the center cell.</li>
   * <li>-north# = the northern cell.</li>
   * <li>-south# = the southern cell.</li>
   * <li>-east# = the eastern cell.</li>
   * <li>-west# = the western cell.</li>
   * </ul>
   * </p>
   *
   * @see UIObject#onEnsureDebugId(String)
   */

//  void onEnsureDebugId(String baseID) {
//    super.onEnsureDebugId(baseID);
//
//    Map<DockLayoutConstant, Integer> dirCount = new HashMap<DockLayoutConstant, Integer>();
//    Iterator<Widget> it = getChildren().iterator();
//    while (it.hasNext()) {
//      Widget child = it.next();
//      DockLayoutConstant dir = ((DockPanelLayoutData) child.getLayoutData()).direction;
//
//      // Get a debug id
//      Integer countObj = dirCount.get(dir);
//      int count = countObj == null ? 1 : countObj.intValue();
//      String debugID = generateDebugId(dir, count);
//      ensureDebugId(Dom.getParent(child.getElement()), baseID, debugID);
//
//      // Increment the count
//      dirCount.put(dir, count + 1);
//    }
//  }

  /**
   * (Re)creates the Dom structure of the table representing the DockPanel,
   * based on the order and layout of the children.
   */
  void realizeTable() {
    dart_html.Element bodyElem = getBody();
    while (bodyElem.children.length > 0) {
      //Dom.removeChild(bodyElem, Dom.getChild(bodyElem, 0));
      bodyElem.children[0].remove();
    }

    int rowCount = 1, colCount = 1;
    for (RemoveIterator<Widget> it = getChildren().iterator; it.moveNext();) {
      Widget child = it.current;
      DockLayoutConstant dir = (child.getLayoutData() as DockPanelLayoutData).direction;
      if ((dir == DockLayoutConstant.NORTH) || (dir == DockLayoutConstant.SOUTH)) {
        ++rowCount;
      } else if ((dir == DockLayoutConstant.EAST) || (dir == DockLayoutConstant.WEST) || (dir == DockLayoutConstant.LINE_START) || (dir == DockLayoutConstant.LINE_END)) {
        ++colCount;
      }
    }

    List<TmpRow> rows = new List<TmpRow>(rowCount);
    for (int i = 0; i < rowCount; ++i) {
      rows[i] = new TmpRow();
      rows[i].tr = new dart_html.TableRowElement();
      bodyElem.append(rows[i].tr);
    }

    int logicalLeftCol = 0, logicalRightCol = colCount - 1;
    int northRow = 0, southRow = rowCount - 1;
    dart_html.Element centerTd = null;

    for (RemoveIterator<Widget> it = getChildren().iterator; it.moveNext();) {
      Widget child = it.current;
      DockPanelLayoutData layout = child.getLayoutData() as DockPanelLayoutData;

      dart_html.TableCellElement td = new dart_html.TableCellElement();
      layout.td = td;
      //Dom.setElementProperty(layout.td, "align", layout.hAlign);
      layout.td.style.alignContent = layout.hAlign;
      //Dom.setStyleAttribute(layout.td, "verticalAlign", layout.vAlign);
      layout.td.style.verticalAlign = layout.vAlign;
      //Dom.setElementProperty(layout.td, "width", layout.width);
      layout.td.style.width = layout.width;
      //Dom.setElementProperty(layout.td, "height", layout.height);
      layout.td.style.height = layout.height;

      if (layout.direction == DockLayoutConstant.NORTH) {
        Dom.insertChild(rows[northRow].tr, td, rows[northRow].center);
        td.append(child.getElement());
        Dom.setElementPropertyInt(td, "colSpan", logicalRightCol - logicalLeftCol + 1);
        ++northRow;
      } else if (layout.direction == DockLayoutConstant.SOUTH) {
        Dom.insertChild(rows[southRow].tr, td, rows[southRow].center);
        td.append(child.getElement());
        Dom.setElementPropertyInt(td, "colSpan", logicalRightCol - logicalLeftCol + 1);
        --southRow;
      } else if (layout.direction == DockLayoutConstant.CENTER) {
        // Defer adding the center widget, so that it can be added after all
        // the others are complete.
        centerTd = td;
      } else if (shouldAddToLogicalLeftOfTable(layout.direction)) {
        TmpRow row = rows[northRow];
        Dom.insertChild(row.tr, td, row.center++);
        td.append(child.getElement());
        Dom.setElementPropertyInt(td, "rowSpan", southRow - northRow + 1);
        ++logicalLeftCol;
      } else if (shouldAddToLogicalRightOfTable(layout.direction)) {
        TmpRow row = rows[northRow];
        Dom.insertChild(row.tr, td, row.center);
        td.append(child.getElement());
        Dom.setElementPropertyInt(td, "rowSpan", southRow - northRow + 1);
        --logicalRightCol;
      }
    }

    // If there is a center widget, add it at the end (centerTd is guaranteed
    // to be initialized because it will have been set in the CENTER case in
    // the above loop).
    if (_center != null) {
      TmpRow row = rows[northRow];
      Dom.insertChild(row.tr, centerTd, row.center);
      centerTd.append(_center.getElement());
    }
  }

  bool shouldAddToLogicalLeftOfTable(DockLayoutConstant widgetDirection) {

    assert (widgetDirection == DockLayoutConstant.LINE_START || widgetDirection == DockLayoutConstant.LINE_END ||
        widgetDirection == DockLayoutConstant.EAST || widgetDirection == DockLayoutConstant.WEST);

    // In a bidi-sensitive environment, adding a widget to the logical left
    // column (think Dom order) means that it will be displayed at the start
    // of the line direction for the current layout. This is because HTML
    // tables are bidi-sensitive; the column order switches depending on
    // the line direction.
    if (widgetDirection == DockLayoutConstant.LINE_START) {
      return true;
    }

    if (LocaleInfo.getCurrentLocale().isRTL()) {
      // In an RTL layout, the logical left columns will be displayed on the right hand
      // side. When the direction for the widget is EAST, adding the widget to the logical
      // left columns will have the desired effect of displaying the widget on the 'eastern'
      // side of the screen.
      return (widgetDirection == DockLayoutConstant.EAST);
    }

    // In an LTR layout, the logical left columns are displayed on the left hand
    // side. When the direction for the widget is WEST, adding the widget to the
    // logical left columns will have the desired effect of displaying the widget on the
    // 'western' side of the screen.
    return (widgetDirection == DockLayoutConstant.WEST);
  }

  bool shouldAddToLogicalRightOfTable(DockLayoutConstant widgetDirection) {

    // See comments for shouldAddToLogicalLeftOfTable for clarification

    assert (widgetDirection == DockLayoutConstant.LINE_START || widgetDirection == DockLayoutConstant.LINE_END ||
        widgetDirection == DockLayoutConstant.EAST || widgetDirection == DockLayoutConstant.WEST);

    if (widgetDirection == DockLayoutConstant.LINE_END) {
      return true;
    }

    if (LocaleInfo.getCurrentLocale().isRTL()) {
      return (widgetDirection == DockLayoutConstant.WEST);
    }

    return (widgetDirection == DockLayoutConstant.EAST);
  }
}

/*
 * This class is package-for use with DockPanelTest.
 */
class DockPanelLayoutData {
  DockLayoutConstant direction;
  String hAlign = HasHorizontalAlignment.ALIGN_DEFAULT.getTextAlignString();
  String height = "";
  dart_html.Element td;
  String vAlign = HasVerticalAlignment.ALIGN_TOP.getVerticalAlignString();
  String width = "";

  DockPanelLayoutData(DockLayoutConstant dir) {
    direction = dir;
  }
}

class TmpRow {
  int center = 0;
  dart_html.Element tr;
}