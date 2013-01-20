//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link NativePreviewEvent} events.
 */
abstract class NativePreviewHandler extends EventHandler {
  /**
   * Called when {@link NativePreviewEvent} is fired.
   * 
   * @param event the {@link NativePreviewEvent} that was fired
   */
  void onPreviewNativeEvent(NativePreviewEvent event);
}
