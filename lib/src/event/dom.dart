//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * This class provides a set of static methods that allow you to manipulate the
 * browser's Document Object Model (DOM). It contains methods for manipulating
 * both [Element]s and [Event]s.
 */
class Dom {

  /**
   * DOM helper class Implementation.
   */
  static DomImpl impl = new DomImpl.browserDependent();
  static dart_html.Element _sCaptureElem;
  // The current event being fired
  static dart_html.Event _currentEvent;

  /**
   * Determine whether one element is equal to, or the child of, another.
   *
   * @param parent the potential parent element
   * @param child the potential child element
   * @return <code>true</code> if the relationship holds
   */
  static bool isOrHasChild(dart_html.Element parent, dart_html.Element child) {
    return impl.isOrHasChild(parent, child);
  }

  /**
   * Gets an element's n-th child element.
   *
   * @param parent the element whose child is to be retrieved
   * @param index the index of the child element
   * @return the n-th child element
   */
  static dart_html.Element getChild(dart_html.Element parent, int index) {
    return impl.getChild(parent, index);
  }

  /**
   * Gets the number of child elements present in a given parent element.
   *
   * @param parent the element whose children are to be counted
   * @return the number of children
   */
  static int getChildCount(dart_html.Element parent) {
    return impl.getChildCount(parent);
  }

  /**
   * Scrolls the given element into view.
   *
   * <p>
   * This method crawls up the DOM hierarchy, adjusting the scrollLeft and
   * scrollTop properties of each scrollable element to ensure that the
   * specified element is completely in view. It adjusts each scroll position by
   * the minimum amount necessary.
   * </p>
   *
   * @param elem the element to be made visible
   */
  static void scrollIntoView(dart_html.Element elem) {
    assert(elem != null);
    elem.scrollIntoView();
  }

  /**
   * Initialize the event system if it has not already been initialized.
   */
  static void maybeInitializeEventSystem() {
    impl.maybeInitializeEventSystem();
  }

  /**
   * Gets any named property from an element, as a string.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value
   */
  static String getElementProperty(dart_html.Element elem, String prop) {
    assert(elem != null);
    assert(prop != null);
    //
    String eProp = elem.attributes[prop];
    return eProp == null ? null : eProp;
  }

  /**
   * Gets any named property from an element, as an int.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value as an int
   */
  static int getElementPropertyInt(dart_html.Element elem, String prop) {
    String eProp = getElementProperty(elem, prop);
    //
    if (eProp == null) {
      return 0;
    } else {
      int intProp = int.parse(eProp);
      return intProp != null ? intProp : 0;
    }
  }

  /**
   * Gets any named property from an element, as a boolean.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value as a boolean
   */
  static bool getElementPropertyBoolean(dart_html.Element elem, String prop) {
    String eProp = getElementProperty(elem, prop);
    //
    return eProp == 'true';
  }

  /**
   * Gets any named property from an element, as a boolean.
   *
   * @param elem the element whose property is to be retrieved
   * @param prop the name of the property
   * @return the property's value as a boolean
   */
  static void setElementPropertyBoolean(dart_html.Element elem, String prop, bool value) {
    assert(elem != null);
    assert(prop != null);
    assert(value != null);
    //
    elem.attributes[prop] = value.toString();
  }

  /**
   * Sets a property on the given element.
   *
   * @param elem the element whose property is to be set
   * @param prop the name of the property to be set
   * @param value the new property value
   */
  static void setElementProperty(dart_html.Element elem, String prop, String value) {
    assert(elem != null);
    assert(prop != null);
    assert(value != null);
    //
    elem.attributes[prop] = value;
  }

  /**
   * Sets an int property on the given element.
   *
   * @param elem the element whose property is to be set
   * @param prop the name of the property to be set
   * @param value the new property value as an int
   */
  static void setElementPropertyInt(dart_html.Element elem, String prop, int value) {
    assert(elem != null);
    assert(prop != null);
    assert(value != null);
    //
    elem.attributes[prop] = value.toString();
  }

  /**
   * Sets an attribute on a given element.
   *
   * @param elem element whose attribute is to be set
   * @param attr the name of the attribute
   * @param value the value to which the attribute should be set
   */
  static void setElementAttribute(dart_html.Element elem, String attr, String value) {
    elem.attributes[attr] = value;
  }

  /**
   * Removes the named attribute from the given element.
   *
   * @param elem the element whose attribute is to be removed
   * @param attr the name of the element to remove
   */
  static void removeElementAttribute(dart_html.Element elem, String attr) {
    elem.attributes.remove(attr);
  }

  /**
   * Sets the {@link EventListener} to receive events for the given element.
   * Only one such listener may exist for a single element.
   *
   * @param elem the element whose listener is to be set
   * @param listener the listener to receive {@link Event events}
   */
  static void setEventListener(dart_html.Element elem, EventListener listener) {
    impl.setEventListener(elem, listener);
  }

  /**
   * Gets an element's absolute left coordinate in the document's coordinate
   * system.
   *
   * @param elem the element to be measured
   * @return the element's absolute left coordinate
   */
  static int getAbsoluteLeft(dart_html.Element elem) {
    return impl.getAbsoluteLeft(elem);
  }

  /**
   * Gets an element's absolute top coordinate in the document's coordinate
   * system.
   *
   * @param elem the element to be measured
   * @return the element's absolute top coordinate
   */
  static int getAbsoluteTop(dart_html.Element elem) {
    return impl.getAbsoluteTop(elem);
  }

  /**
   * Sets an attribute on the given element's style.
   *
   * @param elem the element whose style attribute is to be set
   * @param attr the name of the style attribute to be set
   * @param value the style attribute's new value
   */
  static void setStyleAttribute(dart_html.Element elem, String attr, String value) {
    elem.style.setProperty(attr, value, "");
  }

  /**
   * Sets an integer attribute on the given element's style.
   *
   * @param elem the element whose style attribute is to be set
   * @param attr the name of the style attribute to be set
   * @param value the style attribute's new integer value
   */
  static void setIntStyleAttribute(dart_html.Element elem, String attr, int value) {
    assert(elem != null);
    assert(attr != null);
    assert(value != null);
    elem.style.setProperty(attr, value.toString(), "");
  }

  static int uniqueId = 0;

  /**
   * Generates a unique DOM id. The id is of the form "dwt-id-<unique integer>".
   *
   * @return a unique DOM id
   */
  static String createUniqueId() {
    //return Document.get().createUniqueId();
    return "dwt-id-${uniqueId++}";
  }

  /**
   * Inserts an element as a child of the given parent element.
   * <p>
   * If the child element is a {@link com.google.gwt.user.client.ui.PotentialElement}, it is first
   * resolved.
   * </p>
   *
   * @param parent the parent element
   * @param child the child element to add to <code>parent</code>
   * @param index the index before which the child will be inserted (any value
   *          greater than the number of existing children will cause the child
   *          to be appended)
   * @see com.google.gwt.user.client.ui.PotentialElement#resolve(Element)
   */
  static void insertChild(dart_html.Element parent, dart_html.Element child, int index) {
    //assert !PotentialElement.isPotential(parent) : "Cannot insert into a PotentialElement";

    // If child isn't a PotentialElement, resolve() returns
    // the Element itself.
    //impl.insertChild(parent, PotentialElement.resolve(child).<Element> cast(), index);
    impl.insertChild(parent, child, index);
  }

  /**
   * Gets the first child element of the given element.
   *
   * @param elem the element whose child is to be retrieved
   * @return the child element
   */
  static dart_html.Element getFirstChild(dart_html.Element elem) {
    return elem.$dom_firstElementChild;
  }

  //********
  // Capture
  //********

  /**
   * Gets the element that currently has mouse capture.
   *
   * @return a handle to the capture element, or <code>null</code> if none
   *         exists
   */
  static dart_html.Element getCaptureElement() {
    return _sCaptureElem;
  }

  /**
   * Releases mouse/touch/gesture capture on the given element. Calling this
   * method has no effect if the element does not currently have
   * mouse/touch/gesture capture.
   *
   * @param elem the element to release capture
   * @see #setCapture(Element)
   */
  static void releaseCapture(dart_html.Element elem) {
    if ((_sCaptureElem != null) && elem == _sCaptureElem) {
      _sCaptureElem = null;
    }
    impl.releaseCapture(elem);
  }

  /**
   * Sets mouse/touch/gesture capture on the given element. This element will
   * directly receive all mouse events until {@link #releaseCapture(Element)} is
   * called on it.
   *
   * @param elem the element on which to set mouse/touch/gesture capture
   */
  static void setCapture(dart_html.Element elem) {
    _sCaptureElem = elem;
    impl.setCapture(elem);
  }

  /**
   * The height of the document's client area.
   *
   * @return the document's client height
   */
  static int getClientHeight() {
    return dart_html.window.innerHeight; ////dart_html.document.body.clientHeight;
  }

  /**
   * The width of the document's client area.
   *
   * @return the document's client width
   */
  static int getClientWidth() {
    return dart_html.window.innerWidth; //dart_html.document.body.clientWidth;
  }

  /**
   * The number of pixels that the document's content is scrolled from the left.
   *
   * <p>
   * If the document is in RTL mode, this method will return a negative value of
   * the number of pixels scrolled from the right.
   * </p>
   *
   * @return the document's left scroll position
   */
  static int getScrollLeft() {
    return dart_html.document.body.scrollLeft;
  }

  /**
   * The number of pixels that the document's content is scrolled from the top.
   *
   * @return the document's top scroll position
   */
  static int getScrollTop() {
    return dart_html.document.body.scrollTop;
  }

  /**
   * The width of the scrollable area of the document.
   *
   * @return the width of the document's scrollable area
   */
  static int getScrollWidth() {
    return dart_html.document.body.scrollWidth;
  }

  /**
   * The height of the scrollable area of the document.
   *
   * @return the height of the document's scrollable area
   */
  static int getScrollHeight() {
    return dart_html.document.body.scrollHeight;
  }

  /**
   * Clones an element.
   *
   * @param elem the element to be cloned
   * @param deep should children be cloned as well?
   */
  static dart_html.Element clone(dart_html.Element elem, bool deep) {
    return elem.clone(deep);
  }

  //******
  // Style
  //******
  
  static String getStyleProperty(dart_html.Element elem, String name) {
    return impl.getStyleProperty(elem, name);
  }
  
  static void setStyleProperty(dart_html.Element elem, String name, String value) {
    impl.setStyleProperty(elem, name, value);
  }
  
  static void cssSetOpacity(dart_html.Element elem, double value) {
    elem.style.opacity = value.toString();
  }
  
  static void cssClearOpacity(dart_html.Element elem) {
    elem.style.opacity = "";
  }
  
  static String cssFloatPropertyName() {
    return impl.cssFloatPropertyName;
  }
  
  //*******
  // Events
  //*******

  /**
   * Sinks a named event. Events will be fired to the nearest
   * {@link EventListener} specified on any of the element's parents.
   *
   * @param elem the element whose events are to be retrieved
   * @param eventTypeName name of the event to sink on this element
   */
  static void sinkBitlessEvent(dart_html.Element elem, String eventTypeName) {
    impl.sinkBitlessEvent(elem, eventTypeName);
  }

  /**
   * Sets the current set of events sunk by a given element. These events will
   * be fired to the nearest {@link EventListener} specified on any of the
   * element's parents.
   *
   * @param elem the element whose events are to be retrieved
   * @param eventBits a bitfield describing the events sunk on this element (its
   *          possible values are described in {@link Event})
   */
  static void sinkEvents(dart_html.Element elem, int eventBits) {
    impl.sinkEvents(elem, eventBits);
  }

  /**
   * Gets the current set of events sunk by a given element.
   *
   * @param elem the element whose events are to be retrieved
   * @return a bitfield describing the events sunk on this element (its possible
   *         values are described in {@link Event})
   */
  static int getEventsSunk(dart_html.Element elem) {
    return impl.getEventsSunk(elem);
  }

  /**
   * This method is called directly by native code when any event is fired.
   *
   * @param evt the handle to the event being fired.
   * @param elem the handle to the element that received the event.
   * @param listener the listener associated with the element that received the
   *          event.
   */
  static void dispatchEvent(dart_html.Event evt, dart_html.Element elem, EventListener listener) {
    // Preserve the current event in case we are in a reentrant event dispatch.
    dart_html.Event prevCurrentEvent = _currentEvent;
    _currentEvent = evt;

    _dispatchEventImpl(evt, elem, listener);

    _currentEvent = prevCurrentEvent;
  }

  static void _dispatchEventImpl(dart_html.Event evt, dart_html.Element elem, EventListener listener) {
    // If this element has capture...
    if (elem == _sCaptureElem) {
      // ... and it's losing capture, clear sCaptureElem.
      if (eventGetType(evt) == IEvent.ONLOSECAPTURE) {
        _sCaptureElem = null;
      }
    }

    // Pass the event to the listener.
    listener.onBrowserEvent(evt);
  }

  /**
   * Gets the element to which the mouse pointer was moved (only valid for
   * {@link Event#ONMOUSEOUT} and {@link Event#ONMOUSEOVER}).
   *
   * @param evt the event to be tested
   * @return the element to which the mouse pointer was moved
   */

  static dart_html.Element eventGetToElement(dart_html.Event evt) {
    return impl.eventGetToElement(evt);
  }

  /**
   * This method is called directly by native code when event preview is being
   * used.
   *
   * @param evt a handle to the event being previewed
   * @return <code>false</code> to cancel the event
   */
  static bool previewEvent(dart_html.Event evt) {
    // Fire a NativePreviewEvent to NativePreviewHandlers
    bool ret = IEvent.fireNativePreviewEvent(evt);

    // If the preview cancels the event, stop it from bubbling and performing
    // its default action. Check for a null evt to allow unit tests to run.
    if (!ret && evt != null) {
      evt.cancelBubble = true;// eventCancelBubble(evt, true);
      evt.preventDefault(); //eventPreventDefault(evt);
    }

    return ret;
  }

  /**
   * Gets the enumerated type of this event (as defined in {@link Event}).
   *
   * @param evt the event to be tested
   * @return the event's enumerated type, or -1 if not defined
   */
  static int eventGetType(dart_html.Event evt) {
    return impl.getEventTypeInt(evt);
  }

  /**
   * Creates an event.
   *
   * <p>
   * While this method may be used to create events directly, it is generally
   * preferable to use existing helper methods such as
   * {@link #createFocusEvent()}.
   * </p>
   *
   * <p>
   * Also, note that on Internet Explorer the 'canBubble' and 'cancelable'
   * arguments will be ignored (the event's behavior is inferred by the browser
   * based upon its type).
   * </p>
   *
   * @param type the type of event (e.g., BrowserEvents.FOCUS, BrowserEvents.LOAD, etc)
   * @param canBubble <code>true</code> if the event should bubble
   * @param cancelable <code>true</code> if the event should be cancelable
   * @return the event object
   */
  static dart_html.Event createHtmlEvent(String type, bool canBubble, bool cancelable) {
    return impl.createHtmlEvent(type, canBubble, cancelable);
  }

  /**
   * Creates a 'blur' event.
   */
  static dart_html.Event createBlurEvent() {
    return createHtmlEvent(BrowserEvents.BLUR, false, false);
  }

  /**
   * Creates a 'change' event.
   */
  static dart_html.Event createChangeEvent() {
    return createHtmlEvent(BrowserEvents.CHANGE, false, true);
  }

  /**
   * Creates a 'contextmenu' event.
   *
   * Note: Contextmenu events will not dispatch properly on Firefox 2 and
   * earlier.
   *
   * @return the event object
   */
  static dart_html.Event createContextMenuEvent() {
    return createHtmlEvent(BrowserEvents.CONTEXTMENU, true, true);
  }

  /**
   * Creates an 'error' event.
   *
   * @return the event object
   */
  static dart_html.Event createErrorEvent() {
    return createHtmlEvent(BrowserEvents.ERROR, false, false);
  }

  /**
   * Creates a 'focus' event.
   *
   * @return the event object
   */
  static dart_html.Event createFocusEvent() {
    return createHtmlEvent(BrowserEvents.FOCUS, false, false);
  }

  /**
   * Creates a 'load' event.
   *
   * @return the event object
   */
  static dart_html.Event createLoadEvent() {
    return createHtmlEvent(BrowserEvents.LOAD, false, false);
  }

  /**
   * Creates a 'scroll' event.
   *
   * Note: Contextmenu events will not dispatch properly on Firefox 2 and
   * earlier.
   *
   * @return the event object
   */
  static dart_html.Event createScrollEvent() {
    return createHtmlEvent(BrowserEvents.SCROLL, false, false);
  }

  /**
   * Gets the {@link EventListener} that will receive events for the given
   * element. Only one such listener may exist for a single element.
   *
   * @param elem the element whose listener is to be set
   * @return the element's event listener
   */
  static EventListener getEventListener(dart_html.Element elem) {
    return impl.getEventListener(elem);
  }
}
