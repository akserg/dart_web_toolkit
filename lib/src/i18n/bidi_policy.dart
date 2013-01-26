//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Provides low-level functionality to determine whether to support bidi.
 */
class BidiPolicy {

  static BidiPolicyImpl impl = new BidiPolicyImpl();

  /**
   * Returns true if bidi is enabled, false if disabled.
   */
  static bool isBidiEnabled() {
    return impl.isBidiEnabled();
  }
}

/**
 * Implementation class for {@link BidiPolicy}.
 */
class BidiPolicyImpl {
  bool isBidiEnabled() {
    return LocaleInfo.hasAnyRTL();
  }
}

/**
 * Implementation class for {@link BidiPolicy} used when bidi is always on.
 */
class BidiPolicyImplOn extends BidiPolicyImpl {
  bool isBidiEnabled() {
    return true;
  }
}