//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Implemented by objects that handle {@link AttachEvent}.
 */
class ValueChangeHandler<T> extends DwtEventHandler {
  
  ValueChangeHandler(OnDwtEventHandler onDwtEventHandler) : super(onDwtEventHandler);
  
  /**
   * Called when {@link ValueChangeEvent} is fired.
   * 
   * @param event the {@link ValueChangeEvent} that was fired
   */
  void onValueChange(ValueChangeEvent<T> event) {
    onDwtEventHandler(event);
  }
}
