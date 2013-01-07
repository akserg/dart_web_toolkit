//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract base class for most widgets that can receive focus.
 */
abstract class FocusWidget extends Widget implements
    HasClickHandlers, HasDoubleClickHandlers, HasFocus, HasEnabled,
    HasAllDragAndDropHandlers, HasAllFocusHandlers, HasAllGestureHandlers,
    HasAllKeyHandlers, HasAllMouseHandlers, HasAllTouchHandlers {

  static final FocusImpl impl = FocusImpl.getFocusImplForWidget();

  /**
   * Creates a new focus widget that wraps the specified browser [element].
   */
  FocusWidget([dart_html.Element element = null]) {
    if (?element) {
      setElement(element);
    }
  }

  //****************************
  // Impementation of HasEnabled
  //****************************
  /**
   * Gets whether this widget is enabled.
   *
   * @return <code>true</code> if the widget is enabled
   */
  bool get enabled => !Dom.getElementPropertyBoolean(getElement(), "disabled");

  /**
   * Sets whether this widget is enabled.
   *
   * @param enabled <code>true</code> to enable the widget, <code>false</code>
   *          to disable it
   */
  void set enabled(bool value) {
    Dom.setElementPropertyBoolean(getElement(), "disabled", !value);
  }

  //***************************
  // Implementation of HasFocus
  //***************************
  /**
   * Gets the widget's position in the tab index.
   *
   * @return the widget's tab index
   */
  int get tabIndex => impl.getTabIndex(getElement()); //FocusHelper.getFocusHelper().getTabIndex(getElement());

  /**
   * Sets the widget's position in the tab index. If more than one widget has
   * the same tab index, each such widget will receive focus in an arbitrary
   * order. Setting the tab index to <code>-1</code> will cause this widget to
   * be removed from the tab order.
   *
   * @param index the widget's tab index
   */
  void set tabIndex(int index) {
    impl.setTabIndex(getElement(), index); //FocusHelper.getFocusHelper().setTabIndex(getElement(), index);
  }

  /**
   * Explicitly focus/unfocus this widget. Only one widget can have focus at a
   * time, and the widget that does will receive all keyboard events.
   *
   * @param focused whether this widget should take focus or release it
   */
  void set focus(bool focused) {
    if (focused) {
      impl.focus(getElement()); //FocusHelper.getFocusHelper().focus(getElement());
    } else {
      impl.blur(getElement()); //FocusHelper.getFocusHelper().blur(getElement());
    }
  }

  //**********************************
  // Impementation of HasClickHandlers
  //**********************************

  HandlerRegistration addBlurHandler(BlurHandler handler) {
    return addDomHandler(handler, BlurEvent.TYPE);
  }

  /**
   * Adds a {@link ClickEvent} handler.
   *
   * @param handler the click handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addDomHandler(handler, ClickEvent.TYPE);
  }

  HandlerRegistration addDoubleClickHandler(DoubleClickHandler handler) {
    return addDomHandler(handler, DoubleClickEvent.TYPE);
  }

  //******************************
  // Drag and Drop events handlers
  //******************************

  HandlerRegistration addDragEndHandler(DragEndHandler handler) {
    return addBitlessDomHandler(handler, DragEndEvent.TYPE);
  }

  HandlerRegistration addDragEnterHandler(DragEnterHandler handler) {
    return addBitlessDomHandler(handler, DragEnterEvent.TYPE);
  }

  HandlerRegistration addDragHandler(DragHandler handler) {
    return addBitlessDomHandler(handler, DragEvent.TYPE);
  }

  HandlerRegistration addDragLeaveHandler(DragLeaveHandler handler) {
    return addBitlessDomHandler(handler, DragLeaveEvent.TYPE);
  }

  HandlerRegistration addDragOverHandler(DragOverHandler handler) {
    return addBitlessDomHandler(handler, DragOverEvent.TYPE);
  }

  HandlerRegistration addDragStartHandler(DragStartHandler handler) {
    return addBitlessDomHandler(handler, DragStartEvent.TYPE);
  }

  HandlerRegistration addDropHandler(DropHandler handler) {
    return addBitlessDomHandler(handler, DropEvent.TYPE);
  }

  HandlerRegistration addFocusHandler(FocusHandler handler) {
    return addDomHandler(handler, FocusEvent.TYPE);
  }

  //************************
  // Gesture events handlers
  //************************

  HandlerRegistration addGestureChangeHandler(GestureChangeHandler handler) {
    return addDomHandler(handler, GestureChangeEvent.TYPE);
  }

  HandlerRegistration addGestureEndHandler(GestureEndHandler handler) {
    return addDomHandler(handler, GestureEndEvent.TYPE);
  }

  HandlerRegistration addGestureStartHandler(GestureStartHandler handler) {
    return addDomHandler(handler, GestureStartEvent.TYPE);
  }


  //*************************
  // Keyboard events handlers
  //*************************

  HandlerRegistration addKeyDownHandler(KeyDownHandler handler) {
    return addDomHandler(handler, KeyDownEvent.TYPE);
  }

  HandlerRegistration addKeyPressHandler(KeyPressHandler handler) {
    return addDomHandler(handler, KeyPressEvent.TYPE);
  }

  HandlerRegistration addKeyUpHandler(KeyUpHandler handler) {
    return addDomHandler(handler, KeyUpEvent.TYPE);
  }

  //**********************
  // Mouse events handlers
  //**********************

  HandlerRegistration addMouseDownHandler(MouseDownHandler handler) {
    return addDomHandler(handler, MouseDownEvent.TYPE);
  }

  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler) {
    return addDomHandler(handler, MouseMoveEvent.TYPE);
  }

  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
    return addDomHandler(handler, MouseOutEvent.TYPE);
  }

  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
    return addDomHandler(handler, MouseOverEvent.TYPE);
  }

  HandlerRegistration addMouseUpHandler(MouseUpHandler handler) {
    return addDomHandler(handler, MouseUpEvent.TYPE);
  }

  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler) {
    return addDomHandler(handler, MouseWheelEvent.TYPE);
  }

  //**********************
  // Touch events handlers
  //**********************

  HandlerRegistration addTouchCancelHandler(TouchCancelHandler handler) {
    return addDomHandler(handler, TouchCancelEvent.TYPE);
  }

  HandlerRegistration addTouchEndHandler(TouchEndHandler handler) {
    return addDomHandler(handler, TouchEndEvent.TYPE);
  }

  HandlerRegistration addTouchMoveHandler(TouchMoveHandler handler) {
    return addDomHandler(handler, TouchMoveEvent.TYPE);
  }

  HandlerRegistration addTouchStartHandler(TouchStartHandler handler) {
    return addDomHandler(handler, TouchStartEvent.TYPE);
  }

}
