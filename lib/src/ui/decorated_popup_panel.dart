//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * <p>
 * A {@link PopupPanel} that wraps its content in a 3x3 grid, which allows users
 * to add rounded corners.
 * </p>
 * 
 * <h3>Setting the Size:</h3>
 * <p>
 * If you set the width or height of the {@link DecoratedPopupPanel}, you need
 * to set the height and width of the middleCenter cell to 100% so that the
 * middleCenter cell takes up all of the available space. If you do not set the
 * width and height of the {@link DecoratedPopupPanel}, it will wrap its
 * contents tightly.
 * </p>
 * 
 * <pre>
 * .dwt-DecoratedPopupPanel .popupMiddleCenter {
 *   height: 100%;
 *   width: 100%;
 * }
 * </pre>
 * 
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.dwt-DecoratedPopupPanel { the outside of the popup }</li>
 * <li>.dwt-DecoratedPopupPanel .popupContent { the wrapper around the content }</li>
 * <li>.dwt-DecoratedPopupPanel .popupTopLeft { the top left cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupTopLeftInner { the inner element of the
 * cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupTopCenter { the top center cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupTopCenterInner { the inner element of the
 * cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupTopRight { the top right cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupTopRightInner { the inner element of the
 * cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupMiddleLeft { the middle left cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupMiddleLeftInner { the inner element of
 * the cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupMiddleCenter { the middle center cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupMiddleCenterInner { the inner element of
 * the cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupMiddleRight { the middle right cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupMiddleRightInner { the inner element of
 * the cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupBottomLeft { the bottom left cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupBottomLeftInner { the inner element of
 * the cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupBottomCenter { the bottom center cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupBottomCenterInner { the inner element of
 * the cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupBottomRight { the bottom right cell }</li>
 * <li>.dwt-DecoratedPopupPanel .popupBottomRightInner { the inner element of
 * the cell }</li>
 * </ul>
 */
class DecoratedPopupPanel extends PopupPanel {
  
  static final String _DEFAULT_STYLENAME = "dwt-DecoratedPopupPanel";
  
  /**
   * The panel used to nine box the contents.
   */
  DecoratorPanel _decPanel;
  
  /**
   * Creates an empty decorated popup panel using the specified style names.
   * 
   * @param autoHide <code>true</code> if the popup should be automatically
   *          hidden when the user clicks outside of it
   * @param modal <code>true</code> if keyboard or mouse events that do not
   *          target the PopupPanel or its children should be ignored
   * @param prefix the prefix applied to child style names
   */
  DecoratedPopupPanel([bool autoHide = false, bool modal = false, String prefix = "popup"]) : super(autoHide, modal) {
    List<String> rowStyles = [prefix.concat("Top"), prefix.concat("Middle"), prefix.concat("Bottom")];
    _decPanel = new DecoratorPanel(rowStyles, 1);
    _decPanel.clearAndSetStyleName("");
    setStylePrimaryName(_DEFAULT_STYLENAME);
    super.setWidget(_decPanel);
    UiObject.manageElementStyleName(getContainerElement(), "popupContent", false);
    UiObject.manageElementStyleName(_decPanel.getContainerElement(), prefix.concat("Content"), true);
  }
  
  
  void clear() {
    _decPanel.clear();
  }

  
  Widget getWidget() {
    return _decPanel.getWidget();
  }

  
  Iterator<Widget> iterator() {
    return _decPanel.iterator();
  }

  
  bool remove(Widget w) {
    return _decPanel.remove(w);
  }

  
  void setWidget(Widget w) {
    _decPanel.setWidget(w);
    maybeUpdateSize();
  }

  
  void doAttachChildren() {
    // See comment in doDetachChildren for an explanation of this call
    _decPanel.onAttach();
  }

  
  void doDetachChildren() {
    // We need to detach the decPanel because it is not part of the iterator of
    // Widgets that this class returns (see the iterator() method override).
    // Detaching the decPanel detaches both itself and its children. We do not
    // call super.onDetachChildren() because that would detach the decPanel's
    // children (redundantly) without detaching the decPanel itself.
    // This is similar to a {@link ComplexPanel}, but we do not want to expose
    // the decPanel widget, as its just an internal implementation.
    _decPanel.onDetach();
  }

  /**
   * Get a specific Element from the panel.
   * 
   * @param row the row index
   * @param cell the cell index
   * @return the Element at the given row and cell
   */
  dart_html.Element getCellElement(int row, int cell) {
    return _decPanel.getCellElement(row, cell);
  }
}
