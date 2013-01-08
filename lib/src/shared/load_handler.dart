//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link LoadEvent} events.
 */
class LoadHandler extends DomEventHandler {

  LoadHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when LoadEvent is fired.
   *
   * @param event the {@link LoadEvent} that was fired
   */
  void onLoad(LoadEvent event) {
    onDomEventHandler(event);
  }
}
