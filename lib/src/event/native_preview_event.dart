//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Represents a preview of a native {@link Event}.
 */
class NativePreviewEvent extends DwtEvent implements HasNativeEvent {
 
  /**
   * Handler type.
   */
  static EventType<NativePreviewHandler> TYPE = new EventType<NativePreviewHandler>();

  /**
   * The singleton instance of {@link NativePreviewEvent}.
   */
  static NativePreviewEvent singleton;

  /**
   * Fire a {@link NativePreviewEvent} for the native event.
   * 
   * @param handlers the {@link HandlerManager}
   * @param nativeEvent the native event
   * @return true to fire the event normally, false to cancel the event
   */
  static bool fire(EventBus handlers, dart_html.Event nativeEvent) {
    if (TYPE != null && handlers != null) { // && handlers.isEventHandled(TYPE)) {
      // Cache the current values in the singleton in case we are in the
      // middle of handling another event.
      bool lastIsCanceled = singleton._isCanceled;
      bool lastIsConsumed = singleton._isConsumed;
      bool lastIsFirstHandler = singleton._isFirstHandler;
      dart_html.Event lastNativeEvent = singleton._nativeEvent;

      // Revive the event
      singleton.revive();
      singleton.setNativeEvent(nativeEvent);

      // Fire the event
      handlers.fireEvent(singleton);
      bool ret = !(singleton.isCanceled() && !singleton.isConsumed());

      // Restore the state of the singleton.
      singleton._isCanceled = lastIsCanceled;
      singleton._isConsumed = lastIsConsumed;
      singleton._isFirstHandler = lastIsFirstHandler;
      singleton._nativeEvent = lastNativeEvent;
      return ret;
    }
    return true;
  }

  /**
   * A bool indicating that the native event should be canceled.
   */
  bool _isCanceled = false;

  /**
   * A bool indicating whether or not canceling the native event should be
   * prevented. This supercedes {@link #isCanceled}.
   */
  bool _isConsumed = false;

  /**
   * A bool indicating that the current handler is at the top of the event
   * preview stack.
   */
  bool _isFirstHandler = false;

  /**
   * The event being previewed.
   */
  dart_html.Event _nativeEvent;

  /**
   * Cancel the native event and prevent it from firing. Note that the event
   * can still fire if another handler calls {@link #consume()}.
   * 
   * Classes overriding this method should still call super.cancel().
   */
  void cancel() {
    _isCanceled = true;
  }

  /**
   * Consume the native event and prevent it from being canceled, even if it
   * has already been canceled by another handler.
   * {@link NativePreviewHandler} that fire first have priority over later
   * handlers, so all handlers should check if the event has already been
   * canceled before calling this method.
   */
  void consume() {
    _isConsumed = true;
  }

  
  EventType<NativePreviewHandler> getAssociatedType() {
    return TYPE;
  }

  dart_html.Event getNativeEvent() {
    return _nativeEvent;
  }

//  /**
//   * Gets the type int corresponding to the native event that triggered this
//   * preview.
//   * 
//   * @return the type int associated with this native event
//   */
//  int getTypeInt() {
//    return Event.as(getNativeEvent()).getTypeInt();
//  }

  /**
   * Has the event already been canceled? Note that {@link #isConsumed()} will
   * still return true if the native event has also been consumed.
   * 
   * @return true if the event has been canceled
   * @see #cancel()
   */
  bool isCanceled() {
    return _isCanceled;
  }

  /**
   * Has the native event been consumed? Note that {@link #isCanceled()} will
   * still return true if the native event has also been canceled.
   * 
   * @return true if the event has been consumed
   * @see #consume()
   */
  bool isConsumed() {
    return _isConsumed;
  }

  /**
   * Is the current handler the first to preview this event?
   * 
   * @return true if the current handler is the first to preview the event
   */
  bool isFirstHandler() {
    return _isFirstHandler;
  }

  
  void dispatch(NativePreviewHandler handler) {
    handler.onPreviewNativeEvent(this);
    singleton._isFirstHandler = false;
  }

  
  void revive() {
    super.revive();
    _isCanceled = false;
    _isConsumed = false;
    _isFirstHandler = true;
    _nativeEvent = null;
  }

  /**
   * Set the native event.
   * 
   * @param nativeEvent the native {@link Event} being previewed.
   */
  void setNativeEvent(dart_html.Event nativeEvent) {
    this._nativeEvent = nativeEvent;
  }
}
