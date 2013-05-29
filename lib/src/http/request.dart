//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_http;

/**
 * An HTTP request that is waiting for a response. Requests can be queried for
 * their pending status or they can be canceled.
 *
 * <h3>Required Module</h3> Modules that use this class should inherit
 * <code>com.google.gwt.http.HTTP</code>.
 *
 * {@gwt.include
 * com/google/gwt/examples/http/InheritsExample.gwt.xml}
 *
 */
class Request {

  /**
   * Creates a {@link Response} instance for the given JavaScript XmlHttpRequest
   * object.
   *
   * @param xmlHttpRequest xmlHttpRequest object for which we need a response
   * @return a {@link Response} object instance
   */
  static Response createResponse(dart_html.HttpRequest xmlHttpRequest) {
    assert (isResponseReady(xmlHttpRequest));
    Response response = new _Response(xmlHttpRequest);
    return response;
  }

  /**
   * Returns an array of headers built by parsing the string of headers returned
   * by the JavaScript <code>XmlHttpRequest</code> object.
   *
   * @param xmlHttpRequest
   * @return array of Header items
   */
  static List<Header> getHeaders(dart_html.HttpRequest xmlHttp) {
    String allHeaders = xmlHttp.getAllResponseHeaders();
    List<String> unparsedHeaders = allHeaders.split("\n");
    List<Header> parsedHeaders = new List<Header>(unparsedHeaders.length);

    for (int i = 0, n = unparsedHeaders.length; i < n; ++i) {
      String unparsedHeader = unparsedHeaders[i];

      if (unparsedHeader.length == 0) {
        continue;
      }

      int endOfNameIdx = unparsedHeader.indexOf(':');
      if (endOfNameIdx < 0) {
        continue;
      }

      String name = unparsedHeader.substring(0, endOfNameIdx).trim();
      String value = unparsedHeader.substring(endOfNameIdx + 1).trim();
      Header header = new _RequestHeader(name, value);

      parsedHeaders[i] = header;
    }

    return parsedHeaders;
  }

  static bool isResponseReady(dart_html.HttpRequest xhr) {
    return xhr.readyState == dart_html.HttpRequest.DONE;
  }


  /**
   * The number of milliseconds to wait for this HTTP request to complete.
   */
  int _timeoutMillis = 0;

  /*
   * Timer used to force HTTPRequest timeouts. If the user has not requested a
   * timeout then this field is null.
   */
  dart_async.Timer _timer;

  /*
   * JavaScript XmlHttpRequest object that this Java class wraps. This field is
   * not final because we transfer ownership of it to the HTTPResponse object
   * and set this field to null.
   */
  dart_html.HttpRequest _xmlHttpRequest;

  /**
   * Only used for building a
   * {@link com.google.gwt.user.client.rpc.impl.FailedRequest}.
   */
  Request.internal();

  /**
   * Constructs an instance of the Request object.
   *
   * @param xmlHttpRequest JavaScript XmlHttpRequest object instance
   * @param timeoutMillis number of milliseconds to wait for a response
   * @param callback callback interface to use for notification
   *
   * @throws IllegalArgumentException if timeoutMillis &lt; 0
   * @throws NullPointerException if xmlHttpRequest, or callback are null
   */
  Request(dart_html.HttpRequest xmlHttpRequest, int timeoutMillis, RequestCallback callback) {
    if (xmlHttpRequest == null) {
      throw new Exception();
    }

    if (callback == null) {
      throw new Exception();
    }

    if (timeoutMillis < 0) {
      throw new Exception();
    }

    this._timeoutMillis = timeoutMillis;

    this._xmlHttpRequest = xmlHttpRequest;

    if (timeoutMillis > 0) {
      // create and start a Timer
      _timer = new dart_async.Timer(new Duration(milliseconds:timeoutMillis), (){
        _fireOnTimeout(callback);
      });
    } else {
      // no Timer required
      _timer = null;
    }
  }

  /**
   * Cancels a pending request. If the request has already been canceled or if
   * it has timed out no action is taken.
   */
  void cancel() {
    /*
     * There is a strange race condition that occurs on Mozilla when you cancel
     * a request while the response is coming in. It appears that in some cases
     * the onreadystatechange handler is still called after the handler function
     * has been deleted and during the call to XmlHttpRequest.abort(). So we
     * null the xmlHttpRequest here and that will prevent the
     * fireOnResponseReceived method from calling the callback function.
     *
     * Setting the onreadystatechange handler to null gives us the correct
     * behavior in Mozilla but crashes IE. That is why we have chosen to fixed
     * this in Java by nulling out our reference to the XmlHttpRequest object.
     */
    if (_xmlHttpRequest != null) {
      dart_html.HttpRequest xmlHttp = _xmlHttpRequest;
      _xmlHttpRequest = null;

      //xmlHttp.onReadyStateChange. readyStateChangeEvent.addListener(listener); // clearOnReadyStateChange();
      xmlHttp.onReadyStateChange.listen(null, onError:null, onDone:null, cancelOnError:true);
      xmlHttp.abort();

      _cancelTimer();
    }
  }

  /**
   * Returns true if this request is waiting for a response.
   *
   * @return true if this request is waiting for a response
   */
  bool isPending() {
    if (_xmlHttpRequest == null) {
      return false;
    }

    int readyState = _xmlHttpRequest.readyState;

    /*
     * Because we are doing asynchronous requests it is possible that we can
     * call XmlHttpRequest.send and still have the XmlHttpRequest.getReadyState
     * method return the state as XmlHttpRequest.OPEN. That is why we include
     * open although it is nottechnically true since open implies that the
     * request has not been sent.
     */
    switch (readyState) {
      case dart_html.HttpRequest.OPENED:
      case dart_html.HttpRequest.HEADERS_RECEIVED:
      case dart_html.HttpRequest.LOADING:
        return true;
    }

    return false;
  }

  /*
   * Method called when the JavaScript XmlHttpRequest object's readyState
   * reaches 4 (LOADED).
   */
  void fireOnResponseReceived(RequestCallback callback) {
    if (_xmlHttpRequest == null) {
      // the request has timed out at this point
      return;
    }

    _cancelTimer();

    /*
     * We cannot use cancel here because it would clear the contents of the
     * JavaScript XmlHttpRequest object so we manually null out our reference to
     * the JavaScriptObject
     */
    dart_html.HttpRequest xhr = _xmlHttpRequest;
    _xmlHttpRequest = null;

    String errorMsg = _getBrowserSpecificFailure(xhr);
    if (errorMsg != null) {
      Exception exception = new Exception(errorMsg);
      callback.onError(this, exception);
    } else {
      Response response = createResponse(xhr);
      callback.onResponseReceived(this, response);
    }
  }

  /*
   * Stops the current HTTPRequest timer if there is one.
   */
  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  /*
   * Method called when this request times out.
   *
   * NOTE: this method is called from JSNI
   */
  void _fireOnTimeout(RequestCallback callback) {
    if (_xmlHttpRequest == null) {
      // the request has been received at this point
      return;
    }

    cancel();

    callback.onError(this, new Exception()); //this, _timeoutMillis));
  }

  /**
   * Tests if the JavaScript <code>XmlHttpRequest.status</code> property is
   * readable. This can return failure in two different known scenarios:
   *
   * <ol>
   * <li>On Mozilla, after a network error, attempting to read the status code
   * results in an exception being thrown. See <a
   * href="https://bugzilla.mozilla.org/show_bug.cgi?id=238559"
   * >https://bugzilla.mozilla.org/show_bug.cgi?id=238559</a>.</li>
   * <li>On Safari, if the HTTP response does not include any response text. See
   * <a
   * href="http://bugs.webkit.org/show_bug.cgi?id=3810">http://bugs.webkit.org
   * /show_bug.cgi?id=3810</a>.</li>
   * </ol>
   *
   * @param xhr the JavaScript <code>XmlHttpRequest</code> object to test
   * @return a String message containing an error message if the
   *         <code>XmlHttpRequest.status</code> code is unreadable or null if
   *         the status code could be successfully read.
   */
  String _getBrowserSpecificFailure(dart_html.HttpRequest xhr) {
    try {
      if (xhr.status == null) {
        return "XmlHttpRequest.status == undefined, please see Safari bug http://bugs.webkit.org/show_bug.cgi?id=3810 for more details";
      }
      return null;
    } on Exception catch (e) {
      return "Unable to read XmlHttpRequest.status; likely causes are a networking error or bad cross-domain request. Please see https://bugzilla.mozilla.org/show_bug.cgi?id=238559 for more details";
    }
  }
}

class _RequestHeader implements Header {

  String _name;
  String _value;

  _RequestHeader(this._name, this._value);

  String getName() {
    return _name;
  }

  String getValue() {
    return _value;
  }

  String toString() {
    return _name + " : " + _value;
  }
}

class _Response implements Response {

  dart_html.HttpRequest _xmlHttpRequest;

  _Response(this._xmlHttpRequest);

  String getHeader(String header) {
    StringValidator.throwIfEmptyOrNull("header", header);

    return _xmlHttpRequest.getResponseHeader(header);
  }

  List<Header> getHeaders() {
    return Request.getHeaders(_xmlHttpRequest);
  }

  String getHeadersAsString() {
    return _xmlHttpRequest.getAllResponseHeaders();
  }

  int getStatusCode() {
    return _xmlHttpRequest.status;
  }

  String getStatusText() {
    return _xmlHttpRequest.statusText;
  }

  String getText() {
    return _xmlHttpRequest.responseText;
  }
}