//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Basic implementation of [EventBus].
 */
class SimpleEventBus<H> extends EventBus<H> {

  /**
   * Map of event type to map of event source to list of their handlers.
   */
  Map<EventType, Map<Object, List>> map = new Map<EventType, Map<Object, List>>();

  int _firingDepth = 0;

  /**
   * Add and remove operations received during dispatch.
   */
  List<Command> _deferredDeltas;

  /**
   * Allows creation of an instance that fires its handlers in the reverse of
   * the order in which they were added, although filtered handlers all fire
   * before unfiltered handlers.
   */
  SimpleEventBus();

  /**
   * Adds an unfiltered [handler] to receive events of this [type] from all sources.
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
  HandlerRegistration addHandler(EventType<H> type, H handler) {
    return _doAdd(type, new _EmptySource(), handler);
  }

  /**
   * Adds a [handler] to receive events of this [type] from the given [source].
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
  HandlerRegistration addHandlerToSource(EventType<H> type, Object source, H handler) {
    assert(source != null);
    //
    return _doAdd(type, source, handler);
  }

  HandlerRegistration _doAdd(EventType<H> type, Object source, H handler) {
    assert(type != null);
    assert(handler != null);
    //
    if (_firingDepth > 0) {
      _enqueueAdd(type, source, handler);
    } else {
      _doAddNow(type, source, handler);
    }

    return new _HandlerRegistration(this, type, source, handler);
  }

  void _doAddNow(EventType<H> type, Object source, H handler) {
    List<H> l = ensureHandlerList(type, source);
    l.add(handler);
  }

  List<H> ensureHandlerList(EventType<H> type, Object source) {
    Map<Object, List> sourceMap;
    if (map.containsKey(type)) {
      sourceMap = map[type];
    } else {
      sourceMap = new Map<Object, List>();
      map[type] = sourceMap;
    }

    // safe, we control the puts.
    List<H> handlers;
    if (sourceMap.containsKey(source)) {
      handlers = sourceMap[source];
    } else {
      handlers = new List<H>();
      sourceMap[source] = handlers;
    }

    return handlers;
  }

  void _doRemove(EventType<H> type, Object source, H handler) {
    if (_firingDepth > 0) {
      _enqueueRemove(type, source, handler);
    } else {
      _doRemoveNow(type, source, handler);
    }
  }

  void _doRemoveNow(EventType<H> type, Object source, H handler) {
    List<H> l = getHandlerList(type, source);

    int indx = l.indexOf(handler);
    if (indx != -1) {
      l.removeAt(indx);
      if (l.isEmpty) {
        prune(type, source);
      }
    }
  }

  void prune(EventType type, Object source) {
    if (map.containsKey(type)) {
      Map<Object, List> sourceMap = map[type];
      List pruned = sourceMap.remove(source);

      assert (pruned != null); // : "Can't prune what wasn't there";
      assert (pruned.isEmpty); // : "Pruned unempty list!";

      if (sourceMap.isEmpty) {
        map.remove(type);
      }
    }
  }

  //********
  // COMMAND
  //********

  void _defer(Command command) {
    if (_deferredDeltas == null) {
      _deferredDeltas = new List<Command>();
    }
    _deferredDeltas.add(command);
  }

  void _handleQueuedAddsAndRemoves() {
    if (_deferredDeltas != null) {
      try {
        for (Command c in _deferredDeltas) {
          c.execute();
        }
      } finally {
        _deferredDeltas = null;
      }
    }
  }

  void _enqueueRemove(EventType<H> type, Object source, H handler) {
    _defer(new _RemoveCommand(this, type, source, handler));
  }

  void _enqueueAdd(EventType<H> type, Object source, H handler) {
    _defer(new _AddCommand(this, type, source, handler));
  }

  //*******
  // FIRING
  //*******

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
  void fireEvent(Event event) {
    _doFire(event, null);
  }

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
  void fireEventFromSource(Event event, Object source) {
    assert(source != null);
    _doFire(event, source);
  }


  void _doFire(Event event, Object source) {
    assert(event != null);
    try {
      _firingDepth++;

      if (source != null) {
        event.setSource(source);
      }

      List<H> handlers = getDispatchList(event.getAssociatedType(), source);
      Set<Exception> causes = null;

      for (Iterator<H> it = handlers.iterator(); it.hasNext;) {
        H handler = it.next();

        try {
          EventBus.dispatchEvent(event, handler);
        } on Exception catch (e) {
          if (causes == null) {
            causes = new Set<Exception>();
          }
          causes.add(e);
        }
      }

      if (causes != null) {
        throw new UmbrellaException(causes);
      }
    } finally {
      _firingDepth--;
      if (_firingDepth == 0) {
        _handleQueuedAddsAndRemoves();
      }
    }
  }

  List<H> getDispatchList(EventType<H> type, Object source) {
    List<H> directHandlers = getHandlerList(type, source);
    if (source == null) {
      return directHandlers;
    }

    List<H> globalHandlers = getHandlerList(type, null);

    List<H> rtn = new List<H>.from(directHandlers);
    if (globalHandlers.length > 1) {
      rtn.addAll(globalHandlers);
    }
    return rtn;
  }

  List<H> getHandlerList(EventType<H> type, Object source) {
    if (map.containsKey(type)) {
      Map<Object, List> sourceMap = map[type];
      //
      if (source != null && sourceMap.containsKey(source)) {
        return sourceMap[source];
      }
    }
    return new List<H>();
  }
}

class _HandlerRegistration<H> extends HandlerRegistration {

  SimpleEventBus _eventBus;
  EventType<H> type;
  Object source;
  H handler;

  _HandlerRegistration(this._eventBus, this.type, this.source, this.handler);

  /**
   * Deregisters the handler associated with this registration object if the
   * handler is still attached to the event source. If the handler is no longer
   * attached to the event source, this is a no-op.
   */
  void removeHandler() {
    _eventBus._doRemove(type, source, handler);
  }
}

class _EmptySource {}

class _AddCommand<H> extends Command<H> {

  SimpleEventBus _eventBus;
  EventType<H> type;
  Object source;
  H handler;

  _AddCommand(this._eventBus, this.type, this.source, this.handler);

  void execute() {
    _eventBus._doAddNow(type, source, handler);
  }
}

class _RemoveCommand<H> extends Command<H> {

  SimpleEventBus _eventBus;
  EventType<H> type;
  Object source;
  H handler;

  _RemoveCommand(this._eventBus, this.type, this.source, this.handler);

  void execute() {
    _eventBus._doRemoveNow(type, source, handler);
  }
}