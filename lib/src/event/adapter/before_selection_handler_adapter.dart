//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link BlurEvent} events.
 */
class BeforeSelectionHandlerAdapter extends EventHandlerAdapter implements BeforeSelectionHandler {

  BeforeSelectionHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when {@link BeforeSelectionEvent} is fired.
   *
   * @param event the {@link BeforeSelectionEvent} that was fired
   */
  void onBeforeSelection(BeforeSelectionEvent event) {
    callback(event);
  }
}
