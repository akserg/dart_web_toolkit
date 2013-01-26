//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract base class for all text entry widgets.
 *
 * <h3>Use in UiBinder Templates</h3>
 *
 * @param <T> the value type
 */
class ValueBoxBase<T> extends FocusWidget implements
  HasChangeHandlers, HasName, HasDirectionEstimator,
  HasValue<T>, AutoDirectionHandlerTarget, IsEditor<ValueBoxEditor<T>> {

  static TextBoxImpl _impl = new TextBoxImpl.browserDependent();
  AutoDirectionHandler _autoDirHandler;

  Parser<T> _parser;
  Renderer<T> _renderer;
  ValueBoxEditor<T> _editor;
  dart_html.Event _currentEvent;

  bool _valueChangeHandlerInitialized = false;

  /**
   * Creates a value box that wraps the given browser element handle. This is
   * only used by subclasses.
   *
   * @param elem the browser element to wrap
   */
  ValueBoxBase(dart_html.Element elem, Renderer<T> renderer, Parser<T> parser) : super(elem) {
    _autoDirHandler = AutoDirectionHandler.addToDefault(this, BidiPolicy.isBidiEnabled());
    this._renderer = renderer;
    this._parser = parser;
  }

  //************************************
  // Implementation of HasChangeHandlers
  //************************************

  HandlerRegistration addChangeHandler(ChangeHandler handler) {
    return addDomHandler(handler, ChangeEvent.TYPE);
  }

  //*****************************************
  // Implementation of HasValueChangeHandlers
  //*****************************************

  HandlerRegistration addValueChangeHandler(ValueChangeHandler<T> handler) {
    // Initialization code
    if (!_valueChangeHandlerInitialized) {
      _valueChangeHandlerInitialized = true;
      addChangeHandler(new ChangeHandlerAdapter((ChangeEvent event){
        ValueChangeEvent.fire(this, getValue());
      }));
    }
    return addHandler(handler, ValueChangeEvent.TYPE);
  }

  /**
   * Returns an Editor that is backed by the ValueBoxBase. The default
   * implementation returns {@link ValueBoxEditor#of(ValueBoxBase)}. Subclasses
   * may override this method to provide custom error-handling when using the
   * Editor framework.
   */
  ValueBoxEditor<T> asEditor() {
    if (_editor == null) {
      _editor = new ValueBoxEditor.of(this);
    }
    return _editor;
  }

  /**
   * If a keyboard event is currently being handled on this text box, calling
   * this method will suppress it. This allows listeners to easily filter
   * keyboard input.
   */
  void cancelKey() {
    if (_currentEvent != null) {
      //DOM.eventPreventDefault(currentEvent);
      _currentEvent.preventDefault();
    }
  }

  /**
   * Gets the current position of the cursor (this also serves as the beginning
   * of the text selection).
   *
   * @return the cursor's position
   */
  int getCursorPos() {
    return _impl.getCursorPos(getElement());
  }

  /**
   * Sets the cursor position.
   *
   * This will only work when the widget is attached to the document and not
   * hidden.
   *
   * @param pos the new cursor position
   */
  void setCursorPos(int pos) {
    setSelectionRange(pos, 0);
  }

  Direction get direction => BidiUtils.getDirectionOnElement(getElement());

  void set direction(Direction val) {
    BidiUtils.setDirectionOnElement(getElement(), val);
  }

  DirectionEstimator getDirectionEstimator() {
    return _autoDirHandler.getDirectionEstimator();
  }

  /**
   * Toggles on / off direction estimation.
   */
  void enableDefaultDirectionEstimator(bool enabled) {
    _autoDirHandler.enableDefaultDirectionEstimator(enabled);
  }

  /**
   * Sets the direction estimation model of the auto-dir handler.
   */
  void setDirectionEstimator(DirectionEstimator directionEstimator) {
    _autoDirHandler.setDirectionEstimator(directionEstimator);
  }

  String get name => Dom.getElementProperty(getElement(), "name");

  void set name(String val) {
    Dom.setElementProperty(getElement(), "name", val);
  }

  /**
   * Gets the text currently selected within this text box.
   *
   * @return the selected text, or an empty string if none is selected
   */
  String getSelectedText() {
    int start = getCursorPos();
    if (start < 0) {
      return "";
    }
    int length = getSelectionLength();
    return text.substring(start, start + length);
  }

  /**
   * Gets the length of the current text selection.
   *
   * @return the text selection length
   */
  int getSelectionLength() {
    return _impl.getSelectionLength(getElement());
  }

  String get text => Dom.getElementProperty(getElement(), "value");

  /**
   * Sets this object's text. Note that some browsers will manipulate the text
   * before adding it to the widget. For example, most browsers will strip all
   * <code>\r</code> from the text, except IE which will add a <code>\r</code>
   * before each <code>\n</code>. Use {@link #getText()} to get the text
   * directly from the widget.
   *
   * @param text the object's new text
   */
  void set text(String val) {
    Dom.setElementProperty(getElement(), "value", val != null ? val : "");
    _autoDirHandler.refreshDirection();
  }

  /**
   * Return the parsed value, or null if the field is empty or parsing fails.
   */
  T getValue() {
    try {
      return getValueOrThrow();
    } on Exception catch (e) {
      return null;
    }
  }

  void setValue(T value, [bool fireEvents = false]) {
    T oldValue = getValue();
    text = _renderer.render(value);
    if (fireEvents) {
      ValueChangeEvent.fireIfNotEqual(this, oldValue, value);
    }
  }

  /**
   * Return the parsed value, or null if the field is empty.
   *
   * @throws ParseException if the value cannot be parsed
   */
  T getValueOrThrow() {
    T parseResult = _parser.parse(text);

    if (text == "") {
      return null;
    }

    return parseResult;
  }

  /**
   * Determines whether or not the widget is read-only.
   *
   * @return <code>true</code> if the widget is currently read-only,
   *         <code>false</code> if the widget is currently editable
   */
  bool isReadOnly() {
    return Dom.getElementPropertyBoolean(getElement(), "readOnly");
  }

  void onBrowserEvent(dart_html.Event event) {
    int type = Dom.eventGetType(event);
    if ((type & Event.KEYEVENTS) != 0) {
      // Fire the keyboard event. Hang on to the current event object so that
      // cancelKey() and setKey() can be implemented.
      _currentEvent = event;
      // Call the superclass' onBrowserEvent as that includes the key event
      // handlers.
      super.onBrowserEvent(event);
      _currentEvent = null;
    } else {
      // Handles Focus and Click events.
      super.onBrowserEvent(event);
    }
  }

  /**
   * Selects all of the text in the box.
   *
   * This will only work when the widget is attached to the document and not
   * hidden.
   */
  void selectAll() {
    int length = text.length;
    if (length > 0) {
      setSelectionRange(0, length);
    }
  }

  void setAlignment(TextAlignment align) {
    Dom.setStyleAttribute(getElement(), "textAlign", align.value);
  }

  /**
   * Turns read-only mode on or off.
   *
   * @param readOnly if <code>true</code>, the widget becomes read-only; if
   *          <code>false</code> the widget becomes editable
   */
  void setReadOnly(bool readOnly) {
    Dom.setElementPropertyBoolean(getElement(), "readOnly", readOnly);
    String readOnlyStyle = "readonly";
    if (readOnly) {
      addStyleDependentName(readOnlyStyle);
    } else {
      removeStyleDependentName(readOnlyStyle);
    }
  }

  /**
   * Sets the range of text to be selected.
   *
   * This will only work when the widget is attached to the document and not
   * hidden.
   *
   * @param pos the position of the first character to be selected
   * @param length the number of characters to be selected
   */
  void setSelectionRange(int pos, int length) {
    // Setting the selection range will not work for unattached elements.
    if (!isAttached()) {
      return;
    }

    if (length < 0) {
      throw new Exception("Length must be a positive integer. Length: ${length}");
    }
    if (pos < 0 || length + pos > text.length) {
      throw new Exception("From Index: $pos  To Index: ${pos + length}  Text Length: ${text.length}");
    }
    _impl.setSelectionRange(getElement(), pos, length);
  }

  TextBoxImpl getImpl() {
    return _impl;
  }

  void onLoad() {
    super.onLoad();
    _autoDirHandler.refreshDirection();
  }
}