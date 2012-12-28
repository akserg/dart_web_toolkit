//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DropEvent} events.
 */
class DropHandler extends DomEventHandler {
 
  DropHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a {@link DropEvent} is fired.
   * 
   * @param event the {@link DropEvent} that was fired
   */
  void onDrop(DropEvent event) {
    onDomEventHandler(event);
  }
  
}
