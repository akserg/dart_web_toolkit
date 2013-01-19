//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * A tag interface that serves as the root of a family of types used in static
 * internationalization. Using <code>GWT.create(<i>class</i>)</code> to
 * instantiate a type that directly extends or implements
 * <code>Localizable</code> invites locale-sensitive type substitution.
 *
 * <h3>Locale-sensitive Type Substitution</h3>
 * If a type <code>Type</code> directly extends or implements
 * <code>Localizable</code> (as opposed to
 * {@link com.google.gwt.i18n.client.Constants} or
 * {@link com.google.gwt.i18n.client.Messages}) and the following code is used
 * to create an object from <code>Type</code> as follows:
 *
 * <pre class="code">Type localized = (Type)GWT.create(Type.class);</pre>
 *
 * then <code>localized</code> will be assigned an instance of a localized
 * subclass, selected based on the value of the <code>locale</code> client
 * property. The choice of subclass is determined by the following naming
 * pattern:
 *
 * <table>
 *
 * <tr>
 * <th align='left'>If <code>locale</code> is...&#160;&#160;&#160;&#160;</th>
 * <th align='left'>The substitute class for <code>Type</code> is...</th>
 * </tr>
 *
 * <tr>
 * <td><i>unspecified</i></td>
 * <td><code>Type</code> itself, or <code>Type_</code> if <code>Type</code>
 * is an interface</td>
 * </tr>
 *
 * <tr>
 * <td><code>x</code></td>
 * <td>Class <code>Type_x</code> if it exists, otherwise treated as if
 * <code>locale</code> were <i>unspecified</i></td>
 * </tr>
 *
 * <tr>
 * <td><code>x_Y</code></td>
 * <td>Class <code>Type_x_Y</code> if it exists, otherwise treated as if
 * <code>locale</code> were <code>x</code></td>
 * </tr>
 *
 * </table>
 *
 * where in the table above <code>x</code> is a <a
 * href="http://ftp.ics.uci.edu/pub/ietf/http/related/iso639.txt">ISO language
 * code</a> and <code>Y</code> is a two-letter <a
 * href="http://userpage.chemie.fu-berlin.de/diverse/doc/ISO_3166.html">ISO
 * country code</a>.
 *
 * <h3>Specifying Locale</h3>
 * The locale of a module is specified using the <code>locale</code> client
 * property, which can be specified using either a meta tag or as part of the
 * query string in the host page's URL. If both are specified, the query string
 * takes precedence.
 *
 * <p>
 * To specify the <code>locale</code> client property using a meta tag in the
 * host HTML, use <code>gwt:property</code> as follows:
 *
 * <pre>&lt;meta name="gwt:property" content="locale=x_Y"&gt;</pre>
 *
 * For example, the following host HTML page sets the locale to "ja_JP":
 *
 * {@gwt.include com/google/gwt/examples/i18n/ColorNameLookupExample_ja_JP.html}
 * </p>
 *
 * <p>
 * To specify the <code>locale</code> client property using a query string,
 * specify a value for the name <code>locale</code>. For example,
 *
 * <pre>http://www.example.org/myapp.html?locale=fr_CA</pre>
 *
 * </p>
 *
 * <h3>For More Information</h3>
 * See the GWT Developer Guide for an introduction to internationalization.
 *
 * @see com.google.gwt.i18n.client.Constants
 * @see com.google.gwt.i18n.client.ConstantsWithLookup
 * @see com.google.gwt.i18n.client.Messages
 * @see com.google.gwt.i18n.client.Dictionary
 */
abstract class Localizable {

}
