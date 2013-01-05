//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple panel that makes its contents focusable, and adds the ability to
 * catch mouse and keyboard events.
 */
class FocusPanel extends SimplePanel implements HasFocus,
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
  
//  HandlerRegistration addBlurHandler(BlurHandler handler) {
//    return addDomHandler(handler, BlurEvent.getType());
//  }
//  
//  HandlerRegistration addDoubleClickHandler(DoubleClickHandler handler) {
//    return addDomHandler(handler, DoubleClickEvent.getType());
//  }

  //******************************
  // Drag and Drop events handlers
  //******************************
  
//  HandlerRegistration addDragEndHandler(DragEndHandler handler) {
//    return addBitlessDomHandler(handler, DragEndEvent.getType());
//  }
//
//  HandlerRegistration addDragEnterHandler(DragEnterHandler handler) {
//    return addBitlessDomHandler(handler, DragEnterEvent.getType());
//  }
//
//  HandlerRegistration addDragHandler(DragHandler handler) {
//    return addBitlessDomHandler(handler, DragEvent.getType());
//  }
//
//  HandlerRegistration addDragLeaveHandler(DragLeaveHandler handler) {
//    return addBitlessDomHandler(handler, DragLeaveEvent.getType());
//  }
//
//  HandlerRegistration addDragOverHandler(DragOverHandler handler) {
//    return addBitlessDomHandler(handler, DragOverEvent.getType());
//  }
//
//  HandlerRegistration addDragStartHandler(DragStartHandler handler) {
//    return addBitlessDomHandler(handler, DragStartEvent.getType());
//  }
//
//  HandlerRegistration addDropHandler(DropHandler handler) {
//    return addBitlessDomHandler(handler, DropEvent.getType());
//  }
//
//  HandlerRegistration addFocusHandler(FocusHandler handler) {
//    return addDomHandler(handler, FocusEvent.getType());
//  }
  
  //************************
  // Gesture events handlers
  //************************
  
//  HandlerRegistration addGestureChangeHandler(GestureChangeHandler handler) {
//    return addDomHandler(handler, GestureChangeEvent.getType());
//  }
//
//  HandlerRegistration addGestureEndHandler(GestureEndHandler handler) {
//    return addDomHandler(handler, GestureEndEvent.getType());
//  }
//
//  HandlerRegistration addGestureStartHandler(GestureStartHandler handler) {
//    return addDomHandler(handler, GestureStartEvent.getType());
//  }
//  
  //*************************
  // Keyboard events handlers
  //*************************
  
//  HandlerRegistration addKeyDownHandler(KeyDownHandler handler) {
//    return addDomHandler(handler, KeyDownEvent.getType());
//  }
//
//  HandlerRegistration addKeyPressHandler(KeyPressHandler handler) {
//    return addDomHandler(handler, KeyPressEvent.getType());
//  }
//
//  HandlerRegistration addKeyUpHandler(KeyUpHandler handler) {
//    return addDomHandler(handler, KeyUpEvent.getType());
//  }

  //**********************
  // Mouse events handlers
  //**********************
  
//  HandlerRegistration addMouseDownHandler(MouseDownHandler handler) {
//    return addDomHandler(handler, MouseDownEvent.getType());
//  }
//  
//  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler) {
//    return addDomHandler(handler, MouseMoveEvent.getType());
//  }
//
//  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
//    return addDomHandler(handler, MouseOutEvent.getType());
//  }
//
//  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
//    return addDomHandler(handler, MouseOverEvent.getType());
//  }
//
//  HandlerRegistration addMouseUpHandler(MouseUpHandler handler) {
//    return addDomHandler(handler, MouseUpEvent.getType());
//  }
//
//  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler) {
//    return addDomHandler(handler, MouseWheelEvent.getType());
//  }
  
  //**********************
  // Touch events handlers
  //**********************
  
//  HandlerRegistration addTouchCancelHandler(TouchCancelHandler handler) {
//    return addDomHandler(handler, TouchCancelEvent.getType());
//  }
//
//  HandlerRegistration addTouchEndHandler(TouchEndHandler handler) {
//    return addDomHandler(handler, TouchEndEvent.getType());
//  }
//
//  HandlerRegistration addTouchMoveHandler(TouchMoveHandler handler) {
//    return addDomHandler(handler, TouchMoveEvent.getType());
//  }
//
//  HandlerRegistration addTouchStartHandler(TouchStartHandler handler) {
//    return addDomHandler(handler, TouchStartEvent.getType());
//  }
  
  
//  void setAccessKey(char key) {
//    FocusHelper.getFocusHelper().setAccessKey(getElement(), key);
//  }

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
