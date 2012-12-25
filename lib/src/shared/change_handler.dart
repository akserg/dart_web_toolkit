//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler for {@link ChangeEvent} events.
 */
class ChangeHandler extends DomEventHandler {

  ChangeHandler(OnDomEventHandler onDomEventHandler) : super(onDomEventHandler);

  /**
   * Called when a change event is fired.
   *
   * @param event the {@link ChangeEvent} that was fired
   */
  void onChange(ChangeEvent event) {
    onDomEventHandler(event);
  }
}
