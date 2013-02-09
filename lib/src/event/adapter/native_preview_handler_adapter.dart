//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link NativePreviewEvent} events.
 */
class NativePreviewHandlerAdapter extends EventHandlerAdapter implements NativePreviewHandler {

  NativePreviewHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when NativePreviewEvent is fired.
   *
   * @param event the {@link NativePreviewEvent} that was fired
   */
  void onPreviewNativeEvent(NativePreviewEvent event) {
    callback(event);
  }
}
