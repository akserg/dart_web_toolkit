//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler for {@link ChangeEvent} events.
 */
class ChangeHandlerAdapter extends EventHandlerAdapter implements ChangeHandler {

  ChangeHandlerAdapter(EventHandlerAdapterCallback callback) : super(callback);

  /**
   * Called when a change event is fired.
   *
   * @param event the {@link ChangeEvent} that was fired
   */
  void onChange(ChangeEvent event) {
    callback(event);
  }
}
