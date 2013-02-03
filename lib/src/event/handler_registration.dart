//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Registration objects returned when an event handler is bound (e.g. via
 * [EventBus#addHandler]), used to deregister.
 *
 * A tip: to make a handler deregister itself try something like the following:
 * <code><pre>new MyHandler() {
 *  HandlerRegistration reg = MyEvent.register(eventBus, this);
 *
 *  public void onMyThing(MyEvent event) {
 *    {@literal /}* do your thing *{@literal /}
 *    reg.removeHandler();
 *  }
 * };
 * </pre></code>
 */
abstract class HandlerRegistration {

  /**
   * Deregisters the handler associated with this registration object if the
   * handler is still attached to the event source. If the handler is no longer
   * attached to the event source, this is a no-op.
   */
  void removeHandler();
}
