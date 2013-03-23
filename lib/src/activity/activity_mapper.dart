//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Activity library.
 * Classes used to implement app navigation.
 */
part of dart_web_toolkit_activity;

/**
 * Finds the activity to run for a given {@link Place}, used to configure
 * an {@link ActivityManager}.
 */
abstract class ActivityMapper {
  /**
   * Returns the activity to run for the given {@link Place}, or null.
   *
   * @param place a Place object
   */
  Activity getActivity(Place place);
}