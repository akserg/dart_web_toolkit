//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A standard check box widget.
 *
 * This class also serves as a base class for
 * {@link com.google.gwt.user.client.ui.RadioButton}.
 *
 * <p>
 * <img class='gallery' src='doc-files/CheckBox.png'/>
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
 * <dl>
 * <dt>.gwt-CheckBox</dt>
 * <dd>the outer element</dd>
 * <dt>.gwt-CheckBox-disabled</dt>
 * <dd>applied when Checkbox is disabled</dd>
 * </dl>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.CheckBoxExample}
 * </p>
 */
class CheckBox extends ButtonBase implements HasName, HasValue<bool>,
  HasWordWrap, HasDirectionalSafeHtml, HasDirectionEstimator,
  IsEditor<LeafValueEditor<bool>> {

  static DirectionEstimator DEFAULT_DIRECTION_ESTIMATOR = DirectionalTextHelper.DEFAULT_DIRECTION_ESTIMATOR;

  DirectionalTextHelper directionalTextHelper;

  dart_html.InputElement inputElem;
  dart_html.LabelElement labelElem;

  LeafValueEditor<bool> editor;

  bool _valueChangeHandlerInitialized = false;

  /**
   * Creates a check box with label.
   */
  CheckBox([String label = null, bool asHtml = false]) : super(new dart_html.SpanElement()) {
    dart_html.InputElement element = new dart_html.InputElement();
    element.type = "checkbox";
    _initWidget(element);
    //
    clearAndSetStyleName("dwt-CheckBox");
    //
    if (label != null) {
      if (asHtml) {
        html = label;
      } else {
        text = label;
      }
    }
  }

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be a &lt;checkbox&gt; element.
   *
   * @param element the element to be used
   */
  CheckBox.fromElement(dart_html.InputElement element) : super(new dart_html.SpanElement()) {
    assert(element != null);
    _initWidget(element);
  }

  void _initWidget(dart_html.InputElement element) {
    inputElem = element;
    labelElem = new dart_html.LabelElement();

    getElement().append(inputElem);
    getElement().append(labelElem);

    String uid = Dom.createUniqueId();
    inputElem.id = uid;
    labelElem.htmlFor = uid;

    directionalTextHelper = new DirectionalTextHelper(labelElem, true);

    // Accessibility: setting tab index to be 0 by default, ensuring element
    // appears in tab sequence. FocusWidget's setElement method already
    // calls setTabIndex, which is overridden below. However, at the time
    // that this call is made, inputElem has not been created. So, we have
    // to call setTabIndex again, once inputElem has been created.
    tabIndex = 0;
  }

  //**************************
  // Implementation of HasName
  //**************************
  /**
   * Sets the widget's name.
   *
   * @param name the widget's new name
   */
  void set name(String val) {
    inputElem.name = val;
  }

  /**
   * Gets the widget's name.
   *
   * @return the widget's name
   */
  String get name => inputElem.name;

  //**************************
  // Implementation of HasHtml
  //**************************

  /**
   * Gets this object's contents as HTML.
   *
   * @return the object's HTML
   */
  String get html {
    return directionalTextHelper.getTextOrHtml(true);
  }

  /**
   * Sets this object's contents via HTML. Use care when setting an object's
   * HTML; it is an easy way to expose script-based security problems. Consider
   * using {@link #setText(String)} whenever possible.
   *
   * @param html the object's new HTML
   */
  void set html(String val) {
    directionalTextHelper.setTextOrHtml(val, true);
  }

  //****************************************
  // Impementation of HasValueChangeHandlers
  //****************************************

  HandlerRegistration addValueChangeHandler(ValueChangeHandler<bool> handler) {
    // Is this the first value change handler? If so, time to add handlers
    if (!_valueChangeHandlerInitialized) {
      ensureDomEventHandlers();
      _valueChangeHandlerInitialized = true;
    }
    return addHandler(handler, ValueChangeEvent.TYPE);
  }

  //****************************
  // Impementation of HasEnabled
  //****************************
  /**
   * Gets whether this widget is enabled.
   *
   * @return <code>true</code> if the widget is enabled
   */
  bool get enabled => !inputElem.disabled; // !Dom.getElementPropertyBoolean(inputElem, "disabled");

  /**
   * Sets whether this widget is enabled.
   *
   * @param enabled <code>true</code> to enable the widget, <code>false</code>
   *          to disable it
   */
  void set enabled(bool val) {
    //Dom.setElementPropertyBoolean(inputElem, "disabled", !val);
    inputElem.disabled = !val;
    if (val) {
      removeStyleDependentName("disabled");
    } else {
      addStyleDependentName("disabled");
    }
  }

  //******************************
  // Implementation of HasWordWrap
  //******************************

  /**
   * Gets whether word-wrapping is enabled.
   *
   * @return <code>true</code> if word-wrapping is enabled.
   */
  bool get wordWrap => WhiteSpace.NOWRAP.value != getElement().style.whiteSpace;

  /**
   * Sets whether word-wrapping is enabled.
   *
   * @param wrap <code>true</code> to enable word-wrapping.
   */
  void set wordWrap(bool wrap) {
    getElement().style.whiteSpace = wrap ? WhiteSpace.NORMAL.value : WhiteSpace.NOWRAP.value;
  }

  //***************************
  // Implementation of HasFocus
  //***************************
  /**
   * Gets the widget's position in the tab index.
   *
   * @return the widget's tab index
   */
  int get tabIndex => inputElem.tabIndex;

  /**
   * Sets the widget's position in the tab index. If more than one widget has
   * the same tab index, each such widget will receive focus in an arbitrary
   * order. Setting the tab index to <code>-1</code> will cause this widget to
   * be removed from the tab order.
   *
   * @param index the widget's tab index
   */
  void set tabIndex(int index) {
    // Need to guard against call to setTabIndex before inputElem is
    // initialized. This happens because FocusWidget's (a superclass of
    // CheckBox) setElement method calls setTabIndex before inputElem is
    // initialized. See CheckBox's protected constructor for more information.
    if (inputElem != null) {
      inputElem.tabIndex = index;
    }
  }

  /**
   * Explicitly focus/unfocus this widget. Only one widget can have focus at a
   * time, and the widget that does will receive all keyboard events.
   *
   * @param focused whether this widget should take focus or release it
   */
  void set focus(bool focused) {
    if (focused) {
      inputElem.focus();
    } else {
      inputElem.blur();
    }
  }
  
  //*************************************
  // Implementation of HasDirectionalText
  //*************************************
  
  Direction getTextDirection() {
    return directionalTextHelper.getTextDirection();
  }
  
  void setText(String text, Direction dir) {
    directionalTextHelper.setTextOrHtml(text, false, dir);
  }

  //*****************************************
  // Implementation of HasDirectionalSafeHtml
  //*****************************************
  
  void setHtml(SafeHtml html, Direction dir) {
    directionalTextHelper.setTextOrHtml(html.asString(), true, dir);
  }
  
  //***********
  // PROPERTIES
  //***********

  /**
   * Sets the element's text.
   */
  String get text => directionalTextHelper.getTextOrHtml(false);

  /**
   * Get the element's text.
   */
  void set text(String val) {
    directionalTextHelper.setTextOrHtml(val, false);
  }

  /**
   * Returns the value property of the input element that backs this widget.
   * This is the value that will be associated with the CheckBox name and
   * submitted to the server if a {@link FormPanel} that holds it is submitted
   * and the box is checked.
   * <p>
   * Don't confuse this with {@link #getValue}, which returns true or false if
   * the widget is checked.
   */
  String get formValue => inputElem.value;

  /**
   * Set the value property on the input element that backs this widget. This is
   * the value that will be associated with the CheckBox's name and submitted to
   * the server if a {@link FormPanel} that holds it is submitted and the box is
   * checked.
   * <p>
   * Don't confuse this with {@link #setValue}, which actually checks and
   * unchecks the box.
   *
   * @param value
   */
  void set formValue(String val) {
    inputElem.value = val;
  }

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
      return inputElem.checked;
    } else {
      return inputElem.defaultChecked;
    }
  }

  /**
   * Checks or unchecks the check box, firing {@link ValueChangeEvent} if
   * appropriate.
   * <p>
   * Note that this <em>does not</em> set the value property of the checkbox
   * input element wrapped by this widget. For access to that property, see
   * {@link #setFormValue(String)}
   *
   * @param value true to check, false to uncheck; null value implies false
   * @param fireEvents If true, and value has changed, fire a
   *          {@link ValueChangeEvent}
   */
  void setValue(bool val, [bool fireEvents = false]) {
    if (val == null) {
      val = false;
    }

    bool oldValue = getValue();
    inputElem.checked = val;
    inputElem.defaultChecked = val;
    if (val != oldValue && fireEvents) {
      ValueChangeEvent.fire(this, val);
    }
  }

  //*******
  // Events
  //*******
  void ensureDomEventHandlers() {
    addClickHandler(new ClickHandlerAdapter((ClickEvent event) {
      // Checkboxes always toggle their value, no need to compare
      // with old value. Radio buttons are not so lucky, see
      // overrides in RadioButton
      ValueChangeEvent.fire(this, getValue());
    }));
  }

  // Unlike other widgets the CheckBox sinks on its inputElement, not
  // its wrapper
  void sinkEvents(int eventBitsToAdd) {
    if (isOrWasAttached()) {
      Event.sinkEvents(inputElem, eventBitsToAdd | Event.getEventsSunk(inputElem));
    } else {
      super.sinkEvents(eventBitsToAdd);
    }
  }

  //*******
  // Logics
  //*******

  /**
   * This method is called when a widget is attached to the browser's document.
   * onAttach needs special handling for the CheckBox case. Must still call
   * {@link Widget#onAttach()} to preserve the <code>onAttach</code> contract.
   */
  void onLoad() {
    setEventListener(inputElem, this);
  }

  /**
   * This method is called when a widget is detached from the browser's
   * document. Overridden because of IE bug that throws away checked state and
   * in order to clear the event listener off of the <code>inputElem</code>.
   */
  void onUnload() {
    // Clear out the inputElem's event listener (breaking the circular
    // reference between it and the widget).
    setEventListener(inputElem, null);
    setValue(getValue(), false);
  }

  /**
   * Replace the current input element with a new one. Preserves all state
   * except for the name property, for nasty reasons related to radio button
   * grouping. (See implementation of {@link RadioButton#setName}.)
   *
   * @param elem the new input element
   */
  void replaceInputElement(dart_html.InputElement newInputElem) {
    // Collect information we need to set
    int _tabIndex = tabIndex;
    bool _checked = getValue();
    bool _enabled = enabled;
    String _formValue = formValue;
    String _uid = inputElem.id;
    //String accessKey = inputElem.getAccessKey();
    int sunkEvents = Event.getEventsSunk(inputElem);

    // Clear out the old input element
    setEventListener(inputElem, null);

    //getElement().replaceChild(newInputElem, inputElem);
    inputElem.replaceWith(newInputElem);

    // Sink events on the new element
    Event.sinkEvents(newInputElem, Event.getEventsSunk(inputElem));
    Event.sinkEvents(inputElem, 0);
    inputElem = newInputElem;

    // Setup the new element
    Event.sinkEvents(inputElem, sunkEvents);
    inputElem.id = _uid;
//    if (!"".equals(accessKey)) {
//      inputElem.setAccessKey(accessKey);
//    }
    tabIndex = _tabIndex;
    setValue(_checked);
    enabled = _enabled;
    formValue = _formValue;

    // Set the event listener
    if (isAttached()) {
      setEventListener(inputElem, this);
    }
  }

  void setEventListener(dart_html.Element e, EventListener listener) {
    Dom.setEventListener(e, listener);
  }

  LeafValueEditor<bool> asEditor() {
    if (editor == null) {
      editor = new TakesValueEditor.of(this);
    }
    return editor;
  }

  DirectionEstimator getDirectionEstimator() {
    return directionalTextHelper.getDirectionEstimator();
  }

  /**
   * {@inheritDoc}
   * <p>
   * See note at {@link #setDirectionEstimator(DirectionEstimator)}.
   */
  void enableDirectionEstimator(bool enabled) {
    directionalTextHelper.enableDefaultDirectionEstimator(enabled);
  }

  /**
   * {@inheritDoc}
   * <p>
   * Note: DirectionEstimator should be set before the label has any content;
   * it's highly recommended to set it using a constructor. Reason: if the
   * label already has non-empty content, this will update its direction
   * according to the new estimator's result. This may cause flicker, and thus
   * should be avoided.
   */
  void setDirectionEstimator(DirectionEstimator directionEstimator) {
    directionalTextHelper.setDirectionEstimator(directionEstimator);
  }
}
