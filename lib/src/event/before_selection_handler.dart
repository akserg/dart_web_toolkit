//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Handler interface for {@link BeforeSelectionEvent} events.
 *
 * @param <T> the type about to be selected
 */
abstract class BeforeSelectionHandler<T> extends EventHandler {

  /**
   * Called when {@link BeforeSelectionEvent} is fired.
   *
   * @param event the {@link BeforeSelectionEvent} that was fired
   */
  void onBeforeSelection(BeforeSelectionEvent<T> event);
}
