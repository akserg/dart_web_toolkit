//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * <p>
 * A {@link StackPanel} that wraps each item in a 2x3 grid (six box), which
 * allows users to add rounded corners.
 * </p>
 *
 * <p>
 * This widget will <em>only</em> work in quirks mode. If your application is in
 * Standards Mode, use {@link StackLayoutPanel} instead.
 * </p>
 *
 * <p>
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-DecoratedStackPanel { the panel itself }</li>
 * <li>.gwt-DecoratedStackPanel .gwt-StackPanelItem { unselected items }</li>
 * <li>.gwt-DecoratedStackPanel .gwt-StackPanelItem-selected { selected items }</li>
 * <li>.gwt-DecoratedStackPanel .gwt-StackPanelContent { the wrapper around the
 * contents of the item }</li>
 * <li>.gwt-DecoratedStackPanel .stackItemTopLeft { top left corner of the
 * item}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemTopLeftInner { the inner element of
 * the cell}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemTopCenter { top center of the item}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemTopCenterInner { the inner element of
 * the cell}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemTopRight { top right corner of the
 * item}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemTopRightInner { the inner element of
 * the cell}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemMiddleLeft { left side of the item }</li>
 * <li>.gwt-DecoratedStackPanel .stackItemMiddleLeftInner { the inner element
 * of the cell}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemMiddleCenter { center of the item,
 * where the item text resides }</li>
 * <li>.gwt-DecoratedStackPanel .stackItemMiddleCenterInner { the inner element
 * of the cell}</li>
 * <li>.gwt-DecoratedStackPanel .stackItemMiddleRight { right side of the item }</li>
 * <li>.gwt-DecoratedStackPanel .stackItemMiddleRightInner { the inner element
 * of the cell}</li>
 * </ul>
 * </p>
 *
 * @see StackLayoutPanel
 */
class DecoratedStackPanel extends StackPanel {

  static final String DEFAULT_STYLENAME = "dwt-DecoratedStackPanel";

  static final List<String> _DEFAULT_ROW_STYLENAMES = ["stackItemTop", "stackItemMiddle"];

  /**
   * Creates an empty decorated stack panel.
   */
  DecoratedStackPanel() : super() {
    clearAndSetStyleName(DEFAULT_STYLENAME);
  }

  dart_html.Element createHeaderElem() {
    // Create the table
    dart_html.TableElement table = new dart_html.TableElement();
    dart_html.Element tbody = table.createTBody();
    table.append(tbody);
    Dom.setStyleAttribute(table, "width", "100%");
    Dom.setElementPropertyInt(table, "cellSpacing", 0);
    Dom.setElementPropertyInt(table, "cellPadding", 0);

    // Add the decorated rows
    for (int i = 0; i < _DEFAULT_ROW_STYLENAMES.length; i++) {
      tbody.append(DecoratorPanel.createTR(_DEFAULT_ROW_STYLENAMES[i]));
    }

    // Return the table
    return table;
  }

  dart_html.Element getHeaderTextElem(dart_html.Element headerElem) {
    dart_html.Element tbody = headerElem.$dom_firstElementChild;
    dart_html.Element tr = tbody.children[1];
    dart_html.Element td = tr.children[1];
    return td.$dom_firstElementChild;
  }
}