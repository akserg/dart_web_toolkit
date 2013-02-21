//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link ScrollEvent} events.
 */
class SelectionHandlerAdapter extends EventHandlerAdapter implements SelectionHandler {

  SelectionHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when {@link SelectionEvent} is fired.
   *
   * @param event the {@link SelectionEvent} that was fired
   */
  void onSelection(SelectionEvent event) {
    callback(event);
  }
}
