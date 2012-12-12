//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob UI library.
 */
part of dart_mob_event;

/**
 * Base Event object.
 *
 * @param <H> interface implemented by handlers of this kind of event
 */
abstract class Event<H> {

  dynamic _source;

  /**
   * Constructor.
   */
  Event();

  /**
   * Returns the [EventType] used to register this event, allowing an
   * [EventBus] to find handlers of the appropriate class.
   *
   * @return the type
   */
  EventType<H> getAssociatedType();

  /**
   * Returns the source for this event. The type and meaning of the source is
   * arbitrary, and is most useful as a secondary key for handler registration.
   * (See [EventBus#addHandlerToSource], which allows a handler to
   * register for events of a particular type, tied to a particular source.)
   *
   * Note that the source is actually set at dispatch time, e.g. via
   * [EventBus#fireEventFromSource(Event, Object)].
   *
   * @return object representing the source of this event
   */
  dynamic getSource() {
    return _source;
  }

  /**
   * Set the source that triggered this event. Intended to be called by the
   * [EventBus] during dispatch.
   *
   * @param source the source of this event.
   * @see EventBus#fireEventFromSource(Event, Object)
   * @see EventBus#setSourceOfEvent(Event, Object)
   */
  void setSource(dynamic source) {
    this._source = source;
  }

  /**
   * The toString() for abstract event is overridden to avoid accidently
   * including class literals in the the compiled output. Use [Event]
   * #toDebugString to get more information about the event.
   */
  String toString() {
    return "An event type";
  }

  /**
   * Implemented by subclasses to to invoke their handlers in a type safe
   * manner. Intended to be called by [EventBus#fireEvent(Event)] or
   * [EventBus#fireEventFromSource(Event, Object)].
   *
   * @param handler handler
   * @see EventBus#dispatchEvent(Event, Object)
   */
  void dispatch(H handler);
}

/**
 * Type class used to register events with an [EventBus].
 *
 * @param <H> handler type
 */
class EventType<H> {
  String toString() {
    return "Event type";
  }
}
