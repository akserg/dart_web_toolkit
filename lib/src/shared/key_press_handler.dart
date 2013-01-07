//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link KeyPressEvent} events.
 */
class KeyPressHandler extends DomEventHandler {

  KeyPressHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when KeyPressEvent is fired.
   *
   * @param event the {@link KeyPressEvent} that was fired
   */
  void onKeyPress(KeyPressEvent event) {
    onDomEventHandler(event);
  }
}
