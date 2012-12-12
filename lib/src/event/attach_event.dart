//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_event;

class AttachEvent extends UiEvent {

  /**
   * The event type.
   */
  static EventType<AttachEventHandler> TYPE = new EventType<AttachEventHandler>();

  bool _attached;

  /**
   * Construct a new [AttachEvent].
   *
   * @param attached true if the source has been attached
   */
  AttachEvent(this._attached);

  EventType<AttachEventHandler> getAssociatedType() {
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
  void dispatch(AttachEventHandler handler) {
    handler.onAttachOrDetach(this);
  }

  /**
   * Fires an {@link AttachEvent} on all registered handlers in the handler
   * source.
   *
   * @param <S> The handler source type
   * @param source the source of the handlers
   * @param attached whether to announce an attach or detach
   */
  static void fire(HasAttachHandlers source, bool attached) {
    if (TYPE != null) {
      AttachEvent event = new AttachEvent(attached);
      source.fireEvent(event);
    }
  }
}

/**
 * Implemented by objects that handle {@link AttachEvent}.
 */
abstract class AttachEventHandler extends EventHandler {
  void onAttachOrDetach(AttachEvent event);
}