//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * An iterator over a collection supports remove elements.
 */
abstract class RemoveIterator<E> extends Iterator<E> {
  /**
   * Removes from the underlying collection the last element returned
   * by this iterator (optional operation).  This method can be called
   * only once per call to {@link #next}.  The behavior of an iterator
   * is unspecified if the underlying collection is modified while the
   * iteration is in progress in any way other than by calling this
   * method.
  *
   * @throws UnsupportedOperationException if the {@code remove}
   *         operation is not supported by this iterator
  *
   * @throws IllegalStateException if the {@code next} method has not
   *         yet been called, or the {@code remove} method has already
   *         been called after the last call to the {@code next}
   *         method
   */
  void remove();
}