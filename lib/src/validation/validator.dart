//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_validation;

typedef Validator OnSuccess(ui.Widget widget);
typedef Validator OnError(ui.Widget widget, Exception ex);

abstract class Validator<W> {
  
  final W widget;
  
  OnSuccess onSuccess;
  
  OnError onError;
  
  Validator(this.widget, {OnSuccess this.onSuccess:null, OnError this.onError:null}) {
    _addAllHandlers();
  }
 
  void _addAllHandlers() {
    if (widget is event.HasClickHandlers) {
      (widget as event.HasClickHandlers).addClickHandler(new event.ClickHandlerAdapter((event.IEvent evt){ validate(); }));
    }
//  if (widget is event.HasDoubleClickHandlers) {
//    (widget as event.HasDoubleClickHandlers).addDoubleClickHandler(new event.DoubleClickHandlerAdapter((event.IEvent evt){ validate(); }));
//  }
    if (widget is event.HasAllFocusHandlers) {
      (widget as event.HasAllFocusHandlers).addFocusHandler(new event.FocusHandlerAdapter((event.IEvent evt){ validate(); }));
      (widget as event.HasAllFocusHandlers).addBlurHandler(new event.BlurHandlerAdapter((event.IEvent evt){ validate(); }));
    }
//  if (widget is event.HasAllMouseHandlers) {
//    (widget as event.HasAllMouseHandlers).addMouseDownHandler(new event.MouseDownHandlerAdapter((event.IEvent evt){ validate(); }));
//    (widget as event.HasAllMouseHandlers).addMouseUpHandler(new event.MouseUpHandlerAdapter((event.IEvent evt){ validate(); }));
//    (widget as event.HasAllMouseHandlers).addMouseOutHandler(new event.MouseOutHandlerAdapter((event.IEvent evt){ validate(); }));
//    (widget as event.HasAllMouseHandlers).addMouseOverHandler(new event.MouseOverHandlerAdapter((event.IEvent evt){ validate(); }));
//    (widget as event.HasAllMouseHandlers).addMouseMoveHandler(new event.MouseMoveHandlerAdapter((event.IEvent evt){ validate(); }));
//    (widget as event.HasAllMouseHandlers).addMouseWheelHandler(new event.MouseWheelHandlerAdapter((event.IEvent evt){ validate(); }));
//  }
    if (widget is event.HasAllKeyHandlers) {
    (widget as event.HasAllKeyHandlers).addKeyUpHandler(new event.KeyUpHandlerAdapter((event.IEvent evt){ validate(); }));
//    (widget as event.HasAllKeyHandlers).addKeyDownHandler(new event.KeyDownHandlerAdapter((event.IEvent evt){ validate(); }));
      (widget as event.HasAllKeyHandlers).addKeyPressHandler(new event.KeyPressHandlerAdapter((event.IEvent evt){ validate(); }));
    }
    // HasAllDragAndDropHandlers, HasAllGestureHandlers, HasAllTouchHandlers
    if (widget is event.HasValueChangeHandlers) {
      (widget as event.HasValueChangeHandlers).addValueChangeHandler(new event.ValueChangeHandlerAdapter((event.IEvent evt){ validate(); }));
    }
    //
//  if (widget is event.HasLoadHandlers) {
//    (widget as event.HasLoadHandlers).addLoadHandler(new event.LoadHandlerAdapter((event.IEvent evt){ validate(); }));
//  }
  }
  
  Validator validate();
}