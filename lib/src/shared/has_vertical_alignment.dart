//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

/**
 * Characteristic interface which indicates that a widget has an associated
 * vertical alignment.
 * 
 * <h3>Use in UiBinder Templates</h3>
 * 
 * <p>
 * The names of the static members of {@link VerticalAlignmentConstant}, as well
 * as simple alignment names (<code>top</code>, <code>middle</code>,
 * <code>bottom</code>), can be used as values for a
 * <code>verticalAlignment</code> attribute of any widget that implements this
 * interface. (In fact, this will work for any widget method that takes a single
 * VerticalAlignmentConstant value.)
 * <p>
 * For example,
 * 
 * <pre>
 * &lt;g:VerticalPanel verticalAlignment='ALIGN_BOTTOM' />
 * &lt;g:VerticalPanel verticalAlignment='bottom' />
 * </pre>
 */
abstract class HasVerticalAlignment {
  
  /**
   * Specifies that the widget's contents should be aligned to the bottom.
   */
  static VerticalAlignmentConstant ALIGN_BOTTOM = new VerticalAlignmentConstant("bottom");

  /**
   * Specifies that the widget's contents should be aligned in the middle.
   */
  static VerticalAlignmentConstant ALIGN_MIDDLE = new VerticalAlignmentConstant("middle");

  /**
   * Specifies that the widget's contents should be aligned to the top.
   */
  static VerticalAlignmentConstant ALIGN_TOP = new VerticalAlignmentConstant("top");

  /**
   * Gets the vertical alignment.
   * 
   * @return the current vertical alignment.
   */
  VerticalAlignmentConstant getVerticalAlignment();

  /**
   * Sets the vertical alignment.
   * 
   * @param align the vertical alignment (
   *          {@link HasVerticalAlignment#ALIGN_TOP},
   *          {@link HasVerticalAlignment#ALIGN_MIDDLE}, or
   *          {@link HasVerticalAlignment#ALIGN_BOTTOM}).
   */
  void setVerticalAlignment(VerticalAlignmentConstant align);
}

/**
 * Horizontal alignment constant.
 */
class VerticalAlignmentConstant {
  
  final String _verticalAlignString;

  VerticalAlignmentConstant(this._verticalAlignString);

  /**
   * Gets the CSS 'vertical-align' string associated with this constant.
   * 
   * @return the CSS 'vertical-align' value
   */
  String getVerticalAlignString() {
    return _verticalAlignString;
  }
}