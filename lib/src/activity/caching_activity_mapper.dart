//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Activity library.
 * Classes used to implement app navigation.
 */
part of dart_web_toolkit_activity;

/**
 * Wraps another {@link ActivityMapper} and caches the last activity it
 * returned, to be re-used if we see the same place twice.
 */
class CachingActivityMapper implements ActivityMapper {

  final ActivityMapper wrapped;

  Place lastPlace;
  Activity lastActivity;

  /**
   * Constructs a CachingActivityMapper object.
   *
   * @param wrapped an ActivityMapper object
   */
  CachingActivityMapper(this.wrapped);

  Activity getActivity(Place place) {
    if (place != lastPlace) {
      lastPlace = place;
      lastActivity = wrapped.getActivity(place);
    }

    return lastActivity;
  }
}