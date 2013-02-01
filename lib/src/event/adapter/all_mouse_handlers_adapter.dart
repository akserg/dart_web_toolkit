//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link MouseDownEvent} events.
 */
class AllMouseHandlersAdapter extends EventHandlerAdapter implements 
    MouseDownHandler, MouseUpHandler, MouseOutHandler, MouseOverHandler, 
    MouseMoveHandler, MouseWheelHandler {

  AllMouseHandlersAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when MouseDown is fired.
   *
   * @param event the {@link MouseDownEvent} that was fired
   */
  void onMouseDown(MouseDownEvent event) {
    callback(event);
  }

  /**
   * Called when MouseMoveEvent is fired.
   *
   * @param event the {@link MouseMoveEvent} that was fired
   */
  void onMouseMove(MouseMoveEvent event) {
    callback(event);
  }
  
  /**
   * Called when MouseOutEvent is fired.
   *
   * @param event the {@link MouseOutEvent} that was fired
   */
  void onMouseOut(MouseOutEvent event) {
    callback(event);
  }
  
  /**
   * Called when MouseOverEvent is fired.
   *
   * @param event the {@link MouseOverEvent} that was fired
   */
  void onMouseOver(MouseOverEvent event) {
    callback(event);
  }
  
  /**
   * Called when MouseUpEvent is fired.
   *
   * @param event the {@link MouseUpEvent} that was fired
   */
  void onMouseUp(MouseUpEvent event) {
    callback(event);
  }
  
  /**
   * Called when MouseWheelEvent is fired.
   *
   * @param event the {@link MouseWheelEvent} that was fired
   */
  void onMouseWheel(MouseWheelEvent event) {
    callback(event);
  }
}

