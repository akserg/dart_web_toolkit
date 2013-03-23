//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * Event thrown when the user has reached a new location in the app.
 */
class PlaceChangeEvent extends DwtEvent {

  /**
   * A singleton instance of Type.
   */
  
  static EventType<PlaceChangeEventHandler> TYPE = new EventType<PlaceChangeEventHandler>();

  Place _newPlace;

  /**
   * Constructs a PlaceChangeEvent for the given {@link Place}.
   *
   * @param _newPlace a {@link Place} instance
   */
  PlaceChangeEvent(this._newPlace);

  EventType<PlaceChangeEventHandler> getAssociatedType() {
    return TYPE;
  }

  /**
   * Return the new {@link Place}.
   *
   * @return a {@link Place} instance
   */
  Place getNewPlace() {
    return _newPlace;
  }

  void dispatch(PlaceChangeEventHandler handler) {
    handler.onPlaceChange(this);
  }
}