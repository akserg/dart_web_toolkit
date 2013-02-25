//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Base class for {@link BidiFormatter} and {@link SafeHtmlBidiFormatter} that
 * contains their common implementation.
 */
abstract class BidiFormatterBase {

  bool alwaysSpan;
  Direction contextDir;

  BidiFormatterBase(this.contextDir, this.alwaysSpan);

  /**
   * @see BidiFormatter#spanWrapWithKnownDir(HasDirection.Direction, String, boolean, boolean)
   *
   * @param dir {@code str}'s direction
   * @param str The input string
   * @param isHtml Whether {@code str} is HTML / HTML-escaped
   * @param dirReset Whether to append a trailing unicode bidi mark matching the
   *          context direction, when needed, to prevent the possible garbling
   *          of whatever may follow {@code str}
   * @return Input string after applying the above processing.
   */
  String spanWrapWithKnownDirBase(Direction dir, String str, bool isHtml, bool dirReset) {
    bool dirCondition = dir != Direction.DEFAULT && dir != contextDir;
    String origStr = str;
//    if (!isHtml) {
//      str = SafeHtmlUtils.htmlEscape(str);
//    }

    StringBuffer result = new StringBuffer();
    if (alwaysSpan || dirCondition) {
      result.write("<span");
      if (dirCondition) {
        result.write(" ");
        result.write(dir == Direction.RTL ? "dir=rtl" : "dir=ltr");
      }
      result.write(">");
      result.write(str);
      result.write("</span>");
    } else {
      result.write(str);
    }
    // origStr is passed (more efficient when isHtml is false).
    result.write(dirResetIfNeeded(origStr, dir, isHtml, dirReset));
    return result.toString();
  }

  /**
   * Returns a unicode BiDi mark matching the context direction (LRM or RLM) if
   * {@code dirReset}, and if the overall direction or the exit direction of
   * {@code str} are opposite to the context direction. Otherwise returns the
   * empty string.
   *
   * @param str The input string
   * @param dir {@code str}'s overall direction
   * @param isHtml Whether {@code str} is HTML / HTML-escaped
   * @param dirReset Whether to perform the reset
   * @return A unicode BiDi mark or the empty string.
   */
  String dirResetIfNeeded(String str, Direction dir, bool isHtml, bool dirReset) {
    // endsWithRtl and endsWithLtr are called only if needed (short-circuit).
    if (dirReset
        && ((contextDir == Direction.LTR &&
            (dir == Direction.RTL ||
             BidiUtils.get().endsWithRtl(str, isHtml))) ||
            (contextDir == Direction.RTL &&
            (dir == Direction.LTR ||
             BidiUtils.get().endsWithLtr(str, isHtml))))) {
      return contextDir == Direction.LTR ? Format.LRM_STRING : Format.RLM_STRING;
    } else {
      return "";
    }
  }
}

/**
 * A container class for direction-related string constants, e.g. Unicode
 * formatting characters.
 */
abstract class Format {
  /**
   * "left" string constant.
   */
  static final String LEFT = "left";

  /**
   * Unicode "Left-To-Right Embedding" (LRE) character.
   */
  static final int LRE = int.parse('\u202A');

  /**
   * Unicode "Left-To-Right Mark" (LRM) character.
   */
  static final int LRM = int.parse('\u200E');

  /**
   * String representation of LRM.
   */
  static final String LRM_STRING = new String.fromCharCodes([LRM]);

  /**
   * Unicode "Pop Directional Formatting" (PDF) character.
   */
  static final int PDF = int.parse('\u202C');

  /**
   * "right" string constant.
   */
  static final String RIGHT = "right";

  /**
   * Unicode "Right-To-Left Embedding" (RLE) character.
   */
  static final int RLE = int.parse('\u202B');

  /**
   * Unicode "Right-To-Left Mark" (RLM) character.
   */
  static final int RLM = int.parse('\u200F');

  /**
   * String representation of RLM.
   */
  static final String RLM_STRING = new String.fromCharCodes([RLM]);
}
