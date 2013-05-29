//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_http;

/**
 * Builder for constructing {@link com.google.gwt.http.client.Request} objects.
 * 
 * <h3>Required Module</h3> Modules that use this class should inherit
 * <code>com.google.gwt.http.HTTP</code>.
 * 
 * {@gwt.include
 * com/google/gwt/examples/http/InheritsExample.gwt.xml}
 * 
 */
class RequestBuilder {
  /**
   * Specifies that the HTTP DELETE method should be used.
   */
  static final Method DELETE = new Method("DELETE");

  /**
   * Specifies that the HTTP GET method should be used.
   */
  static final Method GET = new Method("GET");

  /**
   * Specifies that the HTTP HEAD method should be used.
   */
  static final Method HEAD = new Method("HEAD");

  /**
   * Specifies that the HTTP POST method should be used.
   */
  static final Method POST = new Method("POST");

  /**
   * Specifies that the HTTP PUT method should be used.
   */
  static final Method PUT = new Method("PUT");

  /**
   * The callback to call when the request completes.
   */
  RequestCallback _callback;

  /**
   * Map of header name to value that will be added to the JavaScript
   * XmlHttpRequest object before sending a request.
   */
   Map<String, String> _headers;

  /**
   * HTTP method to use when opening a JavaScript XmlHttpRequest object.
   */
   String _httpMethod;

  /**
   * Password to use when opening a JavaScript XmlHttpRequest object.
   */
  String _password;

  /**
   * Request data to use when sending a JavaScript XmlHttpRequest object.
   */
  String _requestData;

  /**
   * Timeout in milliseconds before the request timeouts and fails.
   */
  int _timeoutMillis;

  /**
   * URL to use when opening a JavaScript XmlHttpRequest object.
   */
  String _url;

  /**
   * User to use when opening a JavaScript XmlHttpRequest object.
   */
  String _user;

  /**
   * Creates a builder using the parameters for configuration.
   * 
   * @param httpMethod HTTP method to use for the request
   * @param url URL that has already has already been encoded. Please see
   *          {@link com.google.gwt.http.client.URL#encode(String)},
   *          {@link com.google.gwt.http.client.URL#encodePathSegment(String)} and
   *          {@link com.google.gwt.http.client.URL#encodeQueryString(String)} for
   *          how to do this.
   * @throws IllegalArgumentException if the httpMethod or URL are empty
   * @throws NullPointerException if the httpMethod or the URL are null
   */
  RequestBuilder.fromMethod(Method httpMethod, String url) : this((httpMethod == null) ? null : httpMethod.toString(), url);

  /**
   * Creates a builder using the parameters values for configuration.
   * 
   * @param httpMethod HTTP method to use for the request
   * @param url URL that has already has already been URL encoded. Please see
   *          {@link com.google.gwt.http.client.URL#encode(String)} and
   *          {@link com.google.gwt.http.client.URL#encodePathSegment(String)} and
   *          {@link com.google.gwt.http.client.URL#encodeQueryString(String)} for
   *          how to do this.
   * @throws IllegalArgumentException if the httpMethod or URL are empty
   * @throws NullPointerException if the httpMethod or the URL are null
   */
  RequestBuilder(this._httpMethod, this._url) {

    StringValidator.throwIfEmptyOrNull("httpMethod", _httpMethod);
    StringValidator.throwIfEmptyOrNull("url", _url);
  }

  /**
   * Returns the callback previously set by
   * {@link #setCallback(RequestCallback)}, or <code>null</code> if no callback
   * was set.
   */
  RequestCallback getCallback() {
    return _callback;
  }

  /**
   * Returns the value of a header previous set by
   * {@link #setHeader(String, String)}, or <code>null</code> if no such header
   * was set.
   * 
   * @param header the name of the header
   */
  String getHeader(String header) {
    if (_headers == null) {
      return null;
    }
    return _headers[header];
  }

  /**
   * Returns the HTTP method specified in the constructor.
   */
  String getHTTPMethod() {
    return _httpMethod;
  }

  /**
   * Returns the password previously set by {@link #setPassword(String)}, or
   * <code>null</code> if no password was set.
   */
  String getPassword() {
    return _password;
  }

  /**
   * Returns the requestData previously set by {@link #setRequestData(String)},
   * or <code>null</code> if no requestData was set.
   */
  String getRequestData() {
    return _requestData;
  }

  /**
   * Returns the timeoutMillis previously set by {@link #setTimeoutMillis(int)},
   * or <code>0</code> if no timeoutMillis was set.
   */
  int getTimeoutMillis() {
    return _timeoutMillis;
  }

  /**
   * Returns the HTTP URL specified in the constructor.
   */
  String getUrl() {
    return _url;
  }

  /**
   * Returns the user previously set by {@link #setUser(String)}, or
   * <code>null</code> if no user was set.
   */
  String getUser() {
    return _user;
  }

  /**
   * Sends an HTTP request based on the current builder configuration. If no
   * request headers have been set, the header "Content-Type" will be used with
   * a value of "text/plain; charset=utf-8". You must call
   * {@link #setRequestData(String)} and {@link #setCallback(RequestCallback)}
   * before calling this method.
   * 
   * @return a {@link Request} object that can be used to track the request
   * @throws RequestException if the call fails to initiate
   * @throws NullPointerException if a request callback has not been set
   */
  Request send() {
    StringValidator.throwIfNull("callback", _callback);
    return _doSend(_requestData, _callback);
  }

  /**
   * Sends an HTTP request based on the current builder configuration with the
   * specified data and callback. If no request headers have been set, the
   * header "Content-Type" will be used with a value of "text/plain;
   * charset=utf-8". This method does not cache <code>requestData</code> or
   * <code>callback</code>.
   * 
   * @param requestData the data to send as part of the request
   * @param callback the response handler to be notified when the request fails
   *          or completes
   * @return a {@link Request} object that can be used to track the request
   * @throws NullPointerException if <code>callback</code> <code>null</code>
   */
  Request sendRequest(String requestData, RequestCallback callback) {
    StringValidator.throwIfNull("callback", callback);
    return _doSend(requestData, callback);
  }

  /**
   * Sets the response handler for this request. This method <b>must</b> be
   * called before calling {@link #send()}.
   * 
   * @param callback the response handler to be notified when the request fails
   *          or completes
   * 
   * @throws NullPointerException if <code>callback</code> is <code>null</code>
   */
  void setCallback(RequestCallback callback) {
    StringValidator.throwIfNull("callback", callback);

    this._callback = callback;
  }

  /**
   * Sets a request header with the given name and value. If a header with the
   * specified name has already been set then the new value overwrites the
   * current value.
   * 
   * @param header the name of the header
   * @param value the value of the header
   * 
   * @throws NullPointerException if header or value are null
   * @throws IllegalArgumentException if header or value are the empty string
   */
  void setHeader(String header, String value) {
    StringValidator.throwIfEmptyOrNull("header", header);
    StringValidator.throwIfEmptyOrNull("value", value);

    if (_headers == null) {
      _headers = new Map<String, String>();
    }

    _headers[header] = value;
  }

  /**
   * Sets the password to use in the request URL. This is ignored if there is no
   * user specified.
   * 
   * @param password password to use in the request URL
   * 
   * @throws IllegalArgumentException if the password is empty
   * @throws NullPointerException if the password is null
   */
  void setPassword(String password) {
    StringValidator.throwIfEmptyOrNull("password", password);

    this._password = password;
  }

  /**
   * Sets the data to send as part of this request. This method <b>must</b> be
   * called before calling {@link #send()}.
   * 
   * @param requestData the data to send as part of the request
   */
  void setRequestData(String requestData) {
    this._requestData = requestData;
  }

  /**
   * Sets the number of milliseconds to wait for a request to complete. Should
   * the request timeout, the
   * {@link com.google.gwt.http.client.RequestCallback#onError(Request, Throwable)}
   * method will be called on the callback instance given to the
   * {@link com.google.gwt.http.client.RequestBuilder#sendRequest(String, RequestCallback)}
   * method. The callback method will receive an instance of the
   * {@link com.google.gwt.http.client.RequestTimeoutException} class as its
   * {@link java.lang.Throwable} argument.
   * 
   * @param timeoutMillis number of milliseconds to wait before canceling the
   *          request, a value of zero disables timeouts
   * 
   * @throws IllegalArgumentException if the timeout value is negative
   */
  void setTimeoutMillis(int timeoutMillis) {
    if (timeoutMillis < 0) {
      throw new Exception("Timeouts cannot be negative");
    }

    this._timeoutMillis = timeoutMillis;
  }

  /**
   * Sets the user name that will be used in the request URL.
   * 
   * @param user user name to use
   * @throws IllegalArgumentException if the user is empty
   * @throws NullPointerException if the user is null
   */
  void setUser(String user) {
    StringValidator.throwIfEmptyOrNull("user", user);

    this._user = user;
  }

  /**
   * Sends an HTTP request based on the current builder configuration. If no
   * request headers have been set, the header "Content-Type" will be used with
   * a value of "text/plain; charset=utf-8".
   * 
   * @return a {@link Request} object that can be used to track the request
   * @throws RequestException if the call fails to initiate
   * @throws NullPointerException if request data has not been set
   * @throws NullPointerException if a request callback has not been set
   */
  Request _doSend(String requestData, RequestCallback callback) {
    dart_html.HttpRequest xmlHttpRequest = new dart_html.HttpRequest();

    try {
      if (_user != null && _password != null) {
        xmlHttpRequest.open(_httpMethod, _url, async:true, user:_user, password:_password);
      } else if (_user != null) {
        xmlHttpRequest.open(_httpMethod, _url, async:true, user:_user);
      } else {
        xmlHttpRequest.open(_httpMethod, _url);
      }
    } on Exception catch (e) {
      throw new Exception("The URL $_url is invalid or violates the same-origin security restriction");
    }

    _setHeaders(xmlHttpRequest);

    Request request = new Request(xmlHttpRequest, _timeoutMillis, callback);

    // Must set the onreadystatechange handler before calling send().
    xmlHttpRequest.onReadyStateChange.listen((dart_html.Event evt){
      if (xmlHttpRequest.readyState == dart_html.HttpRequest.DONE) {
        xmlHttpRequest.onReadyStateChange.listen(null, onError:null, onDone:null, cancelOnError:true);
        request.fireOnResponseReceived(callback);
      }
    });

    try {
      xmlHttpRequest.send(requestData);
    } on Exception catch (e) {
      throw new Exception(e.toString());
    }

    return request;
  }

  /*
   * Internal method that actually sets our cached headers on the underlying
   * JavaScript XmlHttpRequest object. If there are no headers set, then we set
   * the "Content-Type" to "text/plain; charset=utf-8". This is really lining us
   * up for integration with RPC.
   */
  void _setHeaders(dart_html.HttpRequest xmlHttpRequest) {
    if (_headers != null && _headers.length > 0) {
      for (String header in _headers.keys) {
        try {
          xmlHttpRequest.setRequestHeader(header, _headers[header]);
        } on Exception catch (e) {
          throw new Exception(e.toString());
        }
      }
    } else {
      xmlHttpRequest.setRequestHeader("Content-Type", "text/plain; charset=utf-8");
    }
  }
}

/**
 * HTTP request method constants.
 */
class Method {
  final String _name;

  Method(this._name);

  String toString() {
    return _name;
  }
}