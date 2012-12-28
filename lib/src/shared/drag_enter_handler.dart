//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DragEnterEvent} events.
 */
class DragEnterHandler extends DomEventHandler {
  
  DragEnterHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a {@link DragEnterEvent} is fired.
   * 
   * @param event the {@link DragEnterEvent} that was fired
   */
  void onDragEnter(DragEnterEvent event) {
    onDomEventHandler(event);
  }
}
