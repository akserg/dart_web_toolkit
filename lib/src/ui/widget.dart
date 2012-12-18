//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * The base class for the majority of user-interface objects. Widget adds
 * support for receiving events from the browser and being added directly to
 * [Panel]s.
 */
class Widget extends UiObject
             implements EventListener, IsWidget, HasAttachHandlers  {

  /**
   * This convenience method makes a null-safe call to
   * {@link IsWidget#asWidget()}.
   *
   * @return the widget aspect, or <code>null</code> if w is null
   */
  static Widget asWidgetOrNull(IsWidget w) {
    return w == null ? null : w.asWidget();
  }


  //***********
  // Properties
  //***********

//  HandlerManager _handlerManager;
  EventBus _eventBus;
  bool _attached = false;
  Object _layoutData;
  Widget _parent;

  //********************************
  // Implementation of EventListener
  //********************************
  /**
   * Fired whenever a browser event is received.
   *
   * @param event the event received
   *
   * TODO
   */
  void onBrowserEvent(dart_html.Event event) {
//    switch (DOM.eventGetType(event)) {
//      case Event.ONMOUSEOVER:
//        // Only fire the mouse over event if it's coming from outside this
//        // widget.
//      case Event.ONMOUSEOUT:
//        // Only fire the mouse out event if it's leaving this
//        // widget.
//        Element related = event.getRelatedEventTarget().cast();
//        if (related != null && getElement().isOrHasChild(related)) {
//          return;
//        }
//        break;
//    }
    //DomEvent.fireNativeEvent(event, this, this.getElement());
//    ensureHandlers().
    print("onBrowserEvent: ${event}");
    DomEvent.fireNativeEvent(event, this, this.getElement());
  }

  //***************************
  // Implementation of IsWidget
  //***************************

  Widget asWidget() {
    return this;
  }

  //******************************
  // Implementation of HasHandlers
  //******************************

  /**
   * Fires the given event to the handlers listening to the event's type.
   *
   * Any exceptions thrown by handlers will be bundled into a
   * [UmbrellaException] and then re-thrown after all handlers have
   * completed. An exception thrown by a handler will not prevent other handlers
   * from executing.
   *
   * @param event the event
   */
  void fireEvent(DwtEvent event) {
    if (_eventBus != null) {
      // If it not live we should revive it.
      if (!event.isLive()) {
        event.revive();
      }
      Object oldSource = event.getSource();
      event.overrideSource(getElement());
      try {

        // May throw an UmbrellaException.
        _eventBus.fireEventFromSource(event, getElement());
      } on UmbrellaException catch (e) {
        throw new UmbrellaException(e.causes);
      } finally {
        if (oldSource == null) {
          // This was my event, so I should kill it now that I'm done.
          event.kill();
        } else {
          // Restoring the source for the next handler to use.
          event.overrideSource(oldSource);
        }
      }
    }
  }

  //************************************
  // Implementation of HasAttachHandlers
  //************************************

  /**
   * Adds an [AttachEvent] handler.
   *
   * @param handler the handler
   * @return the handler registration
   */
  HandlerRegistration addAttachHandler(AttachEventHandler handler) {
    return addHandler(handler, AttachEvent.TYPE);
  }

  /**
   * Adds this handler to the widget.
   *
   * @param <H> the type of handler to add
   * @param type the event type
   * @param handler the handler
   * @return {@link HandlerRegistration} used to remove the handler
   */
  HandlerRegistration addHandler(EventHandler handler, EventType<EventHandler> type) {
    return ensureHandlers().addHandler(type, handler);
  }

  /**
   * Ensures the existence of the event bus.
   *
   * @return the [EventBus].
   * */
  EventBus ensureHandlers() {
    return _eventBus == null ? _eventBus = createEventBus() : _eventBus;
  }

  EventBus getEventBus() {
    return _eventBus;
  }


  /**
   * Adds a native event handler to the widget and sinks the corresponding
   * native event. If you do not want to sink the native event, use the generic
   * addHandler method instead.
   *
   * @param <H> the type of handler to add
   * @param type the event key
   * @param handler the handler
   * @return {@link HandlerRegistration} used to remove the handler
   */
//  HandlerRegistration addDomHandler(EventHandler handler, EventType type) {
//    assert (handler != null); // : "handler must not be null";
//    assert (type != null); // : "type must not be null";
//    int typeInt = Event.getTypeInt(type.getName());
//    if (typeInt == -1) {
//      sinkBitlessEvent(type.getName());
//    } else {
//      sinkEvents(typeInt);
//    }
//    return ensureHandlers().addHandler(type, handler);
//  }
  HandlerRegistration addDomHandler(DomEventHandler handler, DomEventType type) {
    getElement().on[type.eventName].add(onBrowserEvent);
    return ensureHandlers().addHandlerToSource(type, getElement(), handler);
  }

  /**
   * Creates the [SimpleEventBus] used by this Widget. You can override
   * this method to create a custom [EventBus].
   *
   * @return the [EventBus] you want to use.
   */
  EventBus createEventBus() {
    return new SimpleEventBus();
  }


//  /**
//   * Gets the number of handlers listening to the event type.
//   *
//   * @param type the event type
//   * @return the number of registered handlers
//   */
//  int getHandlerCount(EventType type) {
//    return _handlerManager == null ? 0 : _handlerManager.getHandlerCount(type);
//  }

  /**
   * Returns whether or not the receiver is attached to the
   * {@link com.google.gwt.dom.client.Document Document}'s
   * {@link com.google.gwt.dom.client.BodyElement BodyElement}.
   *
   * @return true if attached, false otherwise
   */
  bool isAttached() {
    return _attached;
  }

  //**************
  /**
   * Gets the panel-defined layout data associated with this widget.
   *
   * @return the widget's layout data
   * @see #setLayoutData
   */
  Object getLayoutData() {
    return _layoutData;
  }

  /**
   * Sets the panel-defined layout data associated with this widget. Only the
   * panel that currently contains a widget should ever set this value. It
   * serves as a place to store layout bookkeeping data associated with a
   * widget.
   *
   * @param layoutData the widget's layout data
   */
  void setLayoutData(Object value) {
    this._layoutData = value;
  }

  /**
   * Gets this widget's parent panel.
   *
   * @return the widget's parent panel
   */
  Widget getParent() {
    return _parent;
  }

  /**
   * Sets this widget's parent. This method should only be called by
   * {@link Panel} and {@link Composite}.
   *
   * @param parent the widget's new parent
   * @throws IllegalStateException if <code>parent</code> is non-null and the
   *           widget already has a parent
   */
  void setParent(Widget parent) {
    Widget oldParent = this._parent;
    if (parent == null) {
      try {
        if (oldParent != null && oldParent.isAttached()) {
          onDetach();
          assert (!isAttached()); // : "Failure of " + this.getClass().getName() + " to call super.onDetach()";
        }
      } finally {
        // Put this in a finally in case onDetach throws an exception.
        this._parent = null;
      }
    } else {
      if (oldParent != null) {
        throw new Exception("Cannot set a new parent without first clearing the old parent");
      }
      this._parent = parent;
      if (parent.isAttached()) {
        onAttach();
        assert (isAttached()); // : "Failure of " + this.getClass().getName() + " to call super.onAttach()";
      }
    }
  }
  /**
   * Removes this widget from its parent widget, if one exists.
   *
   * <p>
   * If it has no parent, this method does nothing. If it is a "root" widget
   * (meaning it's been added to the detach list via
   * {@link RootPanel#detachOnWindowClose(Widget)}), it will be removed from the
   * detached immediately. This makes it possible for Composites and Panels to
   * adopt root widgets.
   * </p>
   *
   * @throws IllegalStateException if this widget's parent does not support
   *           removal (e.g. {@link Composite})
   */
  void removeFromParent() {
    if (_parent == null) {
      // If the widget had no parent, check to see if it was in the detach list
      // and remove it if necessary.
      if (RootPanel.isInDetachList(this)) {
        RootPanel.detachNow(this);
      }
    } else if (_parent is HasWidgets) {
      (_parent as HasWidgets).remove(this);
    } else if (_parent != null) {
      throw new Exception("This widget's parent does not implement HasWidgets");
    }
  }

  /**
   * Replaces this object's browser element.
   *
   * This method exists only to support a specific use-case in Image, and should
   * not be used by other classes.
   *
   * @param elem the object's new element
   */
  void replaceElement(dart_html.Element elem) {
    if (isAttached()) {
      // Remove old event listener to avoid leaking. onDetach will not do this
      // for us, because it is only called when the widget itself is detached
      // from the document.
      Dom.setEventListener(getElement(), null);
    }

    super.replaceElement(elem);

    if (isAttached()) {
      // Hook the event listener back up on the new element. onAttach will not
      // do this for us, because it is only called when the widget itself is
      // attached to the document.
      Dom.setEventListener(getElement(), this);
    }
  }

  /**
   * Fires an event on a child widget. Used to delegate the handling of an event
   * from one widget to another.
   *
   * @param event the event
   * @param target fire the event on the given target
   */
  void delegateEvent(Widget target, DwtEvent event) {
    target.fireEvent(event);
  }

  //*********
  // Children
  //*********
  /**
   * If a widget contains one or more child widgets that are not in the logical
   * widget hierarchy (the child is physically connected only on the DOM level),
   * it must override this method and call {@link #onAttach()} for each of its
   * child widgets.
   *
   * @see #onAttach()
   */
  void doAttachChildren() {
  }

  /**
   * If a widget contains one or more child widgets that are not in the logical
   * widget hierarchy (the child is physically connected only on the DOM level),
   * it must override this method and call {@link #onDetach()} for each of its
   * child widgets.
   *
   * @see #onDetach()
   */
  void doDetachChildren() {
  }

  //************
  // Attachments
  //************

  /**
   * <p>
   * This method is called when a widget is attached to the browser's document.
   * To receive notification after a Widget has been added to the document,
   * override the {@link #onLoad} method or use {@link #addAttachHandler}.
   * </p>
   * <p>
   * It is strongly recommended that you override {@link #onLoad()} or
   * {@link #doAttachChildren()} instead of this method to avoid inconsistencies
   * between logical and physical attachment states.
   * </p>
   * <p>
   * Subclasses that override this method must call
   * <code>super.onAttach()</code> to ensure that the Widget has been attached
   * to its underlying Element.
   * </p>
   *
   * @throws IllegalStateException if this widget is already attached
   * @see #onLoad()
   * @see #doAttachChildren()
   */
  void onAttach() {
    if (isAttached()) {
      throw new Exception("Should only call onAttach when the widget is detached from the browser's document");
    }

    _attached = true;

    // Event hookup code
    Dom.setEventListener(getElement(), this);
    //int bitsToAdd = eventsToSink;
    //eventsToSink = -1;
    //if (bitsToAdd > 0) {
      //sinkEvents(bitsToAdd);
    //}
    doAttachChildren();

    // onLoad() gets called only *after* all of the children are attached and
    // the attached flag is set. This allows widgets to be notified when they
    // are fully attached, and panels when all of their children are attached.
    onLoad();
    AttachEvent.fire(this, true);
  }

  /**
   * This method is called immediately after a widget becomes attached to the
   * browser's document.
   */
  void onLoad() {
  }

  /**
   * <p>
   * This method is called when a widget is detached from the browser's
   * document. To receive notification before a Widget is removed from the
   * document, override the {@link #onUnload} method or use {@link #addAttachHandler}.
   * </p>
   * <p>
   * It is strongly recommended that you override {@link #onUnload()} or
   * {@link #doDetachChildren()} instead of this method to avoid inconsistencies
   * between logical and physical attachment states.
   * </p>
   * <p>
   * Subclasses that override this method must call
   * <code>super.onDetach()</code> to ensure that the Widget has been detached
   * from the underlying Element. Failure to do so will result in application
   * memory leaks due to circular references between DOM Elements and JavaScript
   * objects.
   * </p>
   *
   * @throws IllegalStateException if this widget is already detached
   * @see #onUnload()
   * @see #doDetachChildren()
   */
  void onDetach() {
    if (!isAttached()) {
      throw new Exception("Should only call onDetach when the widget is attached to the browser's document");
    }

    try {
      // onUnload() gets called *before* everything else (the opposite of
      // onLoad()).
      onUnload();
      AttachEvent.fire(this, false);
    } finally {
      // Put this in a finally, just in case onUnload throws an exception.
      try {
        doDetachChildren();
      } finally {
        // Put this in a finally, in case doDetachChildren throws an exception.
        Dom.setEventListener(getElement(), null);
        _attached = false;
      }
    }
  }

  /**
   * This method is called immediately before a widget will be detached from the
   * browser's document.
   */
  void onUnload() {
  }


  /**
   * Has this widget ever been attached?
   *
   * @return true if this widget ever been attached to the DOM, false otherwise
   */
  bool isOrWasAttached() {
    return true;
  }
}
