//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_http;

/**
 * Class for describing an HTTP header.
 * 
 * <h3>Required Module</h3>
 * Modules that use this class should inherit
 * <code>com.google.gwt.http.HTTP</code>.
 * 
 * {@gwt.include com/google/gwt/examples/http/InheritsExample.gwt.xml}
 */
abstract class Header {
  /**
   * Returns the name of the HTTP header.
   * 
   * @return name of the HTTP header 
   */
  String getName();
  
  /**
   * Returns the value of the HTTP header.
   * 
   * @return value of the HTTP header 
   */
  String getValue();
}
