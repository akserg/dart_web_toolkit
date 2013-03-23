//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_place;

/**
 * Represents a bookmarkable location in an app. Implementations are expected to
 * provide correct {@link Object#equals(Object)} and {@link Object#hashCode()}
 * methods.
 */
abstract class Place {

  /**
   * The null place.
   */
  static final Place NOWHERE = new _Place();

}

class _Place implements Place {
  
}