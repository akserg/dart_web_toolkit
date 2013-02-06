//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_resource;

/**
 * The base interface all bundle resource types must extend.
 */
abstract class ResourcePrototype {
  /**
   * Returns the name of the function within the ClientBundle used to create the
   * ResourcePrototype.
   * 
   * @return the name of the function within the ClientBundle used to create the
   *         ResourcePrototype
   */
  String get name;
}
