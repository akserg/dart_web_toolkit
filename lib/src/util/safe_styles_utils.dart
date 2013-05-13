//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit Util library.
 */
part of dart_web_toolkit_util;

/**
 * Utility class containing static methods for creating {@link SafeStyles}.
 */
class SafeStylesUtils {

  static SafeStylesUtilsImpl _impl;

  /**
   * Sets the background-image CSS property.
   * 
   * @param uri the URI of the background image
   * @return a {@link SafeStyles} instance
   * @see #forTrustedBackgroundImage(String)
   */
  static SafeStyles forBackgroundImage(SafeUri uri) {
    return fromTrustedNameAndValue("background-image", "url(\"" + uri.asString() + "\")");
  }

  /**
   * Sets the border-style CSS property.
   */
  static SafeStyles forBorderStyle(BorderStyle value) {
    return fromTrustedNameAndValue("border-style", value.value);
  }

  /**
   * Set the border-width css property.
   */
  static SafeStyles forBorderWidth(double value, Unit unit) {
    return fromTrustedNameAndValue("border-width", value, unit);
  }

  /**
   * Set the bottom css property.
   */
  static SafeStyles forBottom(double value, Unit unit) {
    return fromTrustedNameAndValue("bottom", value, unit);
  }

  /**
   * Sets the 'clear' CSS property.
   */
  static SafeStyles forClear(Clear value) {
    return fromTrustedNameAndValue("clear", value.value);
  }

  /**
   * Sets the cursor CSS property.
   */
  static SafeStyles forCursor(Cursor value) {
    return fromTrustedNameAndValue("cursor", value.value);
  }

  /**
   * Sets the display CSS property.
   */
  static SafeStyles forDisplay(Display value) {
    return fromTrustedNameAndValue("display", value.value);
  }

  /**
   * Set the float css property.
   */
  static SafeStyles forFloat(Float value) {
    return fromTrustedNameAndValue("float", value.value);
  }

  /**
   * Set the font-size css property.
   */
  static SafeStyles forFontSize(double value, Unit unit) {
    return fromTrustedNameAndValue("font-size", value, unit);
  }

  /**
   * Sets the font-style CSS property.
   */
  static SafeStyles forFontStyle(FontStyle value) {
    return fromTrustedNameAndValue("font-style", value.value);
  }

  /**
   * Sets the font-weight CSS property.
   */
  static SafeStyles forFontWeight(FontWeight value) {
    return fromTrustedNameAndValue("font-weight", value.value);
  }

  /**
   * Set the height css property.
   */
  static SafeStyles forHeight(double value, Unit unit) {
    return fromTrustedNameAndValue("height", value, unit);
  }

  /**
   * Set the left css property.
   */
  static SafeStyles forLeft(double value, Unit unit) {
    return fromTrustedNameAndValue("left", value, unit);
  }

  /**
   * Set the line-height css property.
   */
  static SafeStyles forLineHeight(double value, Unit unit) {
    return fromTrustedNameAndValue("line-height", value, unit);
  }

  /**
   * Sets the list-style-type CSS property.
   */
  static SafeStyles forListStyleType(ListStyleType value) {
    return fromTrustedNameAndValue("list-style-type", value.value);
  }

  /**
   * Set the margin css property.
   */
  static SafeStyles forMargin(double value, Unit unit) {
    return fromTrustedNameAndValue("margin", value, unit);
  }

  /**
   * Set the margin-bottom css property.
   */
  static SafeStyles forMarginBottom(double value, Unit unit) {
    return fromTrustedNameAndValue("margin-bottom", value, unit);
  }

  /**
   * Set the margin-left css property.
   */
  static SafeStyles forMarginLeft(double value, Unit unit) {
    return fromTrustedNameAndValue("margin-left", value, unit);
  }

  /**
   * Set the margin-right css property.
   */
  static SafeStyles forMarginRight(double value, Unit unit) {
    return fromTrustedNameAndValue("margin-right", value, unit);
  }

  /**
   * Set the margin-top css property.
   */
  static SafeStyles forMarginTop(double value, Unit unit) {
    return fromTrustedNameAndValue("margin-top", value, unit);
  }

  /**
   * Set the opacity css property.
   */
  static SafeStyles forOpacity(double value) {
    return impl().forOpacity(value);
  }

  /**
   * Sets the outline-style CSS property.
   */
  static SafeStyles forOutlineStyle(OutlineStyle value) {
    return fromTrustedNameAndValue("outline-style", value.value);
  }

  /**
   * Set the outline-width css property.
   */
  static SafeStyles forOutlineWidth(double value, Unit unit) {
    return fromTrustedNameAndValue("outline-width", value, unit);
  }

  /**
   * Sets the overflow CSS property.
   */
  static SafeStyles forOverflow(Overflow value) {
    return fromTrustedNameAndValue("overflow", value.value);
  }

  /**
   * Sets the overflow-x CSS property.
   */
  static SafeStyles forOverflowX(Overflow value) {
    return fromTrustedNameAndValue("overflow-x", value.value);
  }

  /**
   * Sets the overflow-y CSS property.
   */
  static SafeStyles forOverflowY(Overflow value) {
    return fromTrustedNameAndValue("overflow-y", value.value);
  }

  /**
   * Set the padding css property.
   */
  static SafeStyles forPadding(double value, Unit unit) {
    return fromTrustedNameAndValue("padding", value, unit);
  }

  /**
   * Set the padding-bottom css property.
   */
  static SafeStyles forPaddingBottom(double value, Unit unit) {
    return fromTrustedNameAndValue("padding-bottom", value, unit);
  }

  /**
   * Set the padding-left css property.
   */
  static SafeStyles forPaddingLeft(double value, Unit unit) {
    return fromTrustedNameAndValue("padding-left", value, unit);
  }

  /**
   * Set the padding-right css property.
   */
  static SafeStyles forPaddingRight(double value, Unit unit) {
    return fromTrustedNameAndValue("padding-right", value, unit);
  }

  /**
   * Set the padding-top css property.
   */
  static SafeStyles forPaddingTop(double value, Unit unit) {
    return fromTrustedNameAndValue("padding-top", value, unit);
  }

  /**
   * Sets the position CSS property.
   */
  static SafeStyles forPosition(Position value) {
    return fromTrustedNameAndValue("position", value.value);
  }

  /**
   * Set the right css property.
   */
  static SafeStyles forRight(double value, Unit unit) {
    return fromTrustedNameAndValue("right", value, unit);
  }

  /**
   * Set the table-layout CSS property.
   */
  static SafeStyles forTableLayout(TableLayout value) {
    return fromTrustedNameAndValue("table-layout", value.value);
  }

  /**
   * Sets the 'text-align' CSS property.
   */
  static SafeStyles forTextAlign(TextAlign value) {
    return fromTrustedNameAndValue("text-align", value.value);
  }

  /**
   * Sets the 'text-decoration' CSS property.
   */
  static SafeStyles forTextDecoration(TextDecoration value) {
    return fromTrustedNameAndValue("text-decoration", value.value);
  }

  /**
   * Set the 'text-indent' CSS property.
   */
  static SafeStyles forTextIndent(double value, Unit unit) {
    return fromTrustedNameAndValue("text-indent", value + unit.value);
  }

  /**
   * Set the 'text-justify' CSS3 property.
   */
  static SafeStyles forTextJustify(TextJustify value) {
    return fromTrustedNameAndValue("text-justify", value.value);
  }

  /**
   * Set the 'text-overflow' CSS3 property.
   */
  static SafeStyles forTextOverflow(TextOverflow value) {
    return fromTrustedNameAndValue("text-overflow", value.value);
  }

  /**
   * Set the 'text-transform' CSS property.
   */
  static SafeStyles forTextTransform(TextTransform value) {
    return fromTrustedNameAndValue("text-transform", value.value);
  }

  /**
   * Set the top css property.
   */
  static SafeStyles forTop(double value, Unit unit) {
    return fromTrustedNameAndValue("top", value, unit);
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted background color,
   * i.e., without escaping the value. No checks are performed. The calling code
   * should be carefully reviewed to ensure the argument will satisfy the
   * {@link SafeStyles} contract when they are composed into the form:
   * "&lt;name&gt;:&lt;value&gt;;".
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
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  static SafeStyles forTrustedBackgroundColor(String value) {
    return fromTrustedNameAndValue("background-color", value);
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted background image,
   * i.e., without escaping the value. No checks are performed. The calling code
   * should be carefully reviewed to ensure the argument will satisfy the
   * {@link SafeStyles} contract when they are composed into the form:
   * "&lt;name&gt;:&lt;value&gt;;".
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
   * @param value the property value
   * @return a {@link SafeStyles} instance
   * @see #forBackgroundImage(SafeUri)
   */
  static SafeStyles forTrustedBackgroundImage(String value) {
    return fromTrustedNameAndValue("background-image", value);
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted border color, i.e.,
   * without escaping the value. No checks are performed. The calling code
   * should be carefully reviewed to ensure the argument will satisfy the
   * {@link SafeStyles} contract when they are composed into the form:
   * "&lt;name&gt;:&lt;value&gt;;".
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
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  static SafeStyles forTrustedBorderColor(String value) {
    return fromTrustedNameAndValue("border-color", value);
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted font color, i.e.,
   * without escaping the value. No checks are performed. The calling code
   * should be carefully reviewed to ensure the argument will satisfy the
   * {@link SafeStyles} contract when they are composed into the form:
   * "&lt;name&gt;:&lt;value&gt;;".
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
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  static SafeStyles forTrustedColor(String value) {
    return fromTrustedNameAndValue("color", value);
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted outline color,
   * i.e., without escaping the value. No checks are performed. The calling code
   * should be carefully reviewed to ensure the argument will satisfy the
   * {@link SafeStyles} contract when they are composed into the form:
   * "&lt;name&gt;:&lt;value&gt;;".
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
   * @param value the property value
   * @return a {@link SafeStyles} instance
   */
  static SafeStyles forTrustedOutlineColor(String value) {
    return fromTrustedNameAndValue("outline-color", value);
  }

  /**
   * Sets the vertical-align CSS property.
   */
  static SafeStyles forVerticalAlign(value, [Unit unit = null]) {
    if (value is VerticalAlign) {
      return fromTrustedNameAndValue("vertical-align", (value as VerticalAlign).value);
    } else {
      return fromTrustedNameAndValue("vertical-align", value, unit);
    }
  }

  /**
   * Sets the visibility CSS property.
   */
  static SafeStyles forVisibility(Visibility value) {
    return fromTrustedNameAndValue("visibility", value.value);
  }

  /**
   * Set the 'white-space' CSS property.
   */
  static SafeStyles forWhiteSpace(WhiteSpace value) {
    return fromTrustedNameAndValue("white-space", value.value);
  }

  /**
   * Set the width css property.
   */
  static SafeStyles forWidth(double value, Unit unit) {
    return fromTrustedNameAndValue("width", value, unit);
  }

  /**
   * Set the z-index css property.
   */
  static SafeStyles forZIndex(int value) {
    return new SafeStylesString("z-index: %value;");
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted name and a trusted
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
   * @param value the value
   * @param unit the units of the value
   * @return a {@link SafeStyles} instance
   */
  static SafeStyles fromTrustedNameAndValue(String name, value, [Unit unit = null]) {
    //SafeStylesHostedModeUtils.maybeCheckValidStyleName(name);
    if (unit != null) {
      return new SafeStylesString(name + ":" + value + unit.value + ";");
    } else {
      return fromTrustedString(name + ":" + value + ";");
    }
  }

  /**
   * <p>
   * Returns a {@link SafeStyles} constructed from a trusted string, i.e.,
   * without escaping the string. No checks are performed. The calling code
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
   * @param s the input String
   * @return a {@link SafeStyles} instance
   */
  static SafeStyles fromTrustedString(String s) {
    return new SafeStylesString(s);
  }

  /**
   * Verify that the basic constraints of a {@link SafeStyles} are met. This
   * method is not a guarantee that the specified css is safe for use in a CSS
   * style attribute. It is a minimal set of assertions to check for common
   * errors.
   * 
   * @param styles the CSS properties string
   * @throws NullPointerException if the css is null
   * @throws AssertionError if the css does not meet the contraints
   */
  static void verifySafeStylesConstraints(String styles) {
    if (styles == null) {
      throw new Exception("css is null");
    }

    // CSS properties must end in a semi-colon or they cannot be safely
    // composed with other properties.
    assert ((styles.trim().length == 0) || styles.endsWith(";"));
//    : "Invalid CSS Property: '"
//        + styles + "'. CSS properties must be an empty string or end with a semi-colon (;).";
    assert (!styles.contains("<") && !styles.contains(">"));
//    : "Invalid CSS Property: '" + styles
//        + "'. CSS should not contain brackets (< or >).";
  }

  static SafeStylesUtilsImpl impl() {
    if (_impl == null) {
//      if (GWT.isClient()) {
        _impl = new SafeStylesUtilsImpl(); //GWT.create(SafeStylesUtilsImpl.class);
//      } else {
//        _impl = new ImplServer();
//      }
    }
    return _impl;
  }

  // prevent instantiation
  SafeStylesUtils() {
  }
}

/**
 * Standard implementation of this class.
 */
class SafeStylesUtilsImpl {
  SafeStyles forOpacity(double value) {
    return new SafeStylesString("opacity: %value;");
  }
}

/**
 * Server implementation of this class.
 * 
 * <p>
 * The server doesn't necessarily know the user agent of the client, so we
 * combine the results of all other implementations.
 * </p>
 */
class ImplServer extends SafeStylesUtilsImpl {

  ImplIE6To8 _implIE = new ImplIE6To8();

  SafeStyles forOpacity(double value) {
    SafeStylesBuilder sb = new SafeStylesBuilder();
    sb.append(super.forOpacity(value));
    sb.append(_implIE.forOpacity(value));
    return sb.toSafeStyles();
  }
}

/**
 * IE6-IE8 implementation of this class.
 */
class ImplIE6To8 extends SafeStylesUtilsImpl {

  SafeStyles forOpacity(double value) {
    // IE6-IE8 uses an alpha filter instead of opacity.
    return new SafeStylesString("filter: alpha(opacity=%{value * 100});");
  }
}