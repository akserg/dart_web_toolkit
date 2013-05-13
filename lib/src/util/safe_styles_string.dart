//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Util library.
 */
part of dart_web_toolkit_util;

/**
 * A string wrapped as an object of type {@link SafeStyles}.
 * 
 * <p>
 * This class is package-private and intended for internal use by the
 * {@link com.google.gwt.safecss} package.
 * 
 * <p>
 * All implementors must implement .equals and .hashCode so that they operate
 * just like String.equals() and String.hashCode().
 */
class SafeStylesString implements SafeStyles {

  String _css;

  /**
   * Constructs a {@link SafeStylesString} from a string. Callers are
   * responsible for ensuring that the string passed as the argument to this
   * constructor satisfies the constraints of the contract imposed by the
   * {@link SafeStyles} interface.
   * 
   * @param css the string to be wrapped as a {@link SafeStyles}
   */
  SafeStylesString(String css) {
    SafeStylesUtils.verifySafeStylesConstraints(css);
    this._css = css;
  }

  /**
   * {@inheritDoc}
   */
  String asString() {
    return _css;
  }

  /**
   * Compares this string to the specified object.
   */
  bool operator ==(Object obj) {
    if (!(obj is SafeStyles)) {
      return false;
    }
    return _css == (obj as SafeStyles).asString();
  }
}