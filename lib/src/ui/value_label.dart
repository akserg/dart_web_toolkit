//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A label displaying its value through a renderer.
 * 
 * @param <T> the value type.
 */
class ValueLabel<T> extends LabelBase<T> implements TakesValue<T>, IsEditor<LeafValueEditor<T>> {
  
  /**
   * Creates a ValueLabel widget that wraps an existing &lt;span&gt; element.
   * <p>
   * The ValueLabel's value will be <code>null</code>, whether the element being
   * wrapped has content or not. Use {@link #wrap(Element, Renderer, Parser)} to
   * parse the initial element's content to initialize the ValueLabel's value.
   * <p>
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   * 
   * @param element the element to be wrapped
   * @param renderer the renderer used to render values into the element
   */
  factory ValueLabel.wrap(dart_html.Element element, Renderer renderer, [Parser parser = null]) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    ValueLabel label = new ValueLabel.fromElement(element, renderer);
    
    if (parser != null) {
      label.setValue(parser.parse(element.text));
    }

    // Mark it attached and remember it for cleanup.
    label.onAttach();
    RootPanel.detachOnWindowClose(label);

    return label;
  }
  
  final Renderer _renderer;
  T _value;
  LeafValueEditor<T> _editor;
  
  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be either a &lt;span&gt; or a &lt;div&gt;
   * element.
   * 
   * @param element the element to be used
   */
  ValueLabel.fromElement(dart_html.Element element, this._renderer) : super.fromElement(element);
  
  /**
   * Creates an empty value label.
   * 
   * @param renderer
   */
  ValueLabel(this._renderer) : super(true);
  
  LeafValueEditor<T> asEditor() {
    if (_editor == null) {
      _editor = new TakesValueEditor(this);
    }
    return _editor;
  }
  
  /**
   * Returns the current value.
   * 
   * @return the value as an object of type V
   * @see #setValue
   */
  T getValue() {
    return _value;
  }
  
  /**
   * Sets the value.
   * Fires [ValueChangeEvent] when
   * fireEvents is true and the new value does not equal the existing value.
   *
   * @param value a value object of type V
   * @see #getValue()
   * @param fireEvents fire events if true and value is new
   */
  void setValue(T val, [bool fireEvents = false]) {
    this._value = val;
    directionalTextHelper.setTextOrHtml(_renderer.render(val), false);
    updateHorizontalAlignment();
  }
}
