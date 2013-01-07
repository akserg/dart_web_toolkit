//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link KeyUpEvent} events.
 */
class KeyUpHandler extends DomEventHandler {

  KeyUpHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when KeyUpEvent is fired.
   *
   * @param event the {@link KeyUpEvent} that was fired
   */
  void onKeyUp(KeyUpEvent event) {
    onDomEventHandler(event);
  }
}
