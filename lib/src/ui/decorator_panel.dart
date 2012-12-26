//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that displays all of its child widgets in a 'deck', where only one
 * can be visible at a time. It is used by
 * {@link com.google.gwt.user.client.ui.TabPanel}.
 * 
 * <p>
 * Once a widget has been added to a DeckPanel, its visibility, width, and
 * height attributes will be manipulated. When the widget is removed from the
 * DeckPanel, it will be visible, and its width and height attributes will be
 * cleared.
 * </p>
 */
class DecoratorPanel {
  
  /**
   * Create a new row with a specific style name. The row will contain three
   * cells (Left, Center, and Right), each prefixed with the specified style
   * name.
   * 
   * This method allows Widgets to reuse the code on a Dom level, without
   * creating a DecoratorPanel Widget.
   * 
   * @param styleName the style name
   * @return the new row {@link Element}
   */
  static dart_html.Element createTR(String styleName) {
    dart_html.Element trElem = new dart_html.TableRowElement();
    UiObject.setElementStyleName(trElem, styleName);
//    if (LocaleInfo.getCurrentLocale().isRTL()) {
//      Dom.appendChild(trElem, createTD(styleName + "Right"));
//      Dom.appendChild(trElem, createTD(styleName + "Center"));
//      Dom.appendChild(trElem, createTD(styleName + "Left"));
//    } else {
      trElem.append(createTD(styleName.concat("Left")));
      trElem.append(createTD(styleName.concat("Center")));
      trElem.append(createTD(styleName.concat("Right")));
//    }
    return trElem;
  }
  
  /**
   * Create a new table cell with a specific style name.
   * 
   * @param styleName the style name
   * @return the new cell {@link Element}
   */
  static dart_html.Element createTD(String styleName) {
    dart_html.Element tdElem = new dart_html.TableCellElement();
    dart_html.Element inner = new dart_html.DivElement();
    tdElem.append(inner);
    UiObject.setElementStyleName(tdElem, styleName);
    UiObject.setElementStyleName(inner, styleName.concat("Inner"));
    return tdElem;
  }
}
