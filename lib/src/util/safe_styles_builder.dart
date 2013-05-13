//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Util library.
 */
part of dart_web_toolkit_util;

/**
 * A builder that facilitates the building up of XSS-safe CSS attribute strings
 * from {@link SafeStyles}. It is used essentially like a {@link StringBuffer},
 * but access {@link SafeStyles} instead of Strings.
 * 
 * <p>
 * The accumulated XSS-safe {@link SafeStyles} can be obtained in the form of a
 * {@link SafeStyles} via the {@link #toSafeStyles()} method.
 * 
 * <p>
 * This class is not thread-safe.
 */
class SafeStylesBuilder {

  final StringBuffer _sb = new StringBuffer();

  /**
   * Constructs an empty {@link SafeStylesBuilder}.
   */
  SafeStylesBuilder() {
  }

  /**
   * Appends the contents of another {@link SafeStyles} object, without applying
   * any escaping or sanitization to it.
   * 
   * @param styles the {@link SafeStyles} to append
   * @return a reference to this object
   */
  SafeStylesBuilder append(SafeStyles styles) {
    _sb.write(styles.asString());
    return this;
  }

  /**
   * <p>
   * Appends {@link SafeStyles} constructed from a trusted string, i.e., without
   * escaping the string. Only minimal checks are performed. The calling code
   * should be carefully reviewed to ensure the argument meets the
   * {@link SafeStyles} contract.
   * 
   * <p>
   * Generally, {@link SafeStyles} should be of the form
   * {@code cssPropertyName:value;}, where neither the name nor the value
   * contain malicious scripts.
   * 
   * <p>
   * {@link SafeStyles} may never contain literal angle brackets. Otherwise, it
   * could be unsafe to place a {@link SafeStyles} into a &lt;style&gt; tag
   * (where it can't be HTML escaped). For example, if the {@link SafeStyles}
   * containing "
   * <code>font: 'foo &lt;style&gt;&lt;script&gt;evil&lt;/script&gt;</code>'" is
   * used in a style sheet in a &lt;style&gt; tag, this could then break out of
   * the style context into HTML.
   * 
   * <p>
   * The following example values comply with this type's contract:
   * <ul>
   * <li><code>width: 1em;</code></li>
   * <li><code>height:1em;</code></li>
   * <li><code>width: 1em;height: 1em;</code></li>
   * <li><code>background:url('http://url');</code></li>
   * </ul>
   * In addition, the empty string is safe for use in a CSS attribute.
   * 
   * <p>
   * The following example values do <em>not</em> comply with this type's
   * contract:
   * <ul>
   * <li><code>background: red</code> (missing a trailing semi-colon)</li>
   * <li><code>background:</code> (missing a value and a trailing semi-colon)</li>
   * <li><code>1em</code> (missing an attribute name, which provides context for
   * the value)</li>
   * </ul>
   * 
   * @param styles the input String
   * @return a {@link SafeStyles} instance
   */
  SafeStylesBuilder appendTrustedString(String styles) {
    SafeStylesUtils.verifySafeStylesConstraints(styles);
    _sb.write(styles);
    return this;
  }

  /**
   * Append the background-image CSS property.
   * 
   * @param uri the URI of the background image
   * @see #trustedBackgroundImage(String)
   */
  SafeStylesBuilder backgroundImage(SafeUri uri) {
    return append(SafeStylesUtils.forBackgroundImage(uri));
  }

  /**
   * Append the border-style CSS property.
   */
  SafeStylesBuilder borderStyle(BorderStyle value) {
    return append(SafeStylesUtils.forBorderStyle(value));
  }

  /**
   * Append the border-width css property.
   */
  SafeStylesBuilder borderWidth(double value, Unit unit) {
    return append(SafeStylesUtils.forBorderWidth(value, unit));
  }

  /**
   * Append the bottom css property.
   */
  SafeStylesBuilder bottom(double value, Unit unit) {
    return append(SafeStylesUtils.forBottom(value, unit));
  }

  /**
   * Append the 'clear' CSS property.
   */
  SafeStylesBuilder clear(Clear value) {
    return append(SafeStylesUtils.forClear(value));
  }

  /**
   * Append the cursor CSS property.
   */
  SafeStylesBuilder cursor(Cursor value) {
    return append(SafeStylesUtils.forCursor(value));
  }

  /**
   * Append the display CSS property.
   */
  SafeStylesBuilder display(Display value) {
    return append(SafeStylesUtils.forDisplay(value));
  }

  /**
   * Append the float css property.
   * 
   * <p>
   * Note: This method has the suffix "prop" to avoid Java compilation errors.
   * The term "float" is a reserved word in Java representing the primitive
   * float.
   * </p>
   */
  SafeStylesBuilder floatprop(Float value) {
    return append(SafeStylesUtils.forFloat(value));
  }

  /**
   * Append the font-size css property.
   */
  SafeStylesBuilder fontSize(double value, Unit unit) {
    return append(SafeStylesUtils.forFontSize(value, unit));
  }

  /**
   * Append the font-style CSS property.
   */
  SafeStylesBuilder fontStyle(FontStyle value) {
    return append(SafeStylesUtils.forFontStyle(value));
  }

  /**
   * Append the font-weight CSS property.
   */
  SafeStylesBuilder fontWeight(FontWeight value) {
    return append(SafeStylesUtils.forFontWeight(value));
  }

  /**
   * Append the height css property.
   */
  SafeStylesBuilder height(double value, Unit unit) {
    return append(SafeStylesUtils.forHeight(value, unit));
  }

  /**
   * Append the left css property.
   */
  SafeStylesBuilder left(double value, Unit unit) {
    return append(SafeStylesUtils.forLeft(value, unit));
  }

  /**
   * Append the list-style-type CSS property.
   */
  SafeStylesBuilder listStyleType(ListStyleType value) {
    return append(SafeStylesUtils.forListStyleType(value));
  }

  /**
   * Append the margin css property.
   */
  SafeStylesBuilder margin(double value, Unit unit) {
    return append(SafeStylesUtils.forMargin(value, unit));
  }

  /**
   * Append the margin-bottom css property.
   */
  SafeStylesBuilder marginBottom(double value, Unit unit) {
    return append(SafeStylesUtils.forMarginBottom(value, unit));
  }

  /**
   * Append the margin-left css property.
   */
  SafeStylesBuilder marginLeft(double value, Unit unit) {
    return append(SafeStylesUtils.forMarginLeft(value, unit));
  }

  /**
   * Append the margin-right css property.
   */
  SafeStylesBuilder marginRight(double value, Unit unit) {
    return append(SafeStylesUtils.forMarginRight(value, unit));
  }

  /**
   * Append the margin-top css property.
   */
  SafeStylesBuilder marginTop(double value, Unit unit) {
    return append(SafeStylesUtils.forMarginTop(value, unit));
  }

  /**
   * Append the opacity css property.
   */
  SafeStylesBuilder opacity(double value) {
    return append(SafeStylesUtils.forOpacity(value));
  }

  /**
   * Append the overflow CSS property.
   */
  SafeStylesBuilder overflow(Overflow value) {
    return append(SafeStylesUtils.forOverflow(value));
  }

  /**
   * Append the overflow-x CSS property.
   */
  SafeStylesBuilder overflowX(Overflow value) {
    return append(SafeStylesUtils.forOverflowX(value));
  }

  /**
   * Append the overflow-y CSS property.
   */
  SafeStylesBuilder overflowY(Overflow value) {
    return append(SafeStylesUtils.forOverflowY(value));
  }

  /**
   * Append the padding css property.
   */
  SafeStylesBuilder padding(double value, Unit unit) {
    return append(SafeStylesUtils.forPadding(value, unit));
  }

  /**
   * Append the padding-bottom css property.
   */
  SafeStylesBuilder paddingBottom(double value, Unit unit) {
    return append(SafeStylesUtils.forPaddingBottom(value, unit));
  }

  /**
   * Append the padding-left css property.
   */
  SafeStylesBuilder paddingLeft(double value, Unit unit) {
    return append(SafeStylesUtils.forPaddingLeft(value, unit));
  }

  /**
   * Append the padding-right css property.
   */
  SafeStylesBuilder paddingRight(double value, Unit unit) {
    return append(SafeStylesUtils.forPaddingRight(value, unit));
  }

  /**
   * Append the padding-top css property.
   */
  SafeStylesBuilder paddingTop(double value, Unit unit) {
    return append(SafeStylesUtils.forPaddingTop(value, unit));
  }

  /**
   * Append the position CSS property.
   */
  SafeStylesBuilder position(Position value) {
    return append(SafeStylesUtils.forPosition(value));
  }

  /**
   * Append the right css property.
   */
  SafeStylesBuilder right(double value, Unit unit) {
    return append(SafeStylesUtils.forRight(value, unit));
  }

  /**
   * Append the table-layout CSS property.
   */
  SafeStylesBuilder tableLayout(TableLayout value) {
    return append(SafeStylesUtils.forTableLayout(value));
  }

  /**
   * Append the 'text-align' CSS property.
   */
  SafeStylesBuilder textAlign(TextAlign value) {
    return append(SafeStylesUtils.forTextAlign(value));
  }

  /**
   * Append the text-decoration CSS property.
   */
  SafeStylesBuilder textDecoration(TextDecoration value) {
    return append(SafeStylesUtils.forTextDecoration(value));
  }

  /**
   * Append the 'text-indent' CSS property.
   */
  SafeStylesBuilder textIndent(double value, Unit unit) {
    return append(SafeStylesUtils.forTextIndent(value, unit));
  }

  /**
   * Append the 'text-justify' CSS3 property.
   */
  SafeStylesBuilder textJustify(TextJustify value) {
    return append(SafeStylesUtils.forTextJustify(value));
  }

  /**
   * Append the 'text-overflow' CSS3 property.
   */
  SafeStylesBuilder textOverflow(TextOverflow value) {
    return append(SafeStylesUtils.forTextOverflow(value));
  }

  /**
   * Append the 'text-transform' CSS property.
   */
  SafeStylesBuilder textTransform(TextTransform value) {
    return append(SafeStylesUtils.forTextTransform(value));
  }

  /**
   * Append the top css property.
   */
  SafeStylesBuilder top(double value, Unit unit) {
    return append(SafeStylesUtils.forTop(value, unit));
  }

  /**
   * Returns the safe CSS properties accumulated in the builder as a
   * {@link SafeStyles}.
   * 
   * @return a {@link SafeStyles} instance
   */
  SafeStyles toSafeStyles() {
    return new SafeStylesString(_sb.toString());
  }

  /**
   * <p>
   * Append the trusted background color, i.e., without escaping the value. No
   * checks are performed. The calling code should be carefully reviewed to
   * ensure the argument will satisfy the {@link SafeStyles} contract when they
   * are composed into the form: "&lt;name&gt;:&lt;value&gt;;".
   * 
   * <p>
   * {@link SafeStyles} may never contain literal angle brackets. Otherwise, it
   * could be unsafe to place a {@link SafeStyles} into a &lt;style&gt; tag
   * (where it can't be HTML escaped). For example, if the {@link SafeStyles}
   * containing "
   * <code>font: 'foo &lt;style&gt;&lt;script&gt;evil&lt;/script&gt;</code>'" is
   * used in a style sheet in a &lt;style&gt; tag, this could then break out of
   * the style context into HTML.
   * 
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  SafeStylesBuilder trustedBackgroundColor(String value) {
    return append(SafeStylesUtils.forTrustedBackgroundColor(value));
  }

  /**
   * <p>
   * Append the trusted background image, i.e., without escaping the value. No
   * checks are performed. The calling code should be carefully reviewed to
   * ensure the argument will satisfy the {@link SafeStyles} contract when they
   * are composed into the form: "&lt;name&gt;:&lt;value&gt;;".
   * 
   * <p>
   * {@link SafeStyles} may never contain literal angle brackets. Otherwise, it
   * could be unsafe to place a {@link SafeStyles} into a &lt;style&gt; tag
   * (where it can't be HTML escaped). For example, if the {@link SafeStyles}
   * containing "
   * <code>font: 'foo &lt;style&gt;&lt;script&gt;evil&lt;/script&gt;</code>'" is
   * used in a style sheet in a &lt;style&gt; tag, this could then break out of
   * the style context into HTML.
   * 
   * @param value the property value
   * @return a {@link SafeStyles} instance
   * @see #backgroundImage(SafeUri)
   */
  SafeStylesBuilder trustedBackgroundImage(String value) {
    return append(SafeStylesUtils.forTrustedBackgroundImage(value));
  }

  /**
   * <p>
   * Append the trusted border color, i.e., without escaping the value. No
   * checks are performed. The calling code should be carefully reviewed to
   * ensure the argument will satisfy the {@link SafeStyles} contract when they
   * are composed into the form: "&lt;name&gt;:&lt;value&gt;;".
   * 
   * <p>
   * {@link SafeStyles} may never contain literal angle brackets. Otherwise, it
   * could be unsafe to place a {@link SafeStyles} into a &lt;style&gt; tag
   * (where it can't be HTML escaped). For example, if the {@link SafeStyles}
   * containing "
   * <code>font: 'foo &lt;style&gt;&lt;script&gt;evil&lt;/script&gt;</code>'" is
   * used in a style sheet in a &lt;style&gt; tag, this could then break out of
   * the style context into HTML.
   * 
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  SafeStylesBuilder trustedBorderColor(String value) {
    return append(SafeStylesUtils.forTrustedBorderColor(value));
  }

  /**
   * <p>
   * Append the trusted font color, i.e., without escaping the value. No checks
   * are performed. The calling code should be carefully reviewed to ensure the
   * argument will satisfy the {@link SafeStyles} contract when they are
   * composed into the form: "&lt;name&gt;:&lt;value&gt;;".
   * 
   * <p>
   * {@link SafeStyles} may never contain literal angle brackets. Otherwise, it
   * could be unsafe to place a {@link SafeStyles} into a &lt;style&gt; tag
   * (where it can't be HTML escaped). For example, if the {@link SafeStyles}
   * containing "
   * <code>font: 'foo &lt;style&gt;&lt;script&gt;evil&lt;/script&gt;</code>'" is
   * used in a style sheet in a &lt;style&gt; tag, this could then break out of
   * the style context into HTML.
   * 
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  SafeStylesBuilder trustedColor(String value) {
    return append(SafeStylesUtils.forTrustedColor(value));
  }

  /**
   * <p>
   * Append a {@link SafeStyles} constructed from a trusted name and a trusted
   * value, i.e., without escaping the name and value. No checks are performed.
   * The calling code should be carefully reviewed to ensure the argument will
   * satisfy the {@link SafeStyles} contract when they are composed into the
   * form: "&lt;name&gt;:&lt;value&gt;;".
   * 
   * <p>
   * {@link SafeStyles} may never contain literal angle brackets. Otherwise, it
   * could be unsafe to place a {@link SafeStyles} into a &lt;style&gt; tag
   * (where it can't be HTML escaped). For example, if the {@link SafeStyles}
   * containing "
   * <code>font: 'foo &lt;style&gt;&lt;script&gt;evil&lt;/script&gt;</code>'" is
   * used in a style sheet in a &lt;style&gt; tag, this could then break out of
   * the style context into HTML.
   * </p>
   * 
   * <p>
   * The name should be in hyphenated format, not camelCase format.
   * </p>
   * 
   * @param name the property name
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  SafeStylesBuilder trustedNameAndValue(String name, value, [Unit unit = null]) {
    if (unit != null) {
      return append(SafeStylesUtils.fromTrustedNameAndValue(name, value, unit));
    } else {
      return append(SafeStylesUtils.fromTrustedNameAndValue(name, value));
    }
  }

  /**
   * Append the vertical-align CSS property.
   */
  SafeStylesBuilder verticalAlign(value, [Unit unit = null]) {
    if (unit != null) {
      return append(SafeStylesUtils.forVerticalAlign(value, unit));
    } else {
      return append(SafeStylesUtils.forVerticalAlign(value));
    }
  }

  /**
   * Append the visibility CSS property.
   */
  SafeStylesBuilder visibility(Visibility value) {
    return append(SafeStylesUtils.forVisibility(value));
  }

  /**
   * Append the 'white-space' CSS property.
   */
  SafeStylesBuilder whiteSpace(WhiteSpace whiteSpace) {
    return append(SafeStylesUtils.forWhiteSpace(whiteSpace));
  }

  /**
   * Append the width css property.
   */
  SafeStylesBuilder width(double value, Unit unit) {
    return append(SafeStylesUtils.forWidth(value, unit));
  }

  /**
   * Append the z-index css property.
   */
  SafeStylesBuilder zIndex(int value) {
    return append(SafeStylesUtils.forZIndex(value));
  }
}