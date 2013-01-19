//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple checkbox widget, with no label.
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-SimpleCheckBox { }</li>
 * <li>.gwt-SimpleCheckBox-disabled { Applied when checkbox is disabled }</li>
 * </ul>
 */
class SimpleCheckBox extends FocusWidget implements HasName, TakesValue<bool>, IsEditor<LeafValueEditor<bool>> {

  /**
   * Creates a SimpleCheckBox widget that wraps an existing &lt;input
   * type='checkbox'&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory SimpleCheckBox.wrap(dart_html.CheckboxInputElement element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    SimpleCheckBox checkBox = new SimpleCheckBox(element);

    // Mark it attached and remember it for cleanup.
    checkBox.onAttach();
    RootPanel.detachOnWindowClose(checkBox);

    return checkBox;
  }

  LeafValueEditor<bool> editor;

  /**
   * Creates a new simple checkbox.
   */
  SimpleCheckBox([dart_html.InputElement element = null]) : super(element == null ? new dart_html.InputElement(type: 'checkbox') : element) {
    clearAndSetStyleName("dwt-SimpleCheckBox");
  }

  LeafValueEditor<bool> asEditor() {
    if (editor == null) {
      editor = new TakesValueEditor(this);
    }
    return editor;
  }

  /**
   * Returns the value property of the input element that backs this widget.
   * This is the value that will be associated with the check box name and
   * submitted to the server if a {@link FormPanel} that holds it is submitted
   * and the box is checked.
   * <p>
   * Don't confuse this with {@link #getValue}, which returns true or false if
   * the widget is checked.
   */
  String getFormValue() {
    return _getInputElement().value;
  }

  /**
   * Set the value property on the input element that backs this widget. This is
   * the value that will be associated with the check box's name and submitted
   * to the server if a {@link FormPanel} that holds it is submitted and the box
   * is checked.
   * <p>
   * Don't confuse this with {@link #setValue}, which actually checks and
   * unchecks the box.
   *
   * @param value
   */
  void setFormValue(String value) {
    _getInputElement().value = value;
  }

  //**************************
  // Implementation of HasName
  //**************************

  /**
   * Gets the widget's name.
   *
   * @return the widget's name
   */
  String get name => _getInputElement().name;

  /**
   * Sets the widget's name.
   *
   * @param name the widget's new name
   */
  void set name(String name) {
    _getInputElement().name = name;
  }

  //*****************************
  // Implementation of TakesValue
  //*****************************

  /**
   * Determines whether this check box is currently checked.
   * <p>
   * Note that this <em>does not</em> return the value property of the checkbox
   * input element wrapped by this widget. For access to that property, see
   * {@link #getFormValue()}
   *
   * @return <code>true</code> if the check box is checked, false otherwise.
   *         Will not return null
   */
  bool getValue() {
    if (isAttached()) {
      return _getInputElement().checked;
    } else {
      return _getInputElement().defaultChecked;
    }
  }

  /**
   * Checks or unchecks the check box.
   * <p>
   * Note that this <em>does not</em> set the value property of the checkbox
   * input element wrapped by this widget. For access to that property, see
   * {@link #setFormValue(String)}
   *
   * @param value true to check, false to uncheck; null value implies false
   */
  void setValue(bool value, [bool fireEvents = false]) {
    if (value == null) {
      value = false;
    }

    _getInputElement().checked = value;
    _getInputElement().defaultChecked = value;
  }

  void set enabled(bool val) {
    super.enabled = val;
    if (val) {
      removeStyleDependentName("disabled");
    } else {
      addStyleDependentName("disabled");
    }
  }

  /**
   * This method is called when a widget is detached from the browser's
   * document. Overridden because of IE bug that throws away checked state.
   */
  void onUnload() {
    setValue(getValue());
  }

  dart_html.InputElement _getInputElement() {
    return getElement() as dart_html.InputElement;
  }
}
