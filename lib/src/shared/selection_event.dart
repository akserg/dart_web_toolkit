//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a selection event.
 * 
 * @param <T> the type being selected
 */
class SelectionEvent<T> extends DwtEvent {
  
  /**
   * Handler type.
   */
  static EventType<SelectionHandler> TYPE = new EventType<SelectionHandler>();

  /**
   * Fires a selection event on all registered handlers in the handler
   * manager.If no such handlers exist, this method will do nothing.
   * 
   * @param <T> the selected item type
   * @param source the source of the handlers
   * @param selectedItem the selected item
   */
  static void fire(HasSelectionHandlers source, selectedItem) {
    if (TYPE != null) {
      SelectionEvent event = new SelectionEvent(selectedItem);
      source.fireEvent(event);
    }
  }

  /**
   * Gets the type associated with this event.
   * 
   * @return returns the handler type
   */
  static EventType<SelectionHandler> getType() {
    return TYPE;
  }

  T _selectedItem;

  /**
   * Creates a new selection event.
   * 
   * @param selectedItem selected item
   */
  SelectionEvent(T selectedItem) {
    this._selectedItem = selectedItem;
  }

  // The instance knows its BeforeSelectionHandler is of type I, but the TYPE
  // field itself does not, so we have to do an unsafe cast here.
  EventType<SelectionHandler<T>> getAssociatedType() {
    return TYPE;
  }

  /**
   * Gets the selected item.
   * 
   * @return the selected item
   */
  T getSelectedItem() {
    return _selectedItem;
  }

  void dispatch(SelectionHandler<T> handler) {
    handler.onSelection(this);
  }
}
