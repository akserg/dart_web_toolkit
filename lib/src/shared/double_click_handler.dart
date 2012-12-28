//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DoubleClickEvent} events.
 */
class DoubleClickHandler extends DomEventHandler {
  
  DoubleClickHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a {@link DoubleClickEvent} is fired.
   * 
   * @param event the {@link DoubleClickEvent} that was fired
   */
  void onDoubleClick(DoubleClickEvent event) {
    onDomEventHandler(event);
  }
}
