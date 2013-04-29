//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Root of all GWT widget and dom events sourced by a {@link HandlerManager}.
 * All GWT events are considered dead and should no longer be accessed once the
 * {@link HandlerManager} which originally fired the event finishes with it.
 * That is, don't hold on to event objects outside of your handler methods.
 *
 * There is no need for an application's custom event types to extend GwtEvent.
 * Prefer {@link Event} instead.
 *
 * @param <H> handler type
 */
abstract class DwtEvent<H> extends IEvent<H> {

  bool _dead = false;

  Object getSource() {
    assertLive();
    return super.getSource();
  }

  /**
   * Asserts that the event still should be accessed. All events are considered
   * to be "dead" after their original handler manager finishes firing them. An
   * event can be revived by calling {@link GwtEvent#revive()}.
   */
  void assertLive() {
    assert (!_dead) ; //: "This event has already finished being processed by its original handler manager, so you can no longer access it";
  }

  /**
   * Is the event current live?
   *
   * @return whether the event is live
   */
  bool isLive() {
    return !_dead;
  }

  /**
   * Kill the event. After the event has been killed, users cannot really on its
   * values or functions being available.
   */
  void kill() {
    _dead = true;
    setSource(null);
  }

  /**
   * Revives the event. Used when recycling event instances.
   */
  void revive() {
    _dead = false;
    setSource(null);
  }

  void overrideSource(Object source) {
    super.setSource(source);
  }
}
