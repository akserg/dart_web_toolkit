//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * Event thrown when the user may go to a new place in the app, or tries to
 * leave it. Receivers can call {@link #setWarning(String)} request that the
 * user be prompted to confirm the change.
 */
class PlaceChangeRequestEvent extends DwtEvent {

  /**
   * A singleton instance of Type&lt;Handler&gt;.
   */
  static EventType<PlaceChangeRequestEventHandler> TYPE = new EventType<PlaceChangeRequestEventHandler>();

  String _warning;

  final Place newPlace;

  /**
   * Constructs a PlaceChangeRequestEvent for the given {@link Place}.
   *
   * @param newPlace a {@link Place} instance
   */
  PlaceChangeRequestEvent(this.newPlace);

  EventType<PlaceChangeRequestEventHandler> getAssociatedType() {
    return TYPE;
  }

  /**
   * Returns the place we may navigate to, or null on window close.
   *
   * @return a {@link Place} instance
   */
  Place getNewPlace() {
    return newPlace;
  }

  /**
   * Returns the warning message to show the user before allowing the place
   * change, or null if none has been set.
   *
   * @return the warning message as a String
   * @see #setWarning(String)
   */
  String getWarning() {
    return _warning;
  }

  /**
   * Set a message to warn the user that it might be unwise to navigate away
   * from the current place, e.g. due to unsaved changes. If the user clicks
   * okay to that message, navigation will be canceled.
   * <p>
   * Calling with a null warning is the same as not calling the method at all --
   * the user will not be prompted.
   * <p>
   * Only the first non-null call to setWarning has any effect. That is, once
   * the warning message has been set it cannot be cleared.
   *
   * @param warning the warning message as a String
   * @see #getWarning()
   */
  void setWarning(String warning) {
    if (this._warning == null) {
      this._warning = warning;
    }
  }

  void dispatch(PlaceChangeRequestEventHandler handler) {
    handler.onPlaceChangeRequest(this);
  }
}