//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DragLeaveEvent} events.
 */
class DragLeaveHandler extends DomEventHandler {
  
  DragLeaveHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a {@link DragLeaveEvent} is fired.
   * 
   * @param event the {@link DragLeaveEvent} that was fired
   */
  void onDragLeave(DragLeaveEvent event) {
    onDomEventHandler(event);
  }
}
