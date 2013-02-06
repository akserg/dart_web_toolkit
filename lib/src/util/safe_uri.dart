//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * An object that implements this interface encapsulates a URI that is
 * guaranteed to be safe to use (with respect to potential Cross-Site-Scripting
 * vulnerabilities) in a URL context, for example in a URL-typed attribute in an
 * HTML document.
 *
 * <p>
 * Note on usage: SafeUri should be used to ensure user input is not executed in
 * the browser. SafeUri should not be used to sanitize input before sending it
 * to the server: The server cannot rely on the type contract of SafeUri values
 * received from clients, because a malicious client could provide maliciously
 * crafted serialized forms of implementations of this type that violate the
 * type contract.
 *
 * <p>
 * All implementing classes must maintain the class invariant (by design and
 * implementation and/or convention of use), that invoking {@link #asString()}
 * on any instance will return a string that is safe to assign to a URL-typed
 * DOM or CSS property in a browser (or to use similarly in a "URL context"), in
 * the sense that doing so must not cause unintended execution of script in the
 * browser.
 *
 * <p>
 * In determining safety of a URL both the value itself as well as its
 * provenance matter. An arbitrary URI, including e.g. a
 * <code>javascript:</code> URI, can be deemed safe in the sense of this type's
 * contract if it is entirely under the program's control (e.g., a string
 * literal, {@see UriUtils#fromSafeConstant}).
 *
 * <p>
 * All implementations must implement equals() and hashCode() to behave
 * consistently with the result of asString().equals() and asString.hashCode().
 *
 * <p>
 * Implementations must not return {@code null} from {@link #asString()}.
 *
 * @see UriUtils
 */
abstract class SafeUri {
  /**
   * Returns this object's contained URI as a string.
   *
   * <p>
   * Based on this class' contract, the returned value will be non-null and a
   * string that is safe to use in a URL context.
   *
   * @return the contents as a String
   */
  String asString();

  /**
   * Compares this string to the specified object. Must be equal to
   * asString().equals().
   *
   * @param anObject the object to compare to
   */
  bool operator ==(Object obj);
}

/**
 * A string wrapped as an object of type {@link SafeUri}.
 *
 * <p>
 * This class is package-private and intended for internal use by the
 * {@link com.google.gwt.safehtml} package.
 *
 * All implementors must implement .equals and .hashCode so that they operate
 * just like String.equals() and String.hashCode().
 */
class SafeUriString implements SafeUri {

  String _uri;

  /**
   * Constructs a {@link SafeUriString} from a string. Callers are responsible
   * for ensuring that the string passed as the argument to this constructor
   * satisfies the constraints of the contract imposed by the {@link SafeUri}
   * interface.
   *
   * @param uri the string to be wrapped as a {@link SafeUri}
   */
  SafeUriString(this._uri) {
    assert(this._uri != null);
  }

  /**
   * {@inheritDoc}
   */
  String asString() {
    return _uri;
  }

  /**
   * Compares this string to the specified object.
   */
  bool operator ==(Object obj) {
    if (!(obj is SafeUri)) {
      return false;
    }
    return (obj as SafeUri).asString() == _uri;
  }

  /**
   * Returns a hash code for this string.
   */
  int get hashCode => _uri.hashCode;
}

