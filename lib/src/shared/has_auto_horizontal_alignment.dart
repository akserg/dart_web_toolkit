//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * A widget that implements this interface can be configured to be aligned
 * according to its contents' direction, in addition to the static alignment
 * options offered by {@link HasHorizontalAlignment}.
 */
abstract class HasAutoHorizontalAlignment extends HasHorizontalAlignment {
  /**
   * Specifies that the widget's contents should be aligned left for LTR
   * content, right for RTL content, and if the content's direction is DEFAULT,
   * like {@link #ALIGN_LOCALE_START}.
   */
  static AutoHorizontalAlignmentConstant ALIGN_CONTENT_START = new AutoHorizontalAlignmentConstant.internal();

  /**
   * Specifies that the widget's contents should be aligned right for LTR
   * content, left for RTL content, and if the content's direction is DEFAULT,
   * like {@link #ALIGN_LOCALE_END}.
   */
  static AutoHorizontalAlignmentConstant ALIGN_CONTENT_END = new AutoHorizontalAlignmentConstant.internal();
  
  /**
   * Gets the horizontal auto-alignment setting. This may be one of the
   * auto-alignment values above that depend on content direction (e.g.
   * {@link HasAutoHorizontalAlignment#ALIGN_CONTENT_START}), or one of the
   * "static" {@link HasHorizontalAlignment.HorizontalAlignmentConstant}
   * alignment values (e.g. {@link HasHorizontalAlignment#ALIGN_LOCALE_START}).
   * It may be set by either {@code setAutoHorizontalAlignment} or {@code
   * HasHorizontalAlignment#setHorizontalAlignment}. The default is null,
   * indicating that no specific horizontal alignment has been set, allowing it
   * to be determined by the usual HTML and CSS mechanisms.
   *
   * @return the current automatic horizontal alignment policy.
   */
  AutoHorizontalAlignmentConstant getAutoHorizontalAlignment();

  /**
   * Sets the horizontal alignment, allowing in addition to the "static"
   * {@link HasHorizontalAlignment.HorizontalAlignmentConstant} values, the
   * "automatic" {@link HasHorizontalAlignment.AutoHorizontalAlignmentConstant}
   * values that depend on the content direction. Determines the values returned
   * by both {@link #getAutoHorizontalAlignment} and
   * {@link HasHorizontalAlignment#getHorizontalAlignment()}.
   * <p> For the {@code ALIGN_CONTENT_START} and {@code ALIGN_CONTENT_END}
   * values, sets the horizontal alignment (including the value of {@code
   * HasHorizontalAlignment#getHorizontalAlignment()}) to the start or end edge
   * of the current content's direction, respectively, and continues to
   * automatically update it whenever the content direction changes.
   * <p> For other values, operates like {@link #setHorizontalAlignment}.
   * <p> For {@code null}, the horizontal alignment is cleared, allowing it to
   * be determined by the standard HTML mechanisms such as inheritance and CSS
   * rules.
   * @see HasHorizontalAlignment
   *
   * @param autoHorizontalAlignment the new automatic horizontal alignment
   *        policy
   */
  void setAutoHorizontalAlignment(AutoHorizontalAlignmentConstant autoHorizontalAlignment);
}
