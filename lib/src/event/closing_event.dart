//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Fired just before the browser window closes or navigates to a different site.
 */
class ClosingEvent extends DwtEvent {

  /**
   * The event type.
   */
  static EventType<ClosingHandler> TYPE = new EventType<ClosingHandler>();

  /**
   * The message to display to the user to see whether they really want to
   * leave the page.
   */
  String _message;

  EventType<ClosingHandler> getAssociatedType() {
    return TYPE;
  }
  
  /**
   * Get the message that will be presented to the user in a confirmation
   * dialog that asks the user whether or not she wishes to navigate away from
   * the page.
   * 
   * @return the message to display to the user, or null
   */
  String getMessage() {
    return _message;
  }

  /**
   * Set the message to a <code>non-null</code> value to present a
   * confirmation dialog that asks the user whether or not she wishes to
   * navigate away from the page. If multiple handlers set the message, the
   * last message will be displayed; all others will be ignored.
   * 
   * @param message the message to display to the user, or null
   */
  void setMessage(String message) {
    this._message = message;
  }

  void dispatch(ClosingHandler handler) {
    handler.onWindowClosing(this);
  }
}