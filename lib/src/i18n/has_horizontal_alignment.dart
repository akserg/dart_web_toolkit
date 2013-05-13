//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * Characteristic interface which indicates that a widget can be aligned
 * horizontally.
 *
 * <h3>Use in UiBinder Templates</h3>
 *
 * <p>
 * The names of the static members of {@link HorizontalAlignmentConstant}, as
 * well as simple alignment names (<code>left</code>, <code>center</code>,
 * <code>right</code>, <code>justify</code>), can be used as values for a
 * <code>horizontalAlignment</code> attribute of any widget that implements this
 * interface. (In fact, this will work for any widget method that takes a single
 * HorizontalAlignmentConstant value.)
 * <p>
 * For example,
 *
 * <pre>
 * &lt;g:Label horizontalAlignment='ALIGN_RIGHT'>Hi there.&lt;/g:Label>
 * &lt;g:Label horizontalAlignment='right'>Hi there.&lt;/g:Label>
 * </pre>
 */
abstract class HasHorizontalAlignment {
  /**
   * Specifies that the widget's contents should be aligned in the center.
   */
  static const HorizontalAlignmentConstant ALIGN_CENTER = const HorizontalAlignmentConstant(TextAlign.CENTER);

  /**
   * Specifies that the widget's contents should be aligned as justify.
   */
  static const HorizontalAlignmentConstant ALIGN_JUSTIFY = const HorizontalAlignmentConstant(TextAlign.JUSTIFY);

  /**
   * Specifies that the widget's contents should be aligned to the left.
   */
  static const HorizontalAlignmentConstant ALIGN_LEFT = const HorizontalAlignmentConstant(TextAlign.LEFT);

  /**
   * Specifies that the widget's contents should be aligned to the right.
   */
  static const HorizontalAlignmentConstant ALIGN_RIGHT = const HorizontalAlignmentConstant(TextAlign.RIGHT);

  /**
   * In a RTL layout, specifies that the widget's contents should be aligned to
   * the right. In a LTR layout, specifies that the widget's constants should be
   * aligned to the left.
   */
  static const HorizontalAlignmentConstant ALIGN_LOCALE_START = HasHorizontalAlignment.ALIGN_LEFT; //LocaleInfo.getCurrentLocale().isRTL() ? HasHorizontalAlignment.ALIGN_RIGHT : HasHorizontalAlignment.ALIGN_LEFT;

  /**
   * In a RTL layout, specifies that the widget's contents should be aligned to
   * the left. In a LTR layout, specifies that the widget's constants should be
   * aligned to the right.
   */
  static const HorizontalAlignmentConstant ALIGN_LOCALE_END = HasHorizontalAlignment.ALIGN_RIGHT ; //LocaleInfo.getCurrentLocale().isRTL() ? HasHorizontalAlignment.ALIGN_LEFT : HasHorizontalAlignment.ALIGN_RIGHT;

  /**
   * Synonym of {@link #ALIGN_LOCALE_START}.
   */
  static const HorizontalAlignmentConstant ALIGN_DEFAULT = HasHorizontalAlignment.ALIGN_LOCALE_START;

  /**
   * Gets the horizontal alignment.
   *
   * @return the current horizontal alignment (
   *         {@link HasHorizontalAlignment#ALIGN_LEFT},
   *         {@link HasHorizontalAlignment#ALIGN_CENTER},
   *         {@link HasHorizontalAlignment#ALIGN_RIGHT},
   *         {@link HasHorizontalAlignment#ALIGN_JUSTIFY}, or
   *         null).
   */
  HorizontalAlignmentConstant getHorizontalAlignment();

  /**
   * Sets the horizontal alignment.
   * <p> Use {@code null} to clear horizontal alignment, allowing it to be
   * determined by the standard HTML mechanisms such as inheritance and CSS
   * rules.
   *
   * @param align the horizontal alignment (
   *         {@link HasHorizontalAlignment#ALIGN_LEFT},
   *         {@link HasHorizontalAlignment#ALIGN_CENTER},
   *         {@link HasHorizontalAlignment#ALIGN_RIGHT},
   *         {@link HasHorizontalAlignment#ALIGN_JUSTIFY},
   *         {@link HasHorizontalAlignment#ALIGN_LOCALE_START}, or
   *         {@link HasHorizontalAlignment#ALIGN_LOCALE_END}).
   */
  void setHorizontalAlignment(HorizontalAlignmentConstant align);
}

/**
 * Type for values defined and used in {@link HasAutoHorizontalAlignment}.
 * Defined here so that HorizontalAlignmentConstant can be derived from it,
 * thus allowing HasAutoHorizontalAlignment methods to accept and return both
 * AutoHorizontalAlignmentConstant and HorizontalAlignmentConstant values -
 * without allowing the methods defined here to accept or return
 * AutoHorizontalAlignmentConstant values.
 */
class AutoHorizontalAlignmentConstant{
  // The constructor is package-private to prevent uncontrolled inheritance
  // and instantiation of this class.
  const AutoHorizontalAlignmentConstant.internal();
}

/**
 * Possible return values for {@link #getHorizontalAlignment}, and parameter
 * values for {@link #setHorizontalAlignment}.
 */
class HorizontalAlignmentConstant extends AutoHorizontalAlignmentConstant {

  static HorizontalAlignmentConstant endOf(Direction direction) {
    return direction == Direction.LTR ? HasHorizontalAlignment.ALIGN_RIGHT : direction == Direction.RTL ? HasHorizontalAlignment.ALIGN_LEFT : HasHorizontalAlignment.ALIGN_LOCALE_END;
  }

  static HorizontalAlignmentConstant startOf(Direction direction) {
    return direction == Direction.LTR ? HasHorizontalAlignment.ALIGN_LEFT : direction == Direction.RTL ? HasHorizontalAlignment.ALIGN_RIGHT : HasHorizontalAlignment.ALIGN_LOCALE_START;
  }

  final TextAlign _textAlign;

  const HorizontalAlignmentConstant(this._textAlign) : super.internal();

  /**
   * Gets the CSS 'text-align' string associated with this constant.
  *
   * @return the CSS 'text-align' value
   */
  String getTextAlignString() {
    return _textAlign.value;
  }
}