//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * Maps {@link Place}s to/from tokens, used to configure a
 * {@link PlaceHistoryHandler}.
 * <p>
 * You can annotate subinterfaces of PlaceHistoryMapper with
 * {@link WithTokenizers} to have their implementation automatically generated
 * via a call to {@link com.google.gwt.core.shared.GWT#create(Class)}.
 */
abstract class PlaceHistoryMapper {

  /**
   * Returns the {@link Place} associated with the given token.
   *
   * @param token a String token
   * @return a {@link Place} instance
   */
  Place getPlace(String token);
  
  /**
   * Returns the String token associated with the given {@link Place}.
   *
   * @param place a {@link Place} instance
   * @return a String token
   */
  String getToken(Place place);
}