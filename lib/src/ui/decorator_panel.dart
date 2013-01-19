//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * <p>
 * A {@link SimplePanel} that wraps its contents in stylized boxes, which can be
 * used to add rounded corners to a {@link Widget}.
 * </p>
 * <p>
 * This widget will <em>only</em> work in quirks mode in most cases.
 * Specifically, setting the height or width of the DecoratorPanel will result
 * in rendering issues.
 * </p>
 * <p>
 * Wrapping a {@link Widget} in a "9-box" allows users to specify images in each
 * of the corners and along the four borders. This method allows the content
 * within the {@link DecoratorPanel} to resize without disrupting the look of
 * the border. In addition, rounded corners can generally be combined into a
 * single image file, which reduces the number of downloaded files at startup.
 * This class also simplifies the process of using AlphaImageLoaders to support
 * 8-bit transparencies (anti-aliasing and shadows) in ie6, which does not
 * support them normally.
 * </p>
 * <h3>Setting the Size:</h3>
 * <p>
 * If you set the width or height of the {@link DecoratorPanel}, you need to
 * set the height and width of the middleCenter cell to 100% so that the
 * middleCenter cell takes up all of the available space. If you do not set the
 * width and height of the {@link DecoratorPanel}, it will wrap its contents
 * tightly.
 * </p>
 *
 * <pre>
 * .gwt-DecoratorPanel .middleCenter {
 *   height: 100%;
 *   width: 100%;
 * }
 * </pre>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-DecoratorPanel { the panel }</li>
 * <li>.gwt-DecoratorPanel .top { the top row }</li>
 * <li>.gwt-DecoratorPanel .topLeft { the top left cell }</li>
 * <li>.gwt-DecoratorPanel .topLeftInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .topCenter { the top center cell }</li>
 * <li>.gwt-DecoratorPanel .topCenterInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .topRight { the top right cell }</li>
 * <li>.gwt-DecoratorPanel .topRightInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .middle { the middle row }</li>
 * <li>.gwt-DecoratorPanel .middleLeft { the middle left cell }</li>
 * <li>.gwt-DecoratorPanel .middleLeftInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .middleCenter { the middle center cell }</li>
 * <li>.gwt-DecoratorPanel .middleCenterInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .middleRight { the middle right cell }</li>
 * <li>.gwt-DecoratorPanel .middleRightInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .bottom { the bottom row }</li>
 * <li>.gwt-DecoratorPanel .bottomLeft { the bottom left cell }</li>
 * <li>.gwt-DecoratorPanel .bottomLeftInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .bottomCenter { the bottom center cell }</li>
 * <li>.gwt-DecoratorPanel .bottomCenterInner { the inner element of the cell }</li>
 * <li>.gwt-DecoratorPanel .bottomRight { the bottom right cell }</li>
 * <li>.gwt-DecoratorPanel .bottomRightInner { the inner element of the cell }</li>
 * </ul>
 */
class DecoratorPanel extends SimplePanel {
  /**
   * The default style name.
   */
  static final String _DEFAULT_STYLENAME = "gwt-DecoratorPanel";

  /**
   * The default styles applied to each row.
   */
  static const List<String> _DEFAULT_ROW_STYLENAMES = const ["top", "middle", "bottom"];

  /**
   * Create a new row with a specific style name. The row will contain three
   * cells (Left, Center, and Right), each prefixed with the specified style
   * name.
   *
   * This method allows Widgets to reuse the code on a Dom level, without
   * creating a DecoratorPanel Widget.
   *
   * @param styleName the style name
   * @return the new row {@link dart_html.Element}
   */
  static dart_html.Element createTR(String styleName) {
    dart_html.Element trElem = new dart_html.TableRowElement();
    UiObject.setElementStyleName(trElem, styleName);
    if (LocaleInfo.getCurrentLocale().isRTL()) {
      trElem.append(createTD(styleName.concat("Right")));
      trElem.append(createTD(styleName.concat("Center")));
      trElem.append(createTD(styleName.concat("Left")));
    } else {
      trElem.append(createTD(styleName.concat("Left")));
      trElem.append(createTD(styleName.concat("Center")));
      trElem.append(createTD(styleName.concat("Right")));
    }
    return trElem;
  }

  /**
   * Create a new table cell with a specific style name.
   *
   * @param styleName the style name
   * @return the new cell {@link dart_html.Element}
   */
  static dart_html.Element createTD(String styleName) {
    dart_html.Element tdElem =  new dart_html.TableCellElement();
    dart_html.Element inner = new dart_html.DivElement();
    tdElem.append(inner);
    UiObject.setElementStyleName(tdElem, styleName);
    UiObject.setElementStyleName(inner, styleName.concat("Inner"));
    return tdElem;
  }

  /**
   * The container element at the center of the panel.
   */
  dart_html.Element _containerElem;

  /**
   * The table body element.
   */
  dart_html.Element _tbody;

  /**
   * Creates a new panel using the specified style names to apply to each row.
   * Each row will contain three cells (Left, Center, and Right). The Center
   * cell in the containerIndex row will contain the {@link Widget}.
   *
   * @param rowStyles an array of style names to apply to each row
   * @param containerIndex the index of the container row
   */
  DecoratorPanel([List<String> rowStyles = _DEFAULT_ROW_STYLENAMES, int containerIndex = 1]) : super.fromElement(new dart_html.TableElement()) {

    // Add a tbody
    dart_html.TableElement table = getElement();
    _tbody = table.createTBody();
    table.append(_tbody);
    Dom.setElementPropertyInt(table, "cellSpacing", 0);
    Dom.setElementPropertyInt(table, "cellPadding", 0);

    // Add each row
    for (int i = 0; i < rowStyles.length; i++) {
      dart_html.Element row = createTR(rowStyles[i]);
      _tbody.append(row);
      if (i == containerIndex) {
        _containerElem = row.children[1].$dom_firstElementChild; // Dom.getFirstChild(Dom.getChild(row, 1));
      }
    }

    // Set the overall style name
    clearAndSetStyleName(_DEFAULT_STYLENAME);
  }

  /**
   * Get a specific dart_html.Element from the panel.
   *
   * @param row the row index
   * @param cell the cell index
   * @return the dart_html.Element at the given row and cell
   */
  dart_html.Element getCellElement(int row, int cell) {
    dart_html.Element tr = _tbody.children[row]; // Dom.getChild(tbody, row);
    dart_html.Element td = tr.children[cell]; // Dom.getChild(tr, cell);
    return td.$dom_firstElementChild; // Dom.getFirstChild(td);
  }

  dart_html.Element getContainerElement() {
    return _containerElem;
  }
}
