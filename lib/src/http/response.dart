//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_http;

/**
 * Wrapper which provides access to the components of an HTTP response.
 * 
 * <h3>Required Module</h3>
 * Modules that use this class should inherit
 * <code>com.google.gwt.http.HTTP</code>.
 * 
 * {@gwt.include com/google/gwt/examples/http/InheritsExample.gwt.xml}
 */
abstract class Response {

  /**
   * Returns the value of the requested header or null if the header was not
   * specified.
   * 
   * @param header the header to query for
   * @return the value of response header
   * 
   * @throws IllegalArgumentException if the header name is empty
   * @throws NullPointerException if the header name is null
   */
  String getHeader(String header);

  /**
   * Returns an array of HTTP headers associated with this response.
   * 
   * @return array of HTTP headers; returns zero length array if there are no
   *         headers
   */
  List<Header> getHeaders();

  /**
   * Returns all headers as a single string. The individual headers are
   * delimited by a CR (U+000D) LF (U+000A) pair. An individual header is
   * formatted according to <a href="http://ietf.org/rfc/rfc2616"> RFC 2616</a>.
   * 
   * @return all headers as a single string delimited by CRLF pairs
   */
  String getHeadersAsString();

  /**
   * Returns the HTTP status code that is part of this response.
   * 
   * @return the HTTP status code
   */
  int getStatusCode();

  /**
   * Returns the HTTP status message text.
   * 
   * @return the HTTP status message text
   */
  String getStatusText();

  /**
   * Returns the text associated with the response.
   * 
   * @return the response text
   */
  String getText();
}
