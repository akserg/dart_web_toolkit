//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link DropEvent} events.
 */
class DropHandlerAdapter extends EventHandlerAdapter implements DropHandler {

  DropHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a {@link DropEvent} is fired.
   *
   * @param event the {@link DropEvent} that was fired
   */
  void onDrop(DropEvent event) {
    callback(event);
  }

}
