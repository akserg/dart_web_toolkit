//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * A {@link PlaceHistoryMapper} that can get its {@link PlaceTokenizer}
 * instances from a factory.
 * 
 * @param <F> factory type
 */
abstract class PlaceHistoryMapperWithFactory<F> extends PlaceHistoryMapper {

  /**
   * Sets the factory to be used to generate {@link PlaceTokenizer} instances.
   *
   * @param factory a factory of type F
   */
  void setFactory(F factory);
}