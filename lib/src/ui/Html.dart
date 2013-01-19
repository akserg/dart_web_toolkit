//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that can contain arbitrary HTML.
 *
 * This widget uses a &lt;div&gt; element, causing it to be displayed with block
 * layout.
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
 * <li>.gwt-HTML { }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.HTMLExample}
 * </p>
 */
class Html extends Label implements HasDirectionalHtml, HasDirectionalSafeHtml {

  /**
   * Creates an HTML widget that wraps an existing &lt;div&gt; or &lt;span&gt;
   * element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory Html.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    Html html = new Html.fromElement(element);

    // Mark it attached and remember it for cleanup.
    html.onAttach();
    RootPanel.detachOnWindowClose(html);

    return html;
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be either a &lt;div&gt; or &lt;span&gt; element.
   *
   * @param element the element to be used
   */
  Html.fromElement(dart_html.Element element) : super.fromElement(element) {
    clearAndSetStyleName("dwt-HTML");
  }

  /**
   * Creates an HTML widget with the specified HTML contents.
   *
   * @param html the new widget's HTML contents
   */
  Html([String html = null, bool wordWrap = null]) : super(null) {
    clearAndSetStyleName("dwt-HTML");
    if (html != null) {
      this.html = html;
    }
    if (wordWrap != null) {
      this.wordWrap = wordWrap;
    }
  }

  String get html => directionalTextHelper.getTextOrHtml(true);

  /**
   * Sets the label's content to the given HTML.
   * See {@link #setText(String)} for details on potential effects on direction
   * and alignment.
   *
   * @param html the new widget's HTML content
   */
  void set html(String val) {
    directionalTextHelper.setTextOrHtml(val, true);
    updateHorizontalAlignment();
  }

  /**
   * Sets the label's content to the given HTML, applying the given direction.
   * See
   * {@link #setText(String, com.google.gwt.i18n.client.HasDirection.Direction) setText(String, Direction)}
   * for details on potential effects on alignment.
   *
   * @param html the new widget's HTML content
   * @param dir the content's direction. Note: {@code Direction.DEFAULT} means
   *          direction should be inherited from the widget's parent element.
   */
  void setHtml(String val, Direction dir) {
    directionalTextHelper.setTextOrHtml(val, true, dir);
    updateHorizontalAlignment();
  }

  String getTextOrHtml(bool isHtml) {
    return directionalTextHelper.getTextOrHtml(isHtml);
  }
}
