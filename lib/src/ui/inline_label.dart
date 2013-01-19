//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that contains arbitrary text, <i>not</i> interpreted as HTML.
 *
 * This widget uses a &lt;span&gt; element, causing it to be displayed with
 * inline layout.
 *
 * <p>
 * <h3>Built-in Bidi Text Support</h3>
 * This widget is capable of automatically adjusting its direction according to
 * its content. This feature is controlled by {@link #setDirectionEstimator} or
 * passing a DirectionEstimator parameter to the constructor, and is off by
 * default.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-InlineLabel { }</li>
 * </ul>
 */
class InlineLabel extends Label {

  /**
   * Creates a InlineLabel widget that wraps an existing &lt;div&gt; or
   * &lt;span&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory InlineLabel.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    InlineLabel label = new InlineLabel.fromElement(element);

    // Mark it attached and remember it for cleanup.
    label.onAttach();
    RootPanel.detachOnWindowClose(label);

    return label;
  }

  InlineLabel.fromElement(dart_html.Element element) : super.fromElement(element) {
    clearAndSetStyleName("dwt-InlineLabel");
  }

  /**
   * Creates an empty label.
   */
  InlineLabel([String text = null]) : super.fromElement(new dart_html.SpanElement()) {
    clearAndSetStyleName("dwt-InlineLabel");
    if (text != null) {
      this.text = text;
    }
  }
}
