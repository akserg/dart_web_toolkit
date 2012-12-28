//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DragEvent} events.
 */
class DragHandler extends DomEventHandler {
  
  DragHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a {@link DragEvent} is fired.
   * 
   * @param event the {@link DragEvent} that was fired
   */
  void onDrag(DragEvent event) {
    onDomEventHandler(event);
  }
}
