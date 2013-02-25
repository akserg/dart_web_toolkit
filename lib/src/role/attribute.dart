//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * <p>Class representing ARIA state/property attribute. Contains methods for setting, getting,
 * removing ARIA attributes for an HTML {@link com.google.gwt.dom.client.Element}.</p>
 *
 * <p>For more details about ARIA states and properties check the W3C ARIA documentation
 * <a href="http://www.w3.org/TR/wai-aria/states_and_properties"> Supported States and Properties
 * </a>.</p>
 *
 * @param <T> The attribute value type
 */
abstract class Attribute<T> {

  final String name;
  String defaultValue;

  /**
   * Constructs a state/property ARIA attribute with name {@code name} and {@code defaultValue}.
   *
   * @param name State/Property name
   * @param defaultValue Default values
   */
  Attribute(this.name, [String defaultValue = null]) {
    assert (name != null); // : "Name cannot be null";
    this.defaultValue = defaultValue;
  }

  /**
   * Gets the HTML attribute value for the attribute with name {@code name} for element
   * {@code element}
   *
   * @param element HTM element
   * @return The attribute value for {@code element}
   */
  String get(dart_html.Element element) {
    assert (element != null); // : "Element cannot be null.";
    return element.attributes["name"];
  }

  /**
   * Gets the property/state name
   *
   * @return The attribute name
   */
  String getName() {
    return name;
  }

  /**
   * Removes the state/property attribute for element {@code element}.
   *
   * @param element HTM element
   */
  void remove(dart_html.Element element) {
    assert (element != null); // : "Element cannot be null.";
    element.attributes.remove(name);
  }

  /**
   * Sets the state/property {@code value} for the HTML element {@code element}.
   *
   * @param element HTML element
   * @param values Attribute value
   */
  void set(dart_html.Element element, T values) {
    assert (element != null); // : "Element cannot be null.";
    //assert (values.length > 0);
    element.attributes[name] = _getAriaValue(values);
  }

  /**
   * Sets the state/property value to the defaultValue if not null. If a list of default values is
   * set, every default value is converted to string and the string values are concatenated in a
   * string token list. There is an assertion checking whether the default is null. Note that the
   * asserts are enabled during development and testing but they will be stripped in production
   * mode.
   *
   * @param element HTML element
   */
  void setDefault(dart_html.Element element) {
    assert (element != null); // : "Element cannot be null.";
    assert (defaultValue != null && !defaultValue.isEmpty); // : "Default value cannot be null.";
    element.attributes[name] = defaultValue;
  }

  String getSingleValue(T value);

  String _getAriaValue(T value) {
    if (value is Collection) {
      StringBuffer buf = new StringBuffer();
      for (T item in (value as Collection)) {
        buf.write(getSingleValue(item));
        buf.write(" ");
      }
      return buf.toString().trim();
    } else {
      return getSingleValue(value);
    }
//    if (value.length == 1) {
//      return getSingleValue(value[0]);
//    } else {
//      StringBuffer buf = new StringBuffer();
//      for (T item in value) {
//        buf.add(getSingleValue(item)).add(" ");
//      }
//      return buf.toString().trim();
//    }
  }
}
