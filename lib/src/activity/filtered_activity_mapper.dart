//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Activity library.
 * Classes used to implement app navigation.
 */
part of dart_web_toolkit_activity;

/**
 * Wraps an activity mapper and applies a filter to the place objects that it
 * sees.
 */
class FilteredActivityMapper implements ActivityMapper {

  final ActivityMapperFilter filter;
  final ActivityMapper wrapped;

  /**
   * Constructs a FilteredActivityMapper object.
   *
   * @param filter a Filter object
   * @param wrapped an ActivityMapper object
   */
  FilteredActivityMapper(this.filter, this.wrapped);

  Activity getActivity(Place place) {
    return wrapped.getActivity(filter.filter(place));
  }
}

/**
 * Implemented by objects that want to interpret one place as another.
 */
abstract class ActivityMapperFilter {
  /**
   * Returns the filtered interpretation of the given {@link Place}.
  *
   * @param place the input {@link Place}.
   * @return the output {@link Place}.
   */
  Place filter(Place place);
}