//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Activity library.
 * Classes used to implement app navigation.
 */
part of dart_web_toolkit_activity;

/**
 * Implemented by objects that control a piece of user interface, with a life
 * cycle managed by an {@link ActivityManager}, in response to
 * {@link com.google.gwt.place.shared.PlaceChangeEvent} events as the user
 * navigates through the app.
 */
abstract class Activity {
  /**
   * Called when the user is trying to navigate away from this activity.
   *
   * @return A message to display to the user, e.g. to warn of unsaved work, or
   *         null to say nothing
   */
  String mayStop();

  /**
   * Called when {@link #start} has not yet replied to its callback, but the
   * user has lost interest.
   */
  void onCancel();

  /**
   * Called when the Activity's widget has been removed from view. All event
   * handlers it registered will have been removed before this method is called.
   */
  void onStop();

  /**
   * Called when the Activity should ready its widget for the user. When the
   * widget is ready (typically after an RPC response has been received),
   * receiver should present it by calling
   * {@link AcceptsOneWidget#setWidget} on the given panel.
   * <p>
   * Any handlers attached to the provided event bus will be de-registered when
   * the activity is stopped, so activities will rarely need to hold on to the
   * {@link com.google.gwt.event.shared.HandlerRegistration HandlerRegistration}
   * instances returned by {@link EventBus#addHandler}.
   *
   * @param panel the panel to display this activity's widget when it is ready
   * @param eventBus the event bus
   */
  void start(AcceptsOneWidget panel, EventBus eventBus);
}