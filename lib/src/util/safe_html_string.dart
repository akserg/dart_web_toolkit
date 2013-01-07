//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * A string wrapped as an object of type {@link SafeHtml}.
 *
 * <p>
 * This class is package-private and intended for internal use by the
 * {@link com.google.gwt.safehtml} package.
 *
 * <p>
 * All implementors must implement .equals and .hashCode so that they operate
 * just like String.equals() and String.hashCode().
 */
class SafeHtmlString implements SafeHtml {

  String _html;

  /**
   * Constructs a {@link SafeHtmlString} from a string. Callers are responsible
   * for ensuring that the string passed as the argument to this constructor
   * satisfies the constraints of the contract imposed by the {@link SafeHtml}
   * interface.
   *
   * @param html the string to be wrapped as a {@link SafeHtml}
   */
  SafeHtmlString(String html) {
    if (_html == null) {
      throw new Exception("html is null");
    }
    this._html = html;
  }

//  /**
//   * No-arg constructor for compatibility with GWT serialization.
//   */
//  @SuppressWarnings("unused")
//  private SafeHtmlString() {
//  }

  /**
   * {@inheritDoc}
   */
  String asString() {
    return _html;
  }

  /**
   * Compares this string to the specified object.
   */
  bool operator ==(Object obj) {
    if (!(obj is SafeHtml)) {
      return false;
    }
    return _html == (obj as SafeHtml).asString();
  }

  /**
   * Returns a hash code for this string.
   */
  int get hashCode => _html.hashCode;
}
