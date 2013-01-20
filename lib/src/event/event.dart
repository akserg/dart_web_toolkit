//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * DartMob UI library.
 */
part of dart_web_toolkit_event;

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
   * Implemented by subclasses to invoke their handlers in a type safe
   * manner. Intended to be called by [EventBus#fireEvent(Event)] or
   * [EventBus#fireEventFromSource(Event, Object)].
   *
   * @param handler handler
   * @see EventBus#dispatchEvent(Event, Object)
   */
  void dispatch(H handler);
  
  //*****************
  
  /**
   * The list of {@link NativePreviewHandler}. We use a list instead of a
   * handler manager for efficiency and because we want to fire the handlers in
   * reverse order. When the last handler is removed, handlers is reset to null.
   */
  static EventBus handlers;
  
  /**
   * <p>
   * Adds a {@link NativePreviewHandler} that will receive all events before
   * they are fired to their handlers. Note that the handler will receive
   * <u>all</u> native events, including those received due to bubbling, whereas
   * normal event handlers only receive explicitly sunk events.
   * </p>
   * 
   * <p>
   * Unlike other event handlers, {@link NativePreviewHandler} are fired in the
   * reverse order that they are added, such that the last
   * {@link NativePreviewEvent} that was added is the first to be fired.
   * </p>
   * 
   * <p>
   * Please note that nondeterministic behavior will result if more than one GWT
   * application registers preview handlers. See <a href=
   * 'http://code.google.com/p/google-web-toolkit/issues/detail?id=3892'>issue
   * 3892</a> for details.
   * </p>
   *
   * @param handler the {@link NativePreviewHandler}
   * @return {@link HandlerRegistration} used to remove this handler
   */
  static HandlerRegistration addNativePreviewHandler(NativePreviewHandler handler) {
    assert (handler != null); // : "Cannot add a null handler";
    //DOM.maybeInitializeEventSystem();

    // Initialize the type
    //NativePreviewEvent.getType();
    if (handlers == null) {
      handlers = new SimpleEventBus(); // new HandlerManager(null, true);
      NativePreviewEvent.singleton = new NativePreviewEvent();
    }
    return handlers.addHandler(NativePreviewEvent.TYPE, handler);
  }
  
  /**
   * Fire a {@link NativePreviewEvent} for the native event.
   * 
   * @param nativeEvent the native event
   * @return true to fire the event normally, false to cancel the event
   */
  static bool fireNativePreviewEvent(dart_html.Event nativeEvent) {
    return NativePreviewEvent.fire(handlers, nativeEvent);
  }
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
