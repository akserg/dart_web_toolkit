//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DragStartEvent} events.
 */
class DragStartHandler extends DomEventHandler {
 
  DragStartHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a {@link DragStartEvent} is fired.
   * 
   * @param event the {@link DragStartEvent} that was fired
   */
  void onDragStart(DragStartEvent event) {
    onDomEventHandler(event);
  }
}
