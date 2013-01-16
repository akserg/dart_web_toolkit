//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Fired when the event source is resized.
 */
class ResizeEvent extends DwtEvent {

  /**
   * The event type.
   */
  static EventType<ResizeHandler> TYPE = new EventType<ResizeHandler>();

  /**
   * Fires a resize event on all registered handlers in the handler source.
   *
   * @param <S> The handler source
   * @param source the source of the handlers
   * @param width the new width
   * @param height the new height
   */
  static void fire(HasHandlers source, int width, int height) {
    if (TYPE != null) {
      ResizeEvent event = new ResizeEvent(width, height);
      source.fireEvent(event);
    }
  }

  int _width;
  int _height;

  /**
   * Construct a new {@link ResizeEvent}.
   *
   * @param _width the new width
   * @param _height the new height
   */
  ResizeEvent(this._width, this._height);

  EventType<ResizeHandler> getAssociatedType() {
    return TYPE;
  }

  /**
   * Returns the new height.
   *
   * @return the new height
   */
  int get height =>_height;

  /**
   * Returns the new width.
   *
   * @return the new width
   */
  int get width =>_width;

  void dispatch(ResizeHandler handler) {
    handler.onResize(this);
  }
}
