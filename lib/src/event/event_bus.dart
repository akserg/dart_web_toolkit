//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Dispatches [Event]s to interested parties. Eases decoupling by allowing
 * objects to interact without having direct dependencies upon one another, and
 * without requiring event sources to deal with maintaining handler lists. There
 * will typically be one EventBus per application, broadcasting events that may
 * be of general interest.
 *
 * @see SimpleEventBus
 * @see ResettableEventBus
 * @see com.google.web.bindery.event.shared.testing.CountingEventBus
 */
abstract class EventBus<H> {

  /**
   * Invokes [dispatch] with [handler].
   *
   * Protected to allow EventBus implementations in different packages to
   * dispatch events even though the [dispatch] method is protected.
   */
  static void dispatchEvent(IEvent event, handler) {
    event.dispatch(handler);
  }

  /**
   * Sets [source] as the source of [event].
   *
   * Protected to allow EventBus implementations in different packages to set an
   * event source even though the {@code event.setSource} method is protected.
   */
  static void setSourceOfEvent(IEvent event, source) {
    event.setSource(source);
  }

  /**
   * Adds an unfiltered handler to receive events of this type from all sources.
   *
   * It is rare to call this method directly. More typically an [Event]
   * subclass will provide a static <code>register</code> method, or a widget
   * will accept handlers directly.
   *
   * @param <H> The type of handler
   * @param type the event type associated with this handler
   * @param handler the handler
   * @return the handler registration, can be stored in order to remove the
   *         handler later
   */
  HandlerRegistration addHandler(EventType<H> type, H handler);

  /**
   * Adds a handler to receive events of this type from the given source.
   *
   * It is rare to call this method directly. More typically a [Event]
   * subclass will provide a static <code>register</code> method, or a widget
   * will accept handlers directly.
   *
   * @param <H> The type of handler
   * @param type the event type associated with this handler
   * @param source the source associated with this handler
   * @param handler the handler
   * @return the handler registration, can be stored in order to remove the
   *         handler later
   */
  HandlerRegistration addHandlerToSource(EventType<H> type, Object source, H handler);

  /**
   * Fires the event from no source. Only unfiltered handlers will receive it.
   *
   * Any exceptions thrown by handlers will be bundled into a
   * [UmbrellaException] and then re-thrown after all handlers have
   * completed. An exception thrown by a handler will not prevent other handlers
   * from executing.
   *
   * @throws UmbrellaException wrapping exceptions thrown by handlers
   *
   * @param event the event to fire
   */
  void fireEvent(IEvent event);

  /**
   * Fires the given event to the handlers listening to the event's type.
   *
   * Any exceptions thrown by handlers will be bundled into a
   * [UmbrellaException] and then re-thrown after all handlers have
   * completed. An exception thrown by a handler will not prevent other handlers
   * from executing.
   *
   * @throws UmbrellaException wrapping exceptions thrown by handlers
   *
   * @param event the event to fire
   */
  void fireEventFromSource(IEvent event, Object source);
}
