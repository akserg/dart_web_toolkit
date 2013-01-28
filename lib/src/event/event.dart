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
  
  //**************
  //**************
  //**************
  
  /**
   * Fired when an element loses keyboard focus.
   */
  static const int ONBLUR = 0x01000;

  /**
   * Fired when the value of an input element changes.
   */
  static const int ONCHANGE = 0x00400;

  /**
   * Fired when the user clicks on an element.
   */
  static const int ONCLICK = 0x00001;

  /**
   * Fired when the user double-clicks on an element.
   */
  static const int ONDBLCLICK = 0x00002;

  /**
   * Fired when an image encounters an error.
   */
  static const int ONERROR = 0x10000;

  /**
   * Fired when an element receives keyboard focus.
   */
  static const int ONFOCUS = 0x00800;

  /**
   * Fired when the user gesture changes.
   */
  static const int ONGESTURECHANGE = 0x2000000;

  /**
   * Fired when the user gesture ends.
   */
  static const int ONGESTUREEND = 0x4000000;

  /**
   * Fired when the user gesture starts.
   */
  static const int ONGESTURESTART = 0x1000000;

  /**
   * Fired when the user depresses a key.
   */
  static const int ONKEYDOWN = 0x00080;

  /**
   * Fired when the a character is generated from a keypress (either directly or
   * through auto-repeat).
   */
  static const int ONKEYPRESS = 0x00100;

  /**
   * Fired when the user releases a key.
   */
  static const int ONKEYUP = 0x00200;

  /**
   * Fired when an element (normally an IMG) finishes loading.
   */
  static const int ONLOAD = 0x08000;

  /**
   * Fired when an element that has mouse capture loses it.
   */
  static const int ONLOSECAPTURE = 0x02000;

  /**
   * Fired when the user depresses a mouse button over an element.
   */
  static const int ONMOUSEDOWN = 0x00004;

  /**
   * Fired when the mouse is moved within an element's area.
   */
  static const int ONMOUSEMOVE = 0x00040;

  /**
   * Fired when the mouse is moved out of an element's area.
   */
  static const int ONMOUSEOUT = 0x00020;

  /**
   * Fired when the mouse is moved into an element's area.
   */
  static const int ONMOUSEOVER = 0x00010;

  /**
   * Fired when the user releases a mouse button over an element.
   */
  static const int ONMOUSEUP = 0x00008;

  /**
   * Fired when the user scrolls the mouse wheel over an element.
   */
  static const int ONMOUSEWHEEL = 0x20000;

  /**
   * Fired when the user pastes text into an input element.
   * 
   * <p>
   * Note: This event is <em>not</em> supported on Firefox 2 and earlier, or
   * Opera 10 and earlier. Be aware that it will not fire on these browser
   * versions.
   * </p>
   */
  static const int ONPASTE = 0x80000;

  /**
   * Fired when a scrollable element's scroll offset changes.
   */
  static const int ONSCROLL = 0x04000;

  /**
   * Fired when the user cancels touching an element.
   */
  static const int ONTOUCHCANCEL = 0x800000;

  /**
   * Fired when the user ends touching an element.
   */
  static const int ONTOUCHEND = 0x400000;

  /**
   * Fired when the user moves while touching an element.
   */
  static const int ONTOUCHMOVE = 0x200000;

  /**
   * Fired when the user starts touching an element.
   */
  static const int ONTOUCHSTART = 0x100000;
  /**
   * Fired when the user requests an element's context menu (usually by
   * right-clicking).
   * 
   * Note that not all browsers will fire this event (notably Opera, as of 9.5).
   */
  static const int ONCONTEXTMENU = 0x40000;

  /**
   * A bit-mask covering both focus events (focus and blur).
   */
  static const int FOCUSEVENTS = ONFOCUS | ONBLUR;

  /**
   * A bit-mask covering all keyboard events (down, up, and press).
   */
  static const int KEYEVENTS = ONKEYDOWN | ONKEYPRESS | ONKEYUP;

  /**
   * A bit-mask covering all mouse events (down, up, move, over, and out), but
   * not click, dblclick, or wheel events.
   */
  static const int MOUSEEVENTS = ONMOUSEDOWN | ONMOUSEUP | ONMOUSEMOVE
      | ONMOUSEOVER | ONMOUSEOUT;

  /**
   * A bit-mask covering all touch events (start, move, end, cancel).
   */
  static const int TOUCHEVENTS = ONTOUCHSTART | ONTOUCHMOVE | ONTOUCHEND | ONTOUCHCANCEL;

  /**
   * A bit-mask covering all gesture events (start, change, end).
   */
  static const int GESTUREEVENTS = ONGESTURESTART | ONGESTURECHANGE | ONGESTUREEND;
  
  /**
   * The left mouse button.
   */
  static const int BUTTON_LEFT = 0;

  /**
   * The middle mouse button.
   */
  static const int BUTTON_MIDDLE = 1;

  /**
   * The right mouse button.
   */
  static const int BUTTON_RIGHT = 2;
  
  /**
   * Gets the enumerated type of this event given a valid event type name.
   * 
   * @param typeName the typeName to be tested
   * @return the event's enumerated type, or -1 if not defined
   */
  static int getTypeInt(String typeName) {
    return Dom.impl.eventGetTypeInt(typeName);
  }
  
  /**
   * Sets the current set of events sunk by a given element. These events will
   * be fired to the nearest {@link EventListener} specified on any of the
   * element's parents.
   * 
   * @param elem the element whose events are to be retrieved
   * @param eventBits a bitfield describing the events sunk on this element (its
   *          possible values are described in {@link Event})
   */
  static void sinkEvents(dart_html.Element elem, int eventBits) {
    // This cast is always valid because both Element types are JSOs and have
    // no new fields are added in the subclass.
    Dom.sinkEvents(elem, eventBits);
  }
  
  /**
   * Gets the current set of events sunk by a given element.
   * 
   * @param elem the element whose events are to be retrieved
   * @return a bitfield describing the events sunk on this element (its possible
   *         values are described in {@link Event})
   */
  static int getEventsSunk(dart_html.Element elem) {
    // This cast is always valid because both Element types are JSOs and have
    // no new fields are added in the subclass.
    return Dom.getEventsSunk(elem);
  }
  
  /**
   * Gets the {@link EventListener} that will receive events for the given
   * element. Only one such listener may exist for a single element.
   * 
   * @param elem the element whose listener is to be set
   * @return the element's event listener
   */
  static EventListener getEventListener(dart_html.Element elem) {
    return Dom.getEventListener(elem);
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
