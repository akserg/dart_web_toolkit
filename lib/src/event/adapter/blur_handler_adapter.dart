//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link BlurEvent} events.
 */
class BlurHandlerAdapter extends EventHandlerAdapter implements BlurHandler {

  BlurHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when BlurEvent is fired.
   *
   * @param event the {@link BlurEvent} that was fired
   */
  void onBlur(BlurEvent event) {
    callback(event);
  }
}
