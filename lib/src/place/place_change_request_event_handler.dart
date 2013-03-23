//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * Implemented by handlers of PlaceChangeRequestEvent.
 */
abstract class PlaceChangeRequestEventHandler extends EventHandler {
  /**
   * Called when a {@link PlaceChangeRequestEvent} is fired.
  *
   * @param event the {@link PlaceChangeRequestEvent}
   */
  void onPlaceChangeRequest(PlaceChangeRequestEvent event);
}
