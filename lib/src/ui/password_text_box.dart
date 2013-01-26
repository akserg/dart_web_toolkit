//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A text box that visually masks its input to prevent eavesdropping.
 *
 * <p>
 * <img class='gallery' src='doc-files/PasswordTextBox.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-PasswordTextBox { primary style }</li>
 * <li>.gwt-PasswordTextBox-readonly { dependent style set when the password
 * text box is read-only }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.TextBoxExample}
 * </p>
 */
class PasswordTextBox extends TextBox {

  /**
   * Creates a PasswordTextBox widget that wraps an existing &lt;input
   * type='password'&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory PasswordTextBox.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    PasswordTextBox textBox = new PasswordTextBox.fromElement(element);

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
  PasswordTextBox.fromElement(dart_html.Element element) : super.fromElement(element) {
    assert((element as dart_html.InputElement).type == "password");
    clearAndSetStyleName("dwt-PasswordTextBox");
  }

  /**
   * Creates an empty text box.
   */
  PasswordTextBox() : this.fromElement(new dart_html.PasswordInputElement());
}
