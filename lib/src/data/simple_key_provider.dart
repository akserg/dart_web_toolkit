//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_data;

/**
 * Simple passthrough implementation of {@link ProvidesKey}.
 * 
 * @param <T> the data type of records 
 */
class SimpleKeyProvider<T> implements ProvidesKey<T> {

  /**
   * Return the passed-in item.
   */
  Object getKey(T item) {
    return item;
  }
}
