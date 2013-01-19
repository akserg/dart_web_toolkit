//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract base class for most text entry widgets.
 *
 * <p>
 * The names of the static members of {@link TextBoxBase}, as well as simple
 * alignment names (<code>left</code>, <code>center</code>, <code>right</code>,
 * <code>justify</code>), can be used as values for a <code>textAlignment</code>
 * attribute.
 * <p>
 * For example,
 *
 * <pre>
 * &lt;g:TextBox textAlignment='ALIGN_RIGHT'/&gt;
 * &lt;g:TextBox textAlignment='right'/&gt;
 * </pre>
 */
class TextBoxBase extends ValueBoxBase<String> {
  /**
   * Creates a text box that wraps the given browser element handle. This is
   * only used by subclasses.
   *
   * @param elem the browser element to wrap
   */
  TextBoxBase(dart_html.Element elem) : super(elem, new PassthroughRenderer.instance(), new PassthroughParser.instance());

  /**
   * Overridden to return "" from an empty text box.
   */
  String getValue() {
    String raw = super.getValue();
    return raw == null ? "" : raw;
  }
}
