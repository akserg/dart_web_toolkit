//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Represents a hidden field in an HTML form.
 */
class Hidden extends Widget implements HasName, TakesValue<String>, IsEditor<LeafValueEditor<String>> {

  /**
   * Creates a Hidden widget that wraps an existing &lt;input type='hidden'&gt;
   * element.
   * 
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   * 
   * @param element the element to be wrapped
   */
  factory Hidden.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    Hidden hidden = new Hidden.fromElement(element);

    // Mark it attached and remember it for cleanup.
    hidden.onAttach();
    RootPanel.detachOnWindowClose(hidden);

    return hidden;
  }

  LeafValueEditor<String> _editor;

  /**
   * Constructor for <code>Hidden</code>.
   * 
   * @param name name of the hidden field
   * @param value value of the hidden field
   */
  Hidden([String name = null, String value = null]) {
    setElement(new dart_html.HiddenInputElement());
    if (name != null) {
      this.name = name;
    }
    if (value != null) {
      setValue(value);
    }
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;input&gt; element whose type is
   * 'hidden'.
   * 
   * @param element the element to be used
   */
  Hidden.fromElement(dart_html.Element element) {
    assert ((element as dart_html.InputElement).type == "hidden");
    setElement(element);
  }

  LeafValueEditor<String> asEditor() {
    if (_editor == null) {
      _editor = new TakesValueEditor.of(this);
    }
    return _editor;
  }

  /**
   * Gets the default value of the hidden field.
   * 
   * @return the default value
   */
  String getDefaultValue() {
    return getInputElement().defaultValue;
  }

  /**
   * Sets the default value of the hidden field.
   * 
   * @param defaultValue default value to set
   */
  void setDefaultValue(String defaultValue) {
    getInputElement().defaultValue = defaultValue;
  }
  
  /**
   * Gets the id of the hidden field.
   * 
   * @return the id
   */
  String getId() {
    return getElement().id;
  }

  /**
   * Sets the id of the hidden field.
   * 
   * @param id id to set
   */
  void setId(String id) {
    getElement().id = id;
  }

  /**
   * Gets the name of the hidden field.
   * 
   * @return the name
   */
  String get name => getInputElement().name;

  /**
   * Sets the name of the hidden field.
   * 
   * @param name name of the field
   */
  void set name(String val) {
    if (val == null) {
      throw new Exception("Name cannot be null");
    } else if (val == "") {
      throw new Exception("Name cannot be an empty string.");
    }

    getInputElement().name = val;
  }

  /**
   * Gets the value of the hidden field.
   * 
   * @return the value
   */
  String getValue() {
    return getInputElement().value;
  }

  /**
   * Sets the value of the hidden field.
   * 
   * @param value value to set
   */
  void setValue(String value, [bool fireEvents = false]) {
    getInputElement().value = value;
  }

  dart_html.InputElement getInputElement() {
    return getElement() as dart_html.InputElement;
  }
}
