//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_shared;

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
  
}
