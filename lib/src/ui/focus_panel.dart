//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple panel that makes its contents focusable, and adds the ability to
 * catch mouse and keyboard events.
 */
class FocusPanel extends SimplePanel implements Focusable,
  HasAllDragAndDropHandlers, HasAllMouseHandlers, HasClickHandlers,
  HasDoubleClickHandlers, HasAllKeyHandlers, HasAllFocusHandlers,
  HasAllGestureHandlers, HasAllTouchHandlers {

  static FocusImpl impl = FocusImpl.getFocusImplForPanel();

  /**
   * Creates an empty panel that uses the specified browser element for its
   * contents.
   *
   * @param elem the browser element to use
   */
  FocusPanel.fromElement() : super.fromElement(impl.createFocusable());

  /**
   * Creates an empty panel that uses a DIV for its contents or
   * create a panel with the specified child widget.
   */
  FocusPanel([Widget child = null]) : super(child);

  //*********
  // Handlers
  //*********

  //***********************************
  // Implementation of HasClickHandlers
  //***********************************

  /**
   * Adds a {@link ClickEvent} handler.
   *
   * @param handler the click handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addDomHandler(handler, ClickEvent.TYPE);
  }

  HandlerRegistration addBlurHandler(BlurHandler handler) {
    return addDomHandler(handler, BlurEvent.TYPE);
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


  /**
   * Sets the widget's 'access key'. This key is used (in conjunction with a
   * browser-specific modifier key) to automatically focus the widget.
   * 
   * @param key the widget's access key
   */
  void set accessKey(int key) {
    FocusPanel.impl.setAccessKey(getElement(), key);
  }

  //***************************
  // Implementation of HasFocus
  //***************************

  /**
   * Gets the widget's position in the tab index.
   *
   * @return the widget's tab index
   */
  int get tabIndex => impl.getTabIndex(getElement());

  /**
   * Sets the widget's position in the tab index. If more than one widget has
   * the same tab index, each such widget will receive focus in an arbitrary
   * order. Setting the tab index to <code>-1</code> will cause this widget to
   * be removed from the tab order.
   *
   * @param index the widget's tab index
   */
  void set tabIndex(int index) {
    impl.setTabIndex(getElement(), index);
  }

  /**
   * Explicitly focus/unfocus this widget. Only one widget can have focus at a
   * time, and the widget that does will receive all keyboard events.
   *
   * @param focused whether this widget should take focus or release it
   */
  void set focus(bool focused) {
    if (focused) {
      impl.focus(getElement());
    } else {
      impl.blur(getElement());
    }
  }
}
