//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a open event.
 *
 * @param <T> the type being opened
 */
class OpenEvent<T> extends DwtEvent {

  /**
   * The event type.
   */
  static EventType<OpenHandler> TYPE = new EventType<OpenHandler>();

  /**
   * Fires a open event on all registered handlers in the handler manager.If no
   * such handlers exist, this method will do nothing.
   *
   * @param <T> the target type
   * @param source the source of the handlers
   * @param target the target
   */
  static void fire(HasOpenHandlers source, target) {
    if (TYPE != null) {
      OpenEvent event = new OpenEvent(target);
      source.fireEvent(event);
    }
  }

  final T _target;

  /**
   * Creates a new open event.
   *
   * @param target the ui object being opened
   */
  OpenEvent(this._target);

  EventType<OpenHandler> getAssociatedType() {
    return TYPE;
  }

  /**
   * Gets the target.
   *
   * @return the target
   */
  T getTarget() {
    return _target;
  }

  // Because of type erasure, our static type is
  // wild carded, yet the "real" type should use our I param.

  void dispatch(OpenHandler handler) {
    handler.onOpen(this);
  }
}
