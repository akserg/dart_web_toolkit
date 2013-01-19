//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A text box able to parse its displayed value.
 *
 * @param <T> the value type
 */
class ValueBox<T> extends ValueBoxBase<T> {

  /**
   * Creates a ValueBox widget that wraps an existing &lt;input type='text'&gt;
   * element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory ValueBox.wrap(dart_html.InputElement element, Renderer<T> renderer, Parser<T> parser) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    ValueBox valueBox = new ValueBox.fromElement(element, renderer, parser);

    // Mark it attached and remember it for cleanup.
    valueBox.onAttach();
    RootPanel.detachOnWindowClose(valueBox);

    return valueBox;
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;input&gt; element whose type is
   * 'text'.
   *
   * @param element the element to be used
   */
  ValueBox.fromElement(dart_html.InputElement element, Renderer<T> renderer, Parser<T> parser) : super(element, renderer, parser) {
    // BiDi input is not expected - disable direction estimation.
    //setDirectionEstimator(false);
    if (LocaleInfo.getCurrentLocale().isRTL()) {
      direction = Direction.LTR.value;
    }
    //assert InputElement.as(element).getType().equalsIgnoreCase("text");

  }

  /**
   * Gets the maximum allowable length.
   *
   * @return the maximum length, in characters
   */
  int getMaxLength() {
    return _getInputElement().maxLength;
  }

  /**
   * Gets the number of visible characters.
   *
   * @return the number of visible characters
   */
  int getVisibleLength() {
    return _getInputElement().size;
  }

  /**
   * Sets the maximum allowable length.
   *
   * @param length the maximum length, in characters
   */
  void setMaxLength(int length) {
    _getInputElement().maxLength = length;
  }

  /**
   * Sets the number of visible characters.
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
