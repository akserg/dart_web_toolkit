//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Implemented by widgets that pick from a set of values.
 * <p>
 * It is up to the implementation to decide (and document) how to behave when
 * {@link #setValue(Object)} is called with a value that is not in the
 * acceptable set. For example, throwing an {@link IllegalArgumentException}, or
 * quietly adding the value to the acceptable set, are both reasonable choices.
 * 
 * @param <T> the type of value
 */
abstract class HasConstrainedValue<T> extends HasValue<T> {

  /**
   * Set the acceptable values.
   * 
   * @param values the acceptible values
   */
  void setAcceptableValues(Collection<T> values);
}