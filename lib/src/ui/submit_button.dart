//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A standard push-button widget which will automatically submit its enclosing
 * {@link FormPanel} if any.
 *
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-SubmitButton</dt>
 * <dd>the outer element</dd>
 * </dl>
 */
class SubmitButton extends Button {

  /**
   * Creates a SubmitButton widget that wraps an existing &lt;button&gt;
   * element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  static Button wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert (Document.get().getBody().isOrHasChild(element));

    SubmitButton button = new SubmitButton.fromElement(element);
    assert ("submit" == button.getButtonElement().type);

    // Mark it attached and remember it for cleanup.
    button.onAttach();
    RootPanel.detachOnWindowClose(button);

    return button;
  }

  /**
   * Creates a button with the given HTML caption and click listener.
   *
   * @param html the HTML caption
   * @param handler the click handler
   */
  SubmitButton([String html = null, ClickHandler handler = null]) : super(html, handler) {
    clearAndSetStyleName("dwt-SubmitButton");
  }


  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be a &lt;button&gt; element with type submit.
   *
   * @param element the element to be used
   */
  SubmitButton.fromElement(dart_html.Element element) : super.fromElement(element);
}
