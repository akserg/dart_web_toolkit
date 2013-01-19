//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A text box that allows multiple lines of text to be entered.
 *
 * <p>
 * <img class='gallery' src='doc-files/TextArea.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-TextArea { primary style }</li>
 * <li>.gwt-TextArea-readonly { dependent style set when the text area is read-only }</li>
 * </ul>
 *
 * <p>
 * <h3>Built-in Bidi Text Support</h3>
 * This widget is capable of automatically adjusting its direction according to
 * the input text. This feature is controlled by {@link #setDirectionEstimator},
 * and is available by default when at least one of the application's locales is
 * right-to-left.
 * </p>
 *
 * <p>
 * <h3>Example</h3> {@example com.google.gwt.examples.TextBoxExample}
 * </p>
 */
class TextArea extends TextBoxBase {

  /**
   * Creates a TextArea widget that wraps an existing &lt;textarea&gt;
   * element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory TextArea.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    TextArea textArea = new TextArea.fromElement(element);

    // Mark it attached and remember it for cleanup.
    textArea.onAttach();
    RootPanel.detachOnWindowClose(textArea);

    return textArea;
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;textarea&gt; element whose type is
   * 'text'.
   *
   * @param element the element to be used
   */
  TextArea.fromElement(dart_html.Element element) : super(element) {
    clearAndSetStyleName("dwt-TextArea");
  }

  /**
   * Creates an empty text area.
   */
  TextArea() : this.fromElement(new dart_html.TextAreaElement());

  /**
   * Gets the requested width of the text box (this is not an exact value, as
   * not all characters are created equal).
   *
   * @return the requested width, in characters
   */
  int getCharacterWidth() {
    return _getTextAreaElement().cols;
  }

  int getCursorPos() {
    return getImpl().getTextAreaCursorPos(getElement());
  }

  int getSelectionLength() {
    return getImpl().getTextAreaSelectionLength(getElement());
  }

  /**
   * Gets the number of text lines that are visible.
   *
   * @return the number of visible lines
   */
  int getVisibleLines() {
    return _getTextAreaElement().rows;
  }

  /**
   * Sets the requested width of the text box (this is not an exact value, as
   * not all characters are created equal).
   *
   * @param width the requested width, in characters
   */
  void setCharacterWidth(int width) {
    _getTextAreaElement().cols = width;
  }

  /**
   * Sets the number of text lines that are visible.
   *
   * @param lines the number of visible lines
   */
  void setVisibleLines(int lines) {
    _getTextAreaElement().rows = lines;
  }

  dart_html.TextAreaElement _getTextAreaElement() {
    return getElement() as dart_html.TextAreaElement;
  }
}
