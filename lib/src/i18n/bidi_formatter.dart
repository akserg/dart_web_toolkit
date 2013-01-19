//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;


/**
 * Utility class for formatting text for display in a potentially
 * opposite-direction context without garbling. The direction of the context is
 * set at formatter creation and the direction of the text can be either
 * estimated or passed in when known. Provides the following functionality:
 * <p>
 * 1. BiDi Wrapping: When text in one language is mixed into a document in
 * another, opposite-direction language, e.g. when an English business name is
 * embedded in a Hebrew web page, both the inserted string and the text
 * following it may be displayed incorrectly unless the inserted string is
 * explicitly separated from the surrounding text in a "wrapper" that declares
 * its direction at the start and then resets it back at the end. This wrapping
 * can be done in HTML mark-up (e.g. a 'span dir=rtl' tag) or - only in contexts
 * where mark-up cannot be used - in Unicode BiDi formatting codes (LRE|RLE and
 * PDF). Optionally, the mark-up can be inserted even when the direction is the
 * same, in order to keep the DOM structure more stable. Providing such wrapping
 * services is the basic purpose of the BiDi formatter.
 * <p>
 * 2. Direction estimation: How does one know whether a string about to be
 * inserted into surrounding text has the same direction? Well, in many cases,
 * one knows that this must be the case when writing the code doing the
 * insertion, e.g. when a localized message is inserted into a localized page.
 * In such cases there is no need to involve the BiDi formatter at all. In some
 * other cases, it need not be the same as the context, but is either constant
 * (e.g. urls are always LTR) or otherwise known. In the remaining cases, e.g.
 * when the string is user-entered or comes from a database, the language of the
 * string (and thus its direction) is not known a priori, and must be estimated
 * at run-time. The BiDi formatter can do this automatically.
 * <p>
 * 3. Escaping: When wrapping plain text - i.e. text that is not already HTML or
 * HTML-escaped - in HTML mark-up, the text must first be HTML-escaped to
 * prevent XSS attacks and other nasty business. This of course is always true,
 * but the escaping can not be done after the string has already been wrapped in
 * mark-up, so the BiDi formatter also serves as a last chance and includes
 * escaping services.
 * <p>
 * Thus, in a single call, the formatter will escape the input string as
 * specified, determine its direction, and wrap it as necessary. It is then up
 * to the caller to insert the return value in the output.
 *
 */
class BidiFormatter extends BidiFormatterBase {

  /**
   * Factory for creating an instance of BidiFormatter given the context
   * direction and the desired span wrapping behavior (see below).
   *
   * @param rtlContext Whether the context direction is RTL. See an example of
   *          a simple use case at {@link #getInstance(boolean)}
   * @param alwaysSpan Whether {@link #spanWrap} (and its variations) should
   *          always use a 'span' tag, even when the input direction is neutral
   *          or matches the context, so that the DOM structure of the output
   *          does not depend on the combination of directions
   */
  static BidiFormatter getInstance(bool rtlContext, [bool alwaysSpan = false]) {
    return new BidiFormatter(rtlContext ? Direction.RTL : Direction.LTR, alwaysSpan);
  }

  /**
   * Factory for creating an instance of BidiFormatter whose context direction
   * matches the current locale's direction, and given the desired span wrapping
   * behavior (see below).
   *
   * @param alwaysSpan Whether {@link #spanWrap} (and its variations) should
   *          always use a 'span' tag, even when the input direction is neutral
   *          or matches the context, so that the DOM structure of the output
   *          does not depend on the combination of directions
   */
  static BidiFormatter getInstanceForCurrentLocale([bool alwaysSpan = false]) {
    return getInstance(LocaleInfo.getCurrentLocale().isRTL(), alwaysSpan);
  }

  /**
   * @param contextDir The context direction
   * @param alwaysSpan Whether {@link #spanWrap} (and its variations) should
   *          always use a 'span' tag, even when the input direction is neutral
   *          or matches the context, so that the DOM structure of the output
   *          does not depend on the combination of directions
   */
  BidiFormatter(Direction contextDir, bool alwaysSpan) : super(contextDir, alwaysSpan);

  /**
   * Formats a string of given direction for use in HTML output of the context
   * direction, so an opposite-direction string is neither garbled nor garbles
   * what follows it.
   * <p>
   * The algorithm: estimates the direction of input argument {@code str}. In
   * case its direction doesn't match the context direction, wraps it with a
   * 'span' tag and adds a "dir" attribute (either 'dir=rtl' or 'dir=ltr').
   * <p>
   * If {@code setAlwaysSpan(true)} was used, the input is always wrapped with
   * 'span', skipping just the dir attribute when it's not needed.
   * <p>
   * If {@code dirReset}, and if the overall direction or the exit direction of
   * {@code str} are opposite to the context direction, a trailing unicode BiDi
   * mark matching the context direction is appended (LRM or RLM).
   * <p>
   * If !{@code isHtml}, HTML-escapes {@code str} regardless of wrapping.
   *
   * @param dir {@code str}'s direction
   * @param str The input string
   * @param isHtml Whether {@code str} is HTML / HTML-escaped
   * @param dirReset Whether to append a trailing unicode bidi mark matching the
   *          context direction, when needed, to prevent the possible garbling
   *          of whatever may follow {@code str}
   * @return Input string after applying the above processing.
   */
  String spanWrapWithKnownDir(Direction dir, String str, [bool isHtml = false, bool dirReset = true]) {
    return spanWrapWithKnownDirBase(dir, str, isHtml, dirReset);
  }
}
