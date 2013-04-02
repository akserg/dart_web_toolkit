//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link AttachEvent} events.
 */
class AttachEventHandlerAdapter extends EventHandlerAdapter implements AttachEventHandler {

  AttachEventHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when {@link AttachEvent} is fired.
   *
   * @param event the {@link AttachEvent} that was fired
   */
  void onAttachOrDetach(AttachEvent event) {
    callback(event);
  }
}


