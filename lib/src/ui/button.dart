//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A standard push-button widget.
 *
 * <p>
 * <img class='gallery' src='doc-files/Button.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-Button</dt>
 * <dd>the outer element</dd>
 * </dl>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.ButtonExample}
 * </p>
 */
class Button extends ButtonBase {

  /**
   * Creates a Button widget that wraps an existing &lt;button&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory Button.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert (Document.get().getBody().isOrHasChild(element));

    Button button = new Button.fromElement(element);

    // Mark it attached and remember it for cleanup.
    button.onAttach();
    RootPanel.detachOnWindowClose(button);

    return button;
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be a &lt;button&gt; element.
   *
   * @param element the element to be used
   */
  Button.fromElement(dart_html.Element element) : super(element);

  /**
   * Creates a button with the given HTML caption and click listener.
   *
   * @param html the HTML caption
   * @param handler the click handler
   */
  Button([String html = null, ClickHandler handler = null]) : super(new dart_html.ButtonElement()) {
    clearAndSetStyleName("dwt-Button");
    if (html != null) {
      this.html = html;
    }
    if (handler != null) {
      addClickHandler(handler);
    }
  }

  /**
   * Get the underlying button element.
   *
   * @return the {@link ButtonElement}
   */
  dart_html.ButtonElement getButtonElement() {
    return getElement() as dart_html.ButtonElement;
  }
}
