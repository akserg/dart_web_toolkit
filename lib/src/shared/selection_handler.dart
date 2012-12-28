//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Handler interface for {@link SelectionEvent} events.
 * 
 * @param <T> the type being selected
 */
abstract class SelectionHandler<T> extends EventHandler {
  /**
   * Called when {@link SelectionEvent} is fired.
   * 
   * @param event the {@link SelectionEvent} that was fired
   */
  void onSelection(SelectionEvent<T> event);
}
