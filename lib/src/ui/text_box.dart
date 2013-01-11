//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A standard single-line text box.
 *
 * <p>
 * <img class='gallery' src='doc-files/TextBox.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-TextBox { primary style }</li>
 * <li>.gwt-TextBox-readonly { dependent style set when the text box is
 * read-only }</li>
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
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.TextBoxExample}
 * </p>
 */
class TextBox extends TextBoxBase {

  /**
   * Creates a TextBox widget that wraps an existing &lt;input type='text'&gt;
   * element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory TextBox.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    TextBox textBox = new TextBox.fromElement(element);

    // Mark it attached and remember it for cleanup.
    textBox.onAttach();
    RootPanel.detachOnWindowClose(textBox);

    return textBox;
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;input&gt; element whose type is
   * 'text'.
   *
   * @param element the element to be used
   */
  TextBox.fromElement(dart_html.Element element) : super(element) {
    clearAndSetStyleName("dwt-TextBox");
  }

  /**
   * Creates an empty text box.
   */
  TextBox() : this.fromElement(new dart_html.InputElement());

  /**
   * Gets the maximum allowable length of the text box.
   *
   * @return the maximum length, in characters
   */
  int getMaxLength() {
    return _getInputElement().maxLength;
  }

  /**
   * Gets the number of visible characters in the text box.
   *
   * @return the number of visible characters
   */
  int getVisibleLength() {
    return _getInputElement().size;
  }

  /**
   * Sets the maximum allowable length of the text box.
   *
   * @param length the maximum length, in characters
   */
  void setMaxLength(int length) {
    _getInputElement().maxLength = length;
  }

  /**
   * Sets the number of visible characters in the text box.
   *
   * @param length the number of visible characters
   */
  void setVisibleLength(int length) {
    _getInputElement().size = length;
  }

  dart_html.InputElement _getInputElement() {
    return getElement() as dart_html.InputElement;
  }
}
