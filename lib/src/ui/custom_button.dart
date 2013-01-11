//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;
/**
 * CustomButton is a base button class with built in support for a set number
 * of button faces.
 *
 * Each face has its own style modifier. For example, the state for down and
 * hovering is assigned the CSS modifier <i>down-hovering</i>. So, if the
 * button's overall style name is <i>gwt-PushButton</i> then when showing the
 * <code>down-hovering</code> face, the button's style is <i>
 * gwt-PushButton-down-hovering</i>. The overall style name can be used to
 * change the style of the button irrespective of the current face.
 *
 * <p>
 * Each button face can be assigned is own image, text, or html contents. If no
 * content is defined for a face, then the face will use the contents of another
 * face. For example, if <code>down-hovering</code> does not have defined
 * contents, it will use the contents defined by the <code>down</code> face.
 * </p>
 *
 * <p>
 * The supported faces are defined below:
 * </p>
 * <p>
 * <table border="4">
 * <tr>
 *
 * <td><b>CSS style name</b></td>
 * <td><b>Getter method</b></td>
 * <td><b>description of face</b></td>
 * <td><b>defaults to contents of face</b></td>
 * </tr>
 *
 * <tr>
 * <td>up</td>
 * <td> {@link #getUpFace()}</td>
 * <td>face shown when button is up</td>
 * <td>none</td>
 * </tr>
 *
 * <tr>
 * <td>down</td>
 * <td> {@link #getDownFace()}</td>
 * <td>face shown when button is down</td>
 * <td>up</td>
 * </tr>
 *
 * <tr>
 * <td>up-hovering</td>
 * <td> {@link #getUpHoveringFace()}</td>
 * <td>face shown when button is up and hovering</td>
 * <td>up</td>
 * </tr>
 *
 * <tr>
 * <td>up-disabled</td>
 * <td> {@link #getUpDisabledFace()}</td>
 * <td>face shown when button is up and disabled</td>
 * <td>up</td>
 * </tr>
 *
 * <tr>
 * <td>down-hovering</td>
 * <td> {@link #getDownHoveringFace()}</td>
 * <td>face shown when button is down and hovering</td>
 * <td>down</td>
 * </tr>
 *
 * <tr>
 * <td>down-disabled</td>
 * <td> {@link #getDownDisabledFace()}</td>
 * <td>face shown when button is down and disabled</td>
 * <td>down</td>
 * </tr>
 * </table>
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 *
 * When working with CustomButton subclasses in
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates, you
 * can set text and assign ImageResources for their various faces via
 * child elements:
 * <p>
 * <dl>
 * <dt>&lt;g:upFace>
 * <dt>&lt;g:downFace>
 * <dt>&lt;g:upHoveringFace>
 * <dt>&lt;g:downHoveringFace>
 * <dt>&lt;g:upDisabledFace>
 * <dt>&lt;g:downDisabledFace>
 * </dl>
 *
 * Each face element can take an optional <code>image</code> attribute
 * and an html body. For example:<pre>
 * &lt;ui:image field='downButton'/> &lt;!-- define an {@link com.google.gwt.resources.client.ImageResource ImageResource} -->
 *
 * &lt;g:PushButton ui:field='pushButton' enabled='true'>
 *   &lt;g:upFace>
 *     &lt;b>click me&lt;/b>
 *   &lt;/gwt:upFace>
 *   &lt;g:upHoveringFace>
 *     &lt;b>Click ME!&lt;/b>
 *   &lt;/gwt:upHoveringFace>
 *
 *   &lt;g:downFace image='{downButton}'/>
 *   &lt;g:downHoveringFace image='{downButton}'/>
 * &lt;/g:PushButton>
 * </pre>
 */
class CustomButton extends ButtonBase {

  static String _STYLENAME_DEFAULT = "dwt-CustomButton";

  /**
   * Pressed Attribute bit.
   */
  static const int _DOWN_ATTRIBUTE = 1;

  /**
   * Hovering Attribute bit.
   */
  static const int _HOVERING_ATTRIBUTE = 2;

  /**
   * Disabled Attribute bit.
   */
  static const int _DISABLED_ATTRIBUTE = 4;

  /**
   * ID for up face.
   */
  static const int _UP = 0;

  /**
   * ID for down face.
   */
  static const int _DOWN = _DOWN_ATTRIBUTE;

  /**
   * ID for _upHovering face.
   */
  static const int _UP_HOVERING = _HOVERING_ATTRIBUTE;

  /**
   * ID for _downHovering face.
   */
  static const int _DOWN_HOVERING = _DOWN_ATTRIBUTE | _HOVERING_ATTRIBUTE;

  /**
   * ID for _upDisabled face.
   */
  static const int _UP_DISABLED = _DISABLED_ATTRIBUTE;

  /**
   * ID for _downDisabled face.
   */
  static const int _DOWN_DISABLED = _DOWN | _DISABLED_ATTRIBUTE;

  /**
   * The button's current face element.
   */
  dart_html.Element _curFaceElement;

  /**
   * The button's current face.
   */
  Face _curFace;

  /**
   * Face for up.
   */
  Face _up;

  /**
   * Face for down.
   */
  Face _down;

  /**
   * Face for downHover.
   */
  Face _downHovering;

  /**
   * Face for upHover.
   */
  Face _upHovering;

  /**
   * Face for _upDisabled.
   */
  Face _upDisabled;

  /**
   * Face for _downDisabled.
   */
  Face _downDisabled;

  /**
   * If <code>true</code>, this widget is capturing with the mouse held down.
   */
  bool _isCapturing = false;

  /**
   * If <code>true</code>, this widget has focus with the space bar down.
   */
  bool _isFocusing = false;

  /**
   * Used to decide whether to allow clicks to propagate up to the superclass
   * or container elements.
   */
  bool _allowClick = false;

  /**
   * Constructor for <code>CustomButton</code>.
   *
   * @param upImage image for the default (up) face of the button
   */
  CustomButton.fromImage(Image upImage, {Image downImage:null, ClickHandler handler:null}) : super(FocusPanel.impl.createFocusable()) {
    _init();
    //
    getUpFace().setImage(upImage);
    //
    if (downImage != null) {
      getDownFace().setImage(downImage);
    }
    //
    if (handler != null) {
      addClickHandler(handler);
    }
  }

  /**
   * Constructor for <code>CustomButton</code>.
   *
   * @param upText the text for the default (up) face of the button
   */
  CustomButton.fromText(String upText, {String downText:null, ClickHandler handler:null}) : super(FocusPanel.impl.createFocusable()) {
    _init();
    //
    getUpFace().text = upText;
    //
    if (downText != null) {
      getDownFace().text = downText;
    }
    //
    if (handler != null) {
      addClickHandler(handler);
    }
  }

  CustomButton.internal() : super(FocusPanel.impl.createFocusable()) {
    _init();
  }

  /**
   * Constructor for <code>CustomButton</code>.
   */
  void _init() {
    // Use FocusPanel.impl rather than FocusWidget because only FocusPanel.impl
    // works across browsers to create a focusable element.
    //sinkEvents(Event.ONCLICK | Event.MOUSEEVENTS | Event.FOCUSEVENTS | Event.KEYEVENTS);
    setUpFace(_createFace(null, "up", _UP));
    clearAndSetStyleName(_STYLENAME_DEFAULT);

    // Add a11y role "button"
    Roles.BUTTON.set(getElement());
  }

  //********
  // Up Face
  //********

  /**
   * Gets the up face of the button.
   *
   * @return the up face
   */
  Face getUpFace() {
    return _up;
  }

  /**
   * Gets the _upDisabled face of the button.
   *
   * @return the _upDisabled face
   */
  Face getUpDisabledFace() {
    if (_upDisabled == null) {
      _setUpDisabledFace(_createFace(getUpFace(), "up-disabled", _UP_DISABLED));
    }
    return _upDisabled;
  }

  /**
   * Gets the _upHovering face of the button.
   *
   * @return the _upHovering face
   */
  Face getUpHoveringFace() {
    if (_upHovering == null) {
      _setUpHoveringFace(_createFace(getUpFace(), "up-hovering", _UP_HOVERING));
    }
    return _upHovering;
  }

  //**********
  // Down Face
  //**********

  /**
   * Gets the down face of the button.
   *
   * @return the down face
   */
  Face getDownFace() {
    if (_down == null) {
      _setDownFace(_createFace(getUpFace(), "down", _DOWN));
    }
    return _down;
  }

  /**
   * Gets the _downDisabled face of the button.
   *
   * @return the _downDisabled face
   */
  Face getDownDisabledFace() {
    if (_downDisabled == null) {
      _setDownDisabledFace(_createFace(getDownFace(), "down-disabled", _DOWN_DISABLED));
    }
    return _downDisabled;
  }

  /**
   * Gets the _downHovering face of the button.
   *
   * @return the _downHovering face
   */
  Face getDownHoveringFace() {
    if (_downHovering == null) {
      _setDownHoveringFace(_createFace(getDownFace(), "down-hovering", _DOWN_HOVERING));
    }
    return _downHovering;
  }

  //*************
  // Current face
  //*************

  /**
   * Gets the current face's html.
   *
   * @return current face's html
   */
  String get html => getCurrentFace().html;

  /**
   * Sets the current face's html.
   *
   * @param html html to set
   */
  void set html(String value) {
    getCurrentFace().html = value;
  }

  int get tabIndex => FocusPanel.impl.getTabIndex(getElement()); //FocusHelper.getFocusHelper().getTabIndex(getElement());

  void set tabIndex(int index) {
    FocusPanel.impl.setTabIndex(getElement(), index); //FocusHelper.getFocusHelper().setTabIndex(getElement(), index);
  }

  /**
   * Gets the current face's text.
   *
   * @return current face's text
   */
  String get text => getCurrentFace().text;

  /**
   * Sets the current face's text.
   *
   * @param text text to set
   */
  void set text(String value) {
    getCurrentFace().text = value;
  }

  /**
   * Is this button down?
   *
   * @return <code>true</code> if the button is down
   */
  bool isDown() {
    return (_DOWN_ATTRIBUTE & getCurrentFace().getFaceID()) > 0;
  }

  //*******
  // Events
  //*******

  void onBrowserEvent(dart_html.Event event) {
    // Should not act on button if disabled.
    if (!enabled) {
      // This can happen when events are bubbled up from non-disabled children
      return;
    }

//    int type = DOM.eventGetType(event);
//    switch (type) {
//      case Event.ONCLICK:
//        // If clicks are currently disallowed, keep it from bubbling or being
//        // passed to the superclass.
//        if (!_allowClick) {
//          event.stopPropagation();
//          return;
//        }
//        break;
//      case Event.ONMOUSEDOWN:
//        if (event.getButton() == Event.BUTTON_LEFT) {
//          setFocus(true);
//          onClickStart();
//          DOM.setCapture(getElement());
//          _isCapturing = true;
//          // Prevent dragging (on some browsers);
//          DOM.eventPreventDefault(event);
//        }
//        break;
//      case Event.ONMOUSEUP:
//        if (_isCapturing) {
//          _isCapturing = false;
//          DOM.releaseCapture(getElement());
//          if (isHovering() && event.getButton() == Event.BUTTON_LEFT) {
//            onClick();
//          }
//        }
//        break;
//      case Event.ONMOUSEMOVE:
//        if (_isCapturing) {
//          // Prevent dragging (on other browsers);
//          DOM.eventPreventDefault(event);
//        }
//        break;
//      case Event.ONMOUSEOUT:
//        Element to = DOM.eventGetToElement(event);
//        if (DOM.isOrHasChild(getElement(), DOM.eventGetTarget(event))
//            && (to == null || !DOM.isOrHasChild(getElement(), to))) {
//          if (_isCapturing) {
//            onClickCancel();
//          }
//          setHovering(false);
//        }
//        break;
//      case Event.ONMOUSEOVER:
//        if (DOM.isOrHasChild(getElement(), DOM.eventGetTarget(event))) {
//          setHovering(true);
//          if (_isCapturing) {
//            onClickStart();
//          }
//        }
//        break;
//      case Event.ONBLUR:
//        if (_isFocusing) {
//          _isFocusing = false;
//          onClickCancel();
//        }
//        break;
//      case Event.ONLOSECAPTURE:
//        if (_isCapturing) {
//          _isCapturing = false;
//          onClickCancel();
//        }
//        break;
//    }
//
//    super.onBrowserEvent(event);
//
//    // Synthesize clicks based on keyboard events AFTER the normal key handling.
//    if ((event.getTypeInt() & Event.KEYEVENTS) != 0) {
//      char keyCode = (char) DOM.eventGetKeyCode(event);
//      switch (type) {
//        case Event.ONKEYDOWN:
//          if (keyCode == ' ') {
//            _isFocusing = true;
//            onClickStart();
//          }
//          break;
//        case Event.ONKEYUP:
//          if (_isFocusing && keyCode == ' ') {
//            _isFocusing = false;
//            onClick();
//          }
//          break;
//        case Event.ONKEYPRESS:
//          if (keyCode == '\n' || keyCode == '\r') {
//            onClickStart();
//            onClick();
//          }
//          break;
//      }
//    }
  }

//  void setAccessKey(Char key) {
//    FocusHelper.getFocusHelper().setAccessKey(getElement(), key);
//  }

  /**
   * Sets whether this button is enabled.
   *
   * @param enabled <code>true</code> to enable the button, <code>false</code>
   * to disable it
   */
  void set enabled(bool value) {
    if (enabled != value) {
      toggleDisabled();
      super.enabled = value;
      if (!value) {
        cleanupCaptureState();
        Roles.BUTTON.removeAriaPressedState(getElement());
      } else {
        _setAriaPressed(getCurrentFace());
      }
    }
  }

  void setFocus(bool focused) {
    if (focused) {
      FocusPanel.impl.focus(getElement()); //FocusHelper.getFocusHelper().focus(getElement());
    } else {
      FocusPanel.impl.blur(getElement()); //FocusHelper.getFocusHelper().blur(getElement());
    }
  }

  /**
   * Overridden on attach to ensure that a button face has been chosen before
   * the button is displayed.
   */
  void onAttach() {
    finishSetup();
    super.onAttach();
  }

  void onDetach() {
    super.onDetach();
    cleanupCaptureState();
    setHovering(false);
  }

  /**
   * Called when the user finishes clicking on this button. The default behavior
   * is to fire the click event to listeners. Subclasses that override
   * {@link #onClickStart()} should override this method to restore the normal
   * widget display.
   */
  void onClick() {
    // Allow the click we're about to synthesize to pass through to the
    // superclass and containing elements. Element.dispatchEvent() is
    // synchronous, so we simply set and clear the flag within this method.
    _allowClick = true;

    // Mouse coordinates are not always available (e.g., when the click is
    // caused by a keyboard event).
    //NativeEvent evt = Document.get().createClickEvent(1, 0, 0, 0, 0, false, false, false, false);
    // Create DOM CustomEvent
    dart_html.CustomEvent evt = dart_html.document.$dom_createEvent('CustomEvent');
    // After DOM CustomEvent instance has been created we can initialise it here
    evt.$dom_initCustomEvent('CustomEvent', false, false, false);
    // Dispatch event
    getElement().$dom_dispatchEvent(evt);

    _allowClick = false;
  }

  /**
   * Called when the user aborts a click in progress; for example, by dragging
   * the mouse outside of the button before releasing the mouse button.
   * Subclasses that override {@link #onClickStart()} should override this
   * method to restore the normal widget display.
   */
  void onClickCancel() { }

  /**
   * Called when the user begins to click on this button. Subclasses may
   * override this method to display the start of the click visually; such
   * subclasses should also override {@link #onClick()} and
   * {@link #onClickCancel()} to restore normal visual state. Each
   * <code>onClickStart</code> will eventually be followed by either
   * <code>onClick</code> or <code>onClickCancel</code>, depending on whether
   * the click is completed.
   */
  void onClickStart() { }

  /**
   * Sets whether this button is down.
   *
   * @param down <code>true</code> to press the button, <code>false</code>
   * otherwise
   */
  void setDown(bool down) {
    if (down != isDown()) {
      toggleDown();
    }
  }

  /**
   * Common setup between constructors.
   */
  void finishSetup() {
    if (_curFace == null) {
      setCurrentFace(getUpFace());
    }
  }

  void fireClickListeners(dart_html.Event nativeEvent) {
    // TODO(ecc) Once event triggering is committed, should fire a native click event instead.
    fireEvent(new ClickEvent());
  }

  /**
   * Gets the current face of the button.
   *
   * @return the current face
   */

  Face getCurrentFace() {
    /*
     * Implementation note: Package protected so we can use it when testing the
     * button.
     */
    finishSetup();
    return _curFace;
  }

  void setCurrentFace(Face newFace) {
    /*
     * Implementation note: default access for testing.
     */
    if (_curFace != newFace) {
      if (_curFace != null) {
        print("setCurrentFace. removeStyleDependentName: ${_curFace.getName()}");
        removeStyleDependentName(_curFace.getName());
      }
      _curFace = newFace;
      _setCurrentFaceElement(newFace.getFace());
      print("setCurrentFace. addStyleDependentName: ${_curFace.getName()}");
      addStyleDependentName(_curFace.getName());

      if (enabled) {
        _setAriaPressed(newFace);
      }
    }
  }

  /**
   * Sets the current face based on the faceID.
   *
   * @param faceID sets the new face of the button
   */
  void _setCurrentFace(int faceID) {
    Face newFace = _getFaceFromID(faceID);
    setCurrentFace(newFace);
  }

  /**
   * Is the mouse hovering over this button?
   *
   * @return <code>true</code> if the mouse is hovering
   */
  bool isHovering() {
    return (_HOVERING_ATTRIBUTE & getCurrentFace().getFaceID()) > 0;
  }

  /**
   * Sets whether this button is hovering.
   *
   * @param hovering is this button hovering?
   */
  void setHovering(bool hovering) {
    if (hovering != isHovering()) {
      toggleHover();
    }
  }

  /**
   * Toggle the up/down attribute.
   */
  void toggleDown() {
    int newFaceID = getCurrentFace().getFaceID() ^ _DOWN_ATTRIBUTE;
    _setCurrentFace(newFaceID);
  }

  /**
   * Resets internal state if this button can no longer service events. This can
   * occur when the widget becomes detached or disabled.
   */
  void cleanupCaptureState() {
    if (_isCapturing || _isFocusing) {
      Dom.releaseCapture(getElement());
      _isCapturing = false;
      _isFocusing = false;
      onClickCancel();
    }
  }

  Face _createFace(Face delegateTo, String name, int faceID) {
    return new SimpleFace(this, delegateTo, name, faceID);
  }

  Face _getFaceFromID(int id) {
    switch (id) {
      case _DOWN:
        return getDownFace();
      case _UP:
        return getUpFace();
      case _DOWN_HOVERING:
        return getDownHoveringFace();
      case _UP_HOVERING:
        return getUpHoveringFace();
      case _UP_DISABLED:
        return getUpDisabledFace();
      case _DOWN_DISABLED:
        return getDownDisabledFace();
      default:
        throw new Exception("$id is not a known face id.");
    }
  }

  void _setAriaPressed(Face newFace) {
    bool pressed = (newFace.getFaceID() & _DOWN_ATTRIBUTE) == 1;
    Roles.BUTTON.setAriaPressedState(getElement(), PressedValue.of(pressed));
  }

  void _setCurrentFaceElement(dart_html.Element newFaceElement) {
    if (_curFaceElement != newFaceElement) {
      if (_curFaceElement != null) {
        //DOM.removeChild(getElement(), _curFaceElement);
        _curFaceElement.remove();
      }
      _curFaceElement = newFaceElement;
      //DOM.appendChild(getElement(), _curFaceElement);
      getElement().append(_curFaceElement);
    }
  }

  /**
   * Sets the _downDisabled face of the button.
   *
   * @param _downDisabled _downDisabled face
   */
  void _setDownDisabledFace(Face _downDisabled) {
    this._downDisabled = _downDisabled;
  }

  /**
   * Sets the down face of the button.
   *
   * @param down the down face
   */
  void _setDownFace(Face down) {
    this._down = down;
  }

  /**
   * Sets the _downHovering face of the button.
   *
   * @param _downHovering hoverDown face
   */
  void _setDownHoveringFace(Face _downHovering) {
    this._downHovering = _downHovering;
  }

  /**
   * Sets the _upDisabled face of the button.
   *
   * @param _upDisabled _upDisabled face
   */
  void _setUpDisabledFace(Face _upDisabled) {
    this._upDisabled = _upDisabled;
  }

  /**
   * Sets the up face of the button.
   *
   * @param up up face
   */
  void setUpFace(Face up) {
    this._up = up;
  }

  /**
   * Sets the _upHovering face of the button.
   *
   * @param _upHovering _upHovering face
   */
  void _setUpHoveringFace(Face _upHovering) {
    this._upHovering = _upHovering;
  }

  /**
   * Toggle the disabled attribute.
   */
  void toggleDisabled() {
    // Toggle disabled.
    int newFaceID = getCurrentFace().getFaceID() ^ _DISABLED_ATTRIBUTE;

    // Remove hovering.
    newFaceID &= ~_HOVERING_ATTRIBUTE;

    // Sets the current face.
    _setCurrentFace(newFaceID);
  }

  /**
   * Toggle the hovering attribute.
   */
  void toggleHover() {
    // Toggle hovering.
    int newFaceID = getCurrentFace().getFaceID() ^ _HOVERING_ATTRIBUTE;

    // Remove disabled.
    newFaceID &= ~_DISABLED_ATTRIBUTE;
    _setCurrentFace(newFaceID);
  }
}

/**
 * Represents a button's face. Each face is associated with its own style
 * modifier and, optionally, its own contents html, text, or image.
 */
abstract class Face  implements HasHtml {

  static String STYLENAME_HTML_FACE = "html-face";
  Face delegateTo;
  dart_html.Element face;

  CustomButton _customButton;

  /**
   * Constructor for <code>Face</code>. Creates a new face that delegates to
   * the supplied face.
  *
   * @param delegateTo default content provider
   */
  Face(this._customButton, this.delegateTo);

  //**************************
  // Implementation of HasHtml
  //**************************

  /**
   * Gets the face's contents as html.
  *
   * @return face's contents as html
  *
   */
  String get html => getFace().innerHtml;

  /**
   * Set the face's contents as html.
  *
   * @param html html to set as face's contents html
  *
   */
  void set html(String value) {
    face = new dart_html.DivElement();
    UiObject.manageElementStyleName(face, STYLENAME_HTML_FACE, true);
    face.innerHtml = value;
    updateButtonFace();
  }

  //**************************
  // Implementation of HasText
  //**************************

  /**
   * Gets the face's contents as text.
  *
   * @return face's contents as text
  *
   */
  String get text => getFace().text;

  /**
   * Sets the face's contents as text.
  *
   * @param text text to set as face's contents
   */
  void set text(String value) {
    face = new dart_html.DivElement();
    UiObject.manageElementStyleName(face, STYLENAME_HTML_FACE, true);
    face.text = value;
    updateButtonFace();
  }


  /**
   * Gets the contents associated with this face.
   */
  dart_html.Element getFace() {
    if (face == null) {
      if (delegateTo == null) {
        // provide a default face as none was supplied.
        face = new dart_html.DivElement();
        return face;
      } else {
        return delegateTo.getFace();
      }
    } else {
      return face;
    }
  }

  void updateButtonFace() {
    if (_customButton._curFace != null && _customButton._curFace.getFace() == this.getFace()) {
      _customButton._setCurrentFaceElement(face);
    }
  }

  /**
   * Set the face's contents as an image.
  *
   * @param image image to set as face contents
   */
  void setImage(Image image) {
    face = image.getElement();
    updateButtonFace();
  }

  String toString() {
    return this.getName();
  }

  /**
   * Gets the ID associated with this face. This will be a bitwise and of all
   * of the attributes that comprise this face.
   */
  int getFaceID();

  /**
   * Get the name of the face. This property is also used as a modifier on the
   * <code>CustomButton</code> style. <p/> For instance, if the
   * <code>CustomButton</code> style is "gwt-PushButton" and the face name is
   * "up", then the CSS class name will be "gwt-PushButton-up".
  *
   * @return the face's name
   */
  String getName();
}

class SimpleFace extends Face {

  String name;
  int faceID;

  SimpleFace(CustomButton customButton, Face delegateTo, this.name, this.faceID) : super(customButton, delegateTo);

  String getName() {
    return name;
  }

  int getFaceID() {
    return faceID;
  }
}