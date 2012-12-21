//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Represents a value change event.
 * 
 * @param <T> the value about to be changed
 */
class ValueChangeEvent<T> extends DwtEvent {
  
  /**
   * The event type.
   */
  static EventType<ValueChangeHandler> TYPE = new EventType<ValueChangeHandler>();

  T _value;

  /**
   * Gets the value.
   * 
   * @return the value
   */
  T get value => _value;
  
  /**
   * Creates a value change event.
   * 
   * @param value the value
   */
  ValueChangeEvent(this._value);

  EventType<ValueChangeHandler> getAssociatedType() {
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
  void dispatch(ValueChangeHandler handler) {
    handler.onValueChange(this);
  }

  /**
   * Fires an {@link AttachEvent} on all registered handlers in the handler
   * source.
   *
   * @param <S> The handler source type
   * @param source the source of the handlers
   * @param attached whether to announce an attach or detach
   */
  static void fire(HasValueChangeHandlers source, Object value) {
    if (TYPE != null) {
      ValueChangeEvent event = new ValueChangeEvent(value);
      source.fireEvent(event);
    }
  }
  
  /**
   * Fires value change event if the old value is not equal to the new value.
   * Use this call rather than making the decision to short circuit yourself for
   * safe handling of null.
   * 
   * @param <T> the old value type
   * @param source the source of the handlers
   * @param oldValue the oldValue, may be null
   * @param newValue the newValue, may be null
   */
  static void fireIfNotEqual(HasValueChangeHandlers source, Object oldValue, Object newValue) {
    if (_shouldFire(source, oldValue, newValue)) {
      ValueChangeEvent event = new ValueChangeEvent(newValue);
      source.fireEvent(event);
    }
  }
  
  /**
   * Convenience method to allow subtypes to know when they should fire a value
   * change event in a null-safe manner.
   * 
   * @param <T> value type
   * @param source the source
   * @param oldValue the old value
   * @param newValue the new value
   * @return whether the event should be fired
   */
  static bool _shouldFire(HasValueChangeHandlers source, Object oldValue, Object newValue) {
    return TYPE != null && oldValue != newValue && oldValue == null; // || !oldValue.equals(newValue));
  }
}

/**
 * Implemented by objects that handle {@link AttachEvent}.
 */
abstract class ValueChangeHandler<T> extends EventHandler {
  /**
   * Called when {@link ValueChangeEvent} is fired.
   * 
   * @param event the {@link ValueChangeEvent} that was fired
   */
  void onValueChange(ValueChangeEvent<T> event);
}