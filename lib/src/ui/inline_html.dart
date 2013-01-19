//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that can contain arbitrary HTML.
 *
 * This widget uses a &lt;span&gt; element, causing it to be displayed with
 * inline layout.
 *
 * <p>
 * If you only need a simple label (text, but not HTML), then the
 * {@link com.google.gwt.user.client.ui.Label} widget is more appropriate, as it
 * disallows the use of HTML, which can lead to potential security issues if not
 * used properly.
 * </p>
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
 * <li>.gwt-InlineHTML { }</li>
 * </ul>
 */
class InlineHtml extends Html {

  /**
   * Creates an InlineHTML widget that wraps an existing &lt;div&gt; or
   * &lt;span&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory InlineHtml.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    InlineHtml html = new InlineHtml.fromElement(element);

    // Mark it attached and remember it for cleanup.
    html.onAttach();
    RootPanel.detachOnWindowClose(html);

    return html;
  }

  InlineHtml.fromElement(dart_html.Element element) : super.fromElement(element) {
    clearAndSetStyleName("dwt-InlineHTML");
  }

  /**
   * Creates an empty label.
   */
  InlineHtml([String html = null]) : super.fromElement(new dart_html.SpanElement()) {
    clearAndSetStyleName("dwt-InlineHTML");
    if (html != null) {
      this.html = html;
    }
  }
}
