//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a before selection event.
 *
 * @param <T> the type about to be selected
 */
class BeforeSelectionEvent<T> extends DwtEvent {

  /**
   * Handler type.
   */
  static EventType<BeforeSelectionHandler> TYPE = new EventType<BeforeSelectionHandler>();

  /**
   * Fires a before selection event on all registered handlers in the handler
   * manager. If no such handlers exist, this method will do nothing.
   *
   * @param <T> the item type
   * @param source the source of the handlers
   * @param item the item
   * @return the event so that the caller can check if it was canceled, or null
   *         if no handlers of this event type have been registered
   */
  static BeforeSelectionEvent fire(HasBeforeSelectionHandlers source, item) {
    // If no handlers exist, then type can be null.
    if (TYPE != null) {
      BeforeSelectionEvent event = new BeforeSelectionEvent();
      event.setItem(item);
      source.fireEvent(event);
      return event;
    }
    return null;
  }

  /**
   * Gets the type associated with this event.
   *
   * @return returns the handler type
   */
  static EventType<BeforeSelectionHandler> getType() {
    return TYPE;
  }

  T _item;

  bool _canceled = false;

  /**
   * Creates a new before selection event.
   */
  BeforeSelectionEvent() { }

  /**
   * Cancel the before selection event.
   *
   * Classes overriding this method should still call super.cancel().
   */
  void cancel() {
    _canceled = true;
  }

  // The instance knows its BeforeSelectionHandler is of type I, but the TYPE
  // field itself does not, so we have to do an unsafe cast here.
  EventType<BeforeSelectionHandler> getAssociatedType() {
    return TYPE;
  }

  /**
   * Gets the item.
   *
   * @return the item
   */
  T getItem() {
    return _item;
  }

  /**
   * Has the selection event already been canceled?
   *
   * @return is canceled
   */
  bool isCanceled() {
    return _canceled;
  }

  void dispatch(BeforeSelectionHandler<T> handler) {
    handler.onBeforeSelection(this);
  }

  /**
   * Sets the item.
   *
   * @param item the item
   */
  void setItem(T item) {
    this._item = item;
  }
}
