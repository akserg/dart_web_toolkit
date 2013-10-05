//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Formats and parses numbers using locale-sensitive patterns.
 *
 * This class provides comprehensive and flexible support for a wide variety of
 * localized formats, including
 * <ul>
 * <li><b>Locale-specific symbols</b> such as decimal point, group separator,
 * digit representation, currency symbol, percent, and permill</li>
 * <li><b>Numeric variations</b> including integers ("123"), fixed-point
 * numbers ("123.4"), scientific notation ("1.23E4"), percentages ("12%"), and
 * currency amounts ("$123")</li>
 * <li><b>Predefined standard patterns</b> that can be used both for parsing
 * and formatting, including {@link #getDecimalFormat() decimal},
 * {@link #getCurrencyFormat() currency},
 * {@link #getPercentFormat() percentages}, and
 * {@link #getScientificFormat() scientific}</li>
 * <li><b>Custom patterns</b> and supporting features designed to make it
 * possible to parse and format numbers in any locale, including support for
 * Western, Arabic, and Indic digits</li>
 * </ul>
 *
 * <h3>Patterns</h3>
 * <p>
 * Formatting and parsing are based on customizable patterns that can include a
 * combination of literal characters and special characters that act as
 * placeholders and are replaced by their localized counterparts. Many
 * characters in a pattern are taken literally; they are matched during parsing
 * and output unchanged during formatting. Special characters, on the other
 * hand, stand for other characters, strings, or classes of characters. For
 * example, the '<code>#</code>' character is replaced by a localized digit.
 * </p>
 *
 * <p>
 * Often the replacement character is the same as the pattern character. In the
 * U.S. locale, for example, the '<code>,</code>' grouping character is
 * replaced by the same character '<code>,</code>'. However, the replacement
 * is still actually happening, and in a different locale, the grouping
 * character may change to a different character, such as '<code>.</code>'.
 * Some special characters affect the behavior of the formatter by their
 * presence. For example, if the percent character is seen, then the value is
 * multiplied by 100 before being displayed.
 * </p>
 *
 * <p>
 * The characters listed below are used in patterns. Localized symbols use the
 * corresponding characters taken from corresponding locale symbol collection,
 * which can be found in the properties files residing in the
 * <code><nobr>com.google.gwt.i18n.client.constants</nobr></code>. To insert
 * a special character in a pattern as a literal (that is, without any special
 * meaning) the character must be quoted. There are some exceptions to this
 * which are noted below.
 * </p>
 *
 * <table>
 * <tr>
 * <th>Symbol</th>
 * <th>Location</th>
 * <th>Localized?</th>
 * <th>Meaning</th>
 * </tr>
 *
 * <tr>
 * <td><code>0</code></td>
 * <td>Number</td>
 * <td>Yes</td>
 * <td>Digit</td>
 * </tr>
 *
 * <tr>
 * <td><code>#</code></td>
 * <td>Number</td>
 * <td>Yes</td>
 * <td>Digit, zero shows as absent</td>
 * </tr>
 *
 * <tr>
 * <td><code>.</code></td>
 * <td>Number</td>
 * <td>Yes</td>
 * <td>Decimal separator or monetary decimal separator</td>
 * </tr>
 *
 * <tr>
 * <td><code>-</code></td>
 * <td>Number</td>
 * <td>Yes</td>
 * <td>Minus sign</td>
 * </tr>
 *
 * <tr>
 * <td><code>,</code></td>
 * <td>Number</td>
 * <td>Yes</td>
 * <td>Grouping separator</td>
 * </tr>
 *
 * <tr>
 * <td><code>E</code></td>
 * <td>Number</td>
 * <td>Yes</td>
 * <td>Separates mantissa and exponent in scientific notation; need not be
 * quoted in prefix or suffix</td>
 * </tr>
 *
 * <tr>
 * <td><code>;</code></td>
 * <td>Subpattern boundary</td>
 * <td>Yes</td>
 * <td>Separates positive and negative subpatterns</td>
 * </tr>
 *
 * <tr>
 * <td><code>%</code></td>
 * <td>Prefix or suffix</td>
 * <td>Yes</td>
 * <td>Multiply by 100 and show as percentage</td>
 * </tr>
 *
 * <tr>
 * <td><nobr><code>\u2030</code> (\u005Cu2030)</nobr></td>
 * <td>Prefix or suffix</td>
 * <td>Yes</td>
 * <td>Multiply by 1000 and show as per mille</td>
 * </tr>
 *
 * <tr>
 * <td><nobr><code>\u00A4</code> (\u005Cu00A4)</nobr></td>
 * <td>Prefix or suffix</td>
 * <td>No</td>
 * <td>Currency sign, replaced by currency symbol; if doubled, replaced by
 * international currency symbol; if present in a pattern, the monetary decimal
 * separator is used instead of the decimal separator</td>
 * </tr>
 *
 * <tr>
 * <td><code>'</code></td>
 * <td>Prefix or suffix</td>
 * <td>No</td>
 * <td>Used to quote special characters in a prefix or suffix; for example,
 * <code>"'#'#"</code> formats <code>123</code> to <code>"#123"</code>;
 * to create a single quote itself, use two in succession, such as
 * <code>"# o''clock"</code></td>
 * </tr>
 *
 * </table>
 *
 * <p>
 * A <code>NumberFormat</code> pattern contains a postive and negative
 * subpattern separated by a semicolon, such as
 * <code>"#,##0.00;(#,##0.00)"</code>. Each subpattern has a prefix, a
 * numeric part, and a suffix. If there is no explicit negative subpattern, the
 * negative subpattern is the localized minus sign prefixed to the positive
 * subpattern. That is, <code>"0.00"</code> alone is equivalent to
 * <code>"0.00;-0.00"</code>. If there is an explicit negative subpattern, it
 * serves only to specify the negative prefix and suffix; the number of digits,
 * minimal digits, and other characteristics are ignored in the negative
 * subpattern. That means that <code>"#,##0.0#;(#)"</code> has precisely the
 * same result as <code>"#,##0.0#;(#,##0.0#)"</code>.
 * </p>
 *
 * <p>
 * The prefixes, suffixes, and various symbols used for infinity, digits,
 * thousands separators, decimal separators, etc. may be set to arbitrary
 * values, and they will appear properly during formatting. However, care must
 * be taken that the symbols and strings do not conflict, or parsing will be
 * unreliable. For example, the decimal separator and thousands separator should
 * be distinct characters, or parsing will be impossible.
 * </p>
 *
 * <p>
 * The grouping separator is a character that separates clusters of integer
 * digits to make large numbers more legible. It commonly used for thousands,
 * but in some locales it separates ten-thousands. The grouping size is the
 * number of digits between the grouping separators, such as 3 for "100,000,000"
 * or 4 for "1 0000 0000".
 * </p>
 *
 * <h3>Pattern Grammar (BNF)</h3>
 * <p>
 * The pattern itself uses the following grammar:
 * </p>
 *
 * <table>
 * <tr>
 * <td>pattern</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">subpattern ('<code>;</code>'
 * subpattern)?</td>
 * </tr>
 * <tr>
 * <td>subpattern</td>
 * <td>:=</td>
 * <td>prefix? number exponent? suffix?</td>
 * </tr>
 * <tr>
 * <td>number</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">(integer ('<code>.</code>' fraction)?) |
 * sigDigits</td>
 * </tr>
 * <tr>
 * <td>prefix</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>\u005Cu0000</code>'..'<code>\u005CuFFFD</code>' -
 * specialCharacters</td>
 * </tr>
 * <tr>
 * <td>suffix</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>\u005Cu0000</code>'..'<code>\u005CuFFFD</code>' -
 * specialCharacters</td>
 * </tr>
 * <tr>
 * <td>integer</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>#</code>'* '<code>0</code>'*'<code>0</code>'</td>
 * </tr>
 * <tr>
 * <td>fraction</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>0</code>'* '<code>#</code>'*</td>
 * </tr>
 * <tr>
 * <td>sigDigits</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>#</code>'* '<code>@</code>''<code>@</code>'* '<code>#</code>'*</td>
 * </tr>
 * <tr>
 * <td>exponent</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>E</code>' '<code>+</code>'? '<code>0</code>'* '<code>0</code>'</td>
 * </tr>
 * <tr>
 * <td>padSpec</td>
 * <td>:=</td>
 * <td style="white-space: nowrap">'<code>*</code>' padChar</td>
 * </tr>
 * <tr>
 * <td>padChar</td>
 * <td>:=</td>
 * <td>'<code>\u005Cu0000</code>'..'<code>\u005CuFFFD</code>' - quote</td>
 * </tr>
 * </table>
 *
 * <p>
 * Notation:
 * </p>
 *
 * <table>
 * <tr>
 * <td>X*</td>
 * <td style="white-space: nowrap">0 or more instances of X</td>
 * </tr>
 *
 * <tr>
 * <td>X?</td>
 * <td style="white-space: nowrap">0 or 1 instances of X</td>
 * </tr>
 *
 * <tr>
 * <td>X|Y</td>
 * <td style="white-space: nowrap">either X or Y</td>
 * </tr>
 *
 * <tr>
 * <td>C..D</td>
 * <td style="white-space: nowrap">any character from C up to D, inclusive</td>
 * </tr>
 *
 * <tr>
 * <td>S-T</td>
 * <td style="white-space: nowrap">characters in S, except those in T</td>
 * </tr>
 * </table>
 *
 * <p>
 * The first subpattern is for positive numbers. The second (optional)
 * subpattern is for negative numbers.
 * </p>
 *
 *  <h3>Example</h3> {@example com.google.gwt.examples.NumberFormatExample}
 *
 *
 */
class NumberFormat {

  static NumberFormat _cachedDecimalFormat;

  static NumberFormat getDecimalFormat() {
    if (_cachedDecimalFormat == null) {
      _cachedDecimalFormat = new NumberFormat._internal();
    }
    return _cachedDecimalFormat;
  }

  NumberFormat._internal();

  /**
   * This method formats a double to produce a string.
   *
   * @param number The double to format
   * @return the formatted number string
   */
  String formatDouble(double number) {
    if (number.isNaN) {
      return "NaN";
    }
    return number.toString();
  }

  /**
   * This method formats a Number to produce a string.
   * <p>
   * Any {@link Number} which is not a {@link BigDecimal}, {@link BigInteger},
   * or {@link Long} instance is formatted as a {@code double} value.
   *
   * @param number The Number instance to format
   * @return the formatted number string
   */
  String formatInt(int number) {
    if (number.isNaN) {
      return "NaN";
    }
    return number.toString();
  }

  /**
   * This method formats a Number to produce a string.
   * <p>
   * Any {@link Number} which is not a {@link BigDecimal}, {@link BigInteger},
   * or {@link Long} instance is formatted as a {@code double} value.
   *
   * @param number The Number instance to format
   * @return the formatted number string
   */
  String format(num number) {
    if (number is int) {
      return formatInt(number as int);
    } else {
      return formatDouble(number as double);
    }
    throw new Exception("Unknown type");
  }
}
