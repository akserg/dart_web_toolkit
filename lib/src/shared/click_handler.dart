//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

typedef void OnClick(ClickEvent event);

/**
 * Handler for {@link ClickEvent} events.
 */
class ClickHandler extends DomEventHandler {

  /**
   * Called when a native click event is fired.
   *
   * @param event the {@link ClickEvent} that was fired
   */
 // void onClick(ClickEvent event);

  ClickHandler(OnClick onClick) : super(onClick);
}
