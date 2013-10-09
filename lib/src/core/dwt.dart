//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_core;

/**
 * Supports core functionality that in some cases requires direct support from
 * the compiler and runtime systems such as runtime type information and
 * deferred binding.
 */
class DWT {
  /**
   * Gets the URL prefix that should be prepended to URLs that
   * are intended to be module-relative, such as RPC entry points.
   *
   * <p>If the URL points to an output file of the GWT compiler (such as
   * a file in the public path), use {@link #getModuleBaseForStaticFiles()}
   * instead.</p>
   *
   * @return if non-empty, the base URL is guaranteed to end with a slash
   */
  static String getModuleBaseURL() {
    return Impl.getModuleBaseURL();
  }
  
  // DWT Major version number
  static String get majorVersion => "0.3";
  // DWT Minor version number
  static String get minorVersion => "24";
}
