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
abstract class HasVerticalAlignment {}
