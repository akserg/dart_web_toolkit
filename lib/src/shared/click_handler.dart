//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler for {@link ClickEvent} events.
 */
class ClickHandler extends DomEventHandler {

  ClickHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);
  
  /**
   * Called when a native click event is fired.
   *
   * @param event the {@link ClickEvent} that was fired
   */
  void onClick(ClickEvent event) {
    onDomEventHandler(event);
  }
}
