//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;


/**
 * Implemented by handlers of PlaceChangeEvent.
 */
abstract class PlaceChangeEventHandler extends EventHandler {
  /**
   * Called when a {@link PlaceChangeEvent} is fired.
   *
   * @param event the {@link PlaceChangeEvent}
   */
  void onPlaceChange(PlaceChangeEvent event);
}