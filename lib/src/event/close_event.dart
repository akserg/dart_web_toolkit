//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a close event.
 *
 * @param <T> the type being closed
 */
class CloseEvent<T> extends DwtEvent {

  /**
   * The event type.
   */
  static EventType<CloseHandler> TYPE = new EventType<CloseHandler>();

  final T target;

  final bool autoClosed;

  /**
   * Creates a new close event.
   *
   * @param target the target
   * @param autoClosed whether it is auto closed
   */
  CloseEvent(this.target, this.autoClosed);

  EventType<CloseHandler> getAssociatedType() {
    return TYPE;
  }

  /**
   * Implemented by subclasses to to invoke their handlers in a type safe
   * manner. Intended to be called by [EventBus#fireEvent(Event)] or
   * [EventBus#fireEventFromSource(Event, Object)].
   *
   * @param handler handler
   * @see EventBus#dispatchEvent(Event, Object)
   */
  void dispatch(CloseHandler<T> handler) {
    handler.onClose(this);
  }

  /**
   * Fires a close event on all registered handlers in the handler manager.
   *
   * @param <T> the target type
   * @param source the source of the handlers
   * @param target the target
   * @param autoClosed was the target closed automatically
   */
  static void fire(HasCloseHandlers source, target, [bool autoClosed = false]) {
    if (TYPE != null) {
      CloseEvent event = new CloseEvent(target, autoClosed);
      source.fireEvent(event);
    }
  }
}

/**
 * A widget that implements this interface is a public source of
 * {@link CloseEvent} events.
 *
 * @param <T> the type being closed
 */
abstract class HasCloseHandlers<T> extends HasHandlers {
  /**
   * Adds a {@link CloseEvent} handler.
   *
   * @param handler the handler
   * @return the registration for the event
   */
  HandlerRegistration addCloseHandler(CloseHandler<T> handler);
}

