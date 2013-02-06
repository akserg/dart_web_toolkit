//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Implemented by objects that handle {@link OpenEvent}.
 */
class OpenHandlerAdapter<T> extends EventHandlerAdapter implements OpenHandler<T> {

  OpenHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when {@link ValueChangeEvent} is fired.
   *
   * @param event the {@link ValueChangeEvent} that was fired
   */
  void onOpen(OpenEvent<T> event) {
    callback(event);
  }
}
