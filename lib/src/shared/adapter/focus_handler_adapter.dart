//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link FocusEvent} events.
 */
class FocusHandlerAdapter extends EventHandlerAdapter implements FocusHandler {

  FocusHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when FocusEvent is fired.
   *
   * @param event the {@link FocusEvent} that was fired
   */
  void onFocus(FocusEvent event) {
    callback(event);
  }
}
