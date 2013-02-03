//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_data;

/**
 * <p>
 * Implementors of {@link ProvidesKey} provide a key for list items, such that
 * items that are to be treated as distinct (for example, for editing) have
 * distinct keys.
 * </p>
 * <p>
 * The key must implement a coherent set of {@link Object#equals(Object)} and
 * {@link Object#hashCode()} methods such that if objects {@code A} and {@code
 * B} are to be treated as identical, then {@code A.equals(B)}, {@code
 * B.equals(A)}, and {@code A.hashCode() == B.hashCode()}. If {@code A} and
 * {@code B} are to be treated as unequal, then it must be the case that {@code
 * A.equals(B) == false} and {@code B.equals(A) == false}.
 * </p>
 * 
 * @param <T> the data type of records in the list
 */
abstract class ProvidesKey<T> {

  /**
   * Get the key for a list item.
   *
   * @param item the list item
   * @return the key that represents the item
   */
  Object getKey(T item);
}
