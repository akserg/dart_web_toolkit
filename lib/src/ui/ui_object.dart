//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * The superclass for all user-interface objects. It simply wraps a DOM element,
 * and cannot receive events. Most interesting user-interface classes derive
 * from [Widget].
 */
abstract class UiObject implements HasVisibility {

  static String EMPTY_STYLENAME_MSG = "Style names cannot be empty";
  static String NULL_HANDLE_MSG = "Null widget handle. If you are creating a composite, ensure that initWidget() has been called.";

  /**
   * Stores a regular expression object to extract float values from the
   * leading portion of an input string.
   */
  static RegExp numberRegex = new RegExp("^(\\s*[+-]?((\\d+\\.?\\d*)|(\\.\\d+))([eE][+-]?\\d+)?)");

  dart_html.Element _element;

  /**
   * Returns whether the given element is visible in a way consistent with
   * {@link #setVisible(Element, boolean)}.
   *
   * <p>
   * Warning: implemented with a heuristic. The value returned takes into
   * account only the "display" style, ignoring CSS and Aria roles, thus may not
   * accurately reflect whether the element is actually visible in the browser.
   * </p>
   */
  static bool isVisible(dart_html.Element elem) {
    return (elem.style.display != 'none');
  }

  /**
   * Shows or hides the given element. Also updates the "aria-hidden" attribute.
   *
   * <p>
   * Warning: implemented with a heuristic based on the "display" style:
   * clears the "display" style to its default value if {@code visible} is true,
   * else forces the style to "none". If the "display" style is set to "none"
   * via CSS style sheets, the element remains invisible after a call to
   * {@code setVisible(elem, true)}.
   * </p>
   */
  static void setVisible(dart_html.Element elem, bool visible) {
    elem.style.display = visible ? '' : 'none';
    elem.attributes['aria-hidden'] = (!visible).toString();
  }


  //**************
  // HasVisibility
  //**************

  /**
   * Determines whether or not this object is visible. Note that this does not
   * necessarily take into account whether or not the receiver's parent is
   * visible, or even if it is attached to the
   * [Document]. The default implementation of this trait in [UIObject] is
   * based on the value of a dom element's style object's display attribute.
   *
   * @return <code>true</code> if the object is visible
   */
  bool get visible => isVisible(getElement());

  /**
   * Sets whether this object is visible.
   *
   * @param visible <code>true</code> to show the object, <code>false</code> to
   *          hide it
   */
  void set visible(bool visible) {
    setVisible(getElement(), visible);
  }

  //***********
  // PROPERTIES
  //***********

  /**
   * Sets this object's browser element. UIObject subclasses must call this
   * method before attempting to call any other methods, and it may only be
   * called once.
   *
   * @param elem the object's element
   */
  void setElement(dart_html.Element elem) {
    assert (_element == null);
    this._element = elem;
  }

  /**
   * Gets this object's browser element.
   */
  dart_html.Element getElement() {
    assert (_element != null); // : MISSING_ELEMENT_ERROR;
    return _element;
  }

  /**
   * Replaces this object's browser element.
   *
   * This method exists only to support a specific use-case in Image, and should
   * not be used by other classes.
   *
   * @param elem the object's new element
   */
  void replaceElement(dart_html.Element elem) {
    if (_element != null && _element.parent != null) {
      // replace this.element in its parent with elem.
      _element.replaceWith(elem);
    }

    this._element = elem;
  }

  /**
   * Sets the element's title.
   */
  void set title(String value) {
    getElement().title = value;
  }

  /**
   * Gets the title associated with this object. The title is the 'tool-tip'
   * displayed to users when they hover over the object.
   *
   * @return the object's title
   */
  String get title => getElement().title;

  /**
   * Sets the object's height. This height does not include decorations such as
   * border, margin, and padding.
   *
   * @param height the object's new height, in CSS units (e.g. "10px", "1em")
   */
  void setHeight(String height) {
    // This exists to deal with an inconsistency in IE's implementation where
    // it won't accept negative numbers in length measurements
    assert (extractLengthValue(height.trim().toLowerCase()) >= 0); // : "CSS heights should not be negative";
    Dom.setStyleAttribute(getElement(), "height", height);
  }

  /**
   * Sets the object's width. This width does not include decorations such as
   * border, margin, and padding.
   *
   * @param width the object's new width, in CSS units (e.g. "10px", "1em")
   */
  void setWidth(String width) {
    // This exists to deal with an inconsistency in IE's implementation where
    // it won't accept negative numbers in length measurements
    assert (extractLengthValue(width.trim().toLowerCase()) >= 0); // : "CSS widths should not be negative";
    Dom.setStyleAttribute(getElement(), "width", width);
  }

  /**
   * Sets the object's size, in pixels, not including decorations such as
   * border, margin, and padding.
   *
   * @param width the object's new width, in pixels
   * @param height the object's new height, in pixels
   */
  void setPixelSize(int width, int height) {
    if (width >= 0) {
      setWidth(width.toString() + "px");
    }
    if (height >= 0) {
      setHeight(height.toString() + "px");
    }
  }

  /**
   * Sets the object's size. This size does not include decorations such as
   * border, margin, and padding.
   *
   * @param width the object's new width, in CSS units (e.g. "10px", "1em")
   * @param height the object's new height, in CSS units (e.g. "10px", "1em")
   */
  void setSize(String width, String height) {
    setWidth(width);
    setHeight(height);
  }

  //*******
  // Styles
  //*******

  /**
   * Gets all of the element's style names, as a space-separated list.
   *
   * @param elem the element whose style is to be retrieved
   * @return the objects's space-separated style names
   */
  static String getElementStyleName(dart_html.Element elem) {
    return elem.$dom_className;
  }

  /**
   * Clears all of the element's style names and sets it to the given style.
   *
   * @param elem the element whose style is to be modified
   * @param styleName the new style name
   */
  static void setElementStyleName(dart_html.Element elem, String styleName) {
    elem.$dom_className = styleName;
  }


  /**
   * Gets the element's primary style name.
   *
   * @param elem the element whose primary style name is to be retrieved
   * @return the element's primary style name
   */
  static String getElementStylePrimaryName(dart_html.Element elem) {
    String fullClassName = getElementStyleName(elem);

    // The primary style name is always the first token of the full CSS class
    // name. There can be no leading whitespace in the class name, so it's not
    // necessary to trim() it.
    int spaceIdx = fullClassName.indexOf(' ');
    if (spaceIdx >= 0) {
      return fullClassName.substring(0, spaceIdx);
    }

    return fullClassName;
  }

  /**
   * Sets the element's primary style name and updates all dependent style
   * names.
   *
   * @param elem the element whose style is to be reset
   * @param style the new primary style name
   * @see #setStyleName(Element, String, boolean)
   */
  static void setElementStylePrimaryName(dart_html.Element elem, String style) {
    if (elem == null) {
      throw new Exception(NULL_HANDLE_MSG);
    }

    // Style names cannot contain leading or trailing whitespace, and cannot
    // legally be empty.
    style = style.trim();
    if (style.length == 0) {
      throw new Exception(EMPTY_STYLENAME_MSG);
    }

    _updatePrimaryAndDependentStyleNames(elem, style);
  }

  /**
   * This convenience method adds or removes a style name for a given element.
   * This method is typically used to add and remove secondary style names, but
   * it can be used to remove primary stylenames as well, but that is not
   * recommended. See {@link #setStyleName(String)} for a description of how
   * primary and secondary style names are used.
   *
   * @param elem the element whose style is to be modified
   * @param style the secondary style name to be added or removed
   * @param add <code>true</code> to add the given style, <code>false</code> to
   *          remove it
   */
  static void manageElementStyleName(dart_html.Element elem, String style, bool add) {
    if (elem == null) {
      throw new Exception(NULL_HANDLE_MSG);
    }

    style = style.trim();
    if (style.length == 0) {
      throw new Exception(EMPTY_STYLENAME_MSG);
    }

    // Keep it only for print
    String old = elem.$dom_className;

    if (add) {
      // Get the current style string.
      String oldClassName = elem.$dom_className;
      int idx = oldClassName.indexOf(style);

      // Calculate matching index.
      while (idx != -1) {
        if (idx == 0 || oldClassName[idx - 1] == ' ') {
          int last = idx + style.length;
          int lastPos = oldClassName.length;
          if ((last == lastPos)
              || ((last < lastPos) && (oldClassName[last] == ' '))) {
            break;
          }
        }
        idx = oldClassName.indexOf(style, idx + 1);
      }

      // Only add the style if it's not already present.
      if (idx == -1) {
        if (oldClassName.length > 0) {
          oldClassName = oldClassName + " ";
        }
        //setClassName(oldClassName + className);
        elem.$dom_className = oldClassName + style;
      }
    } else {
      // Get the current style string.
      String oldStyle = elem.$dom_className;
      int idx = oldStyle.indexOf(style);

      // Calculate matching index.
      while (idx != -1) {
        if (idx == 0 || oldStyle[idx - 1] == ' ') {
          int last = idx + style.length;
          int lastPos = oldStyle.length;
          if ((last == lastPos)
              || ((last < lastPos) && (oldStyle[last] == ' '))) {
            break;
          }
        }
        idx = oldStyle.indexOf(style, idx + 1);
      }

      // Don't try to remove the style if it's not there.
      if (idx != -1) {
        // Get the leading and trailing parts, without the removed name.
        String begin = oldStyle.substring(0, idx).trim();
        String end = oldStyle.substring(idx + style.length).trim();

        // Some contortions to make sure we don't leave extra spaces.
        String newClassName;
        if (begin.length == 0) {
          newClassName = end;
        } else if (end.length == 0) {
          newClassName = begin;
        } else {
          newClassName = begin + " " + end;
        }

        elem.$dom_className = newClassName;
      }
    }
  }

  /**
   * Replaces all instances of the primary style name with newPrimaryStyleName.
   */
  static void _updatePrimaryAndDependentStyleNames(dart_html.Element elem,
      String newPrimaryStyle) {
    List<String> classes = elem.$dom_className.split(new RegExp("\s+"));
    if (classes.length == 0) {
      return;
    }

    // Go through all class names and find one starting from 'dwt'
    // and move it to first position
    for (int i = 0; i < classes.length; i++) {
      String className = classes[i];
      if (className.startsWith("dwt")) {
        String tmp = classes[0];
        classes[0] = className;
        classes[i] = tmp;
        break;
      }
    }

    var oldPrimaryStyle = classes[0];
    var oldPrimaryStyleLen = oldPrimaryStyle.length;

    classes[0] = newPrimaryStyle;
    for (var i = 1, n = classes.length; i < n; i++) {
      var name = classes[i];
      if (name.length > oldPrimaryStyleLen
          && name[oldPrimaryStyleLen] == '-'
          && name.indexOf(oldPrimaryStyle) == 0) {
        classes[i] = newPrimaryStyle + name.substring(oldPrimaryStyleLen);
      }
    }
    elem.$dom_className = classes.join(" ");
  }

  /**
   * Adds a dependent style name by specifying the style name's suffix. The
   * actual form of the style name that is added is:
   *
   * <pre class="code">
   * getStylePrimaryName() + '-' + styleSuffix
   * </pre>
   *
   * @param styleSuffix the suffix of the dependent style to be added.
   * @see #setStylePrimaryName(String)
   * @see #removeStyleDependentName(String)
   * @see #setStyleDependentName(String, boolean)
   * @see #addStyleName(String)
   */
  void addStyleDependentName(String styleSuffix) {
    setStyleDependentName(styleSuffix, true);
  }

  /**
   * Adds a secondary or dependent style name to this object. A secondary style
   * name is an additional style name that is, in HTML/CSS terms, included as a
   * space-separated token in the value of the CSS <code>class</code> attribute
   * for this object's root element.
   *
   * <p>
   * The most important use for this method is to add a special kind of
   * secondary style name called a <i>dependent style name</i>. To add a
   * dependent style name, use {@link #addStyleDependentName(String)}, which
   * will prefix the 'style' argument with the result of
   * {@link #k()} (followed by a '-'). For example, suppose
   * the primary style name is <code>gwt-TextBox</code>. If the following method
   * is called as <code>obj.setReadOnly(true)</code>:
   * </p>
   *
   * <pre class="code">
   * public void setReadOnly(boolean readOnly) {
   *   isReadOnlyMode = readOnly;
   *
   *   // Create a dependent style name.
   *   String readOnlyStyle = "readonly";
   *
   *   if (readOnly) {
   *     addStyleDependentName(readOnlyStyle);
   *   } else {
   *     removeStyleDependentName(readOnlyStyle);
   *   }
   * }</pre>
   *
   * <p>
   * then both of the CSS style rules below will be applied:
   * </p>
   *
   * <pre class="code">
   *
   * // This rule is based on the primary style name and is always active.
   * .gwt-TextBox {
   *   font-size: 12pt;
   * }
   *
   * // This rule is based on a dependent style name that is only active
   * // when the widget has called addStyleName(getStylePrimaryName() +
   * // "-readonly").
   * .gwt-TextBox-readonly {
   *   background-color: lightgrey;
   *   border: none;
   * }</pre>
   *
   * <p>
   * The code can also be simplified with
   * {@link #setStyleDependentName(String, boolean)}:
   * </p>
   *
   * <pre class="code">
   * public void setReadOnly(boolean readOnly) {
   *   isReadOnlyMode = readOnly;
   *   setStyleDependentName("readonly", readOnly);
   * }</pre>
   *
   * <p>
   * Dependent style names are powerful because they are automatically updated
   * whenever the primary style name changes. Continuing with the example above,
   * if the primary style name changed due to the following call:
   * </p>
   *
   * <pre class="code">setStylePrimaryName("my-TextThingy");</pre>
   *
   * <p>
   * then the object would be re-associated with following style rules, removing
   * those that were shown above.
   * </p>
   *
   * <pre class="code">
   * .my-TextThingy {
   *   font-size: 20pt;
   * }
   *
   * .my-TextThingy-readonly {
   *   background-color: red;
   *   border: 2px solid yellow;
   * }</pre>
   *
   * <p>
   * Secondary style names that are not dependent style names are not
   * automatically updated when the primary style name changes.
   * </p>
   *
   * @param style the secondary style name to be added
   * @see UIObject
   * @see #removeStyleName(String)
   */
  void addStyleName(String style) {
    setStyleName(style, true);
  }

  /**
   * Gets all of the object's style names, as a space-separated list. If you
   * wish to retrieve only the primary style name, call
   * {@link #getStylePrimaryName()}.
   *
   * @return the objects's space-separated style names
   * @see #getStylePrimaryName()
   */
  String getStyleName() {
    return getElementStyleName(getStyleElement());
  }

  /**
   * Removes a dependent style name by specifying the style name's suffix.
   *
   * @param styleSuffix the suffix of the dependent style to be removed
   * @see #setStylePrimaryName(Element, String)
   * @see #addStyleDependentName(String)
   * @see #setStyleDependentName(String, boolean)
   */
  void removeStyleDependentName(String styleSuffix) {
    setStyleDependentName(styleSuffix, false);
  }

  /**
   * Removes a style name. This method is typically used to remove secondary
   * style names, but it can be used to remove primary stylenames as well. That
   * use is not recommended.
   *
   * @param style the secondary style name to be removed
   * @see #addStyleName(String)
   * @see #setStyleName(String, boolean)
   */
  void removeStyleName(String style) {
    setStyleName(style, false);
  }

  /**
   * Adds or removes a dependent style name by specifying the style name's
   * suffix. The actual form of the style name that is added is:
   *
   * <pre class="code">
   * getStylePrimaryName() + '-' + styleSuffix
   * </pre>
   *
   * @param styleSuffix the suffix of the dependent style to be added or removed
   * @param add <code>true</code> to add the given style, <code>false</code> to
   *          remove it
   * @see #setStylePrimaryName(Element, String)
   * @see #addStyleDependentName(String)
   * @see #setStyleName(String, boolean)
   * @see #removeStyleDependentName(String)
   */
  void setStyleDependentName(String styleSuffix, bool add) {
    setStyleName(getStylePrimaryName() + '-' + styleSuffix, add);
  }

  /**
   * Adds or removes a style name. This method is typically used to remove
   * secondary style names, but it can be used to remove primary stylenames as
   * well. That use is not recommended.
   *
   * @param style the style name to be added or removed
   * @param add <code>true</code> to add the given style, <code>false</code> to
   *          remove it
   * @see #addStyleName(String)
   * @see #removeStyleName(String)
   */
  void setStyleName(String style, bool add) {
    manageElementStyleName(getStyleElement(), style, add);
  }

  /**
   * Clears all of the object's style names and sets it to the given style. You
   * should normally use {@link #setStylePrimaryName(String)} unless you wish to
   * explicitly remove all existing styles.
   *
   * @param style the new style name
   * @see #setStylePrimaryName(String)
   */
  void clearAndSetStyleName(String style) {
    setElementStyleName(getStyleElement(), style);
  }

  /**
   * Gets the primary style name associated with the object.
   *
   * @return the object's primary style name
   * @see #setStyleName(String)
   * @see #addStyleName(String)
   * @see #removeStyleName(String)
   */
  String getStylePrimaryName() {
    return getElementStylePrimaryName(getStyleElement());
  }

  /**
   * Sets the object's primary style name and updates all dependent style names.
   *
   * @param style the new primary style name
   * @see #addStyleName(String)
   * @see #removeStyleName(String)
   */
  void setStylePrimaryName(String style) {
    setElementStylePrimaryName(getStyleElement(), style);
  }

  /**
   * Template method that returns the element to which style names will be
   * applied. By default it returns the root element, but this method may be
   * overridden to apply styles to a child element.
   *
   * @return the element to which style names will be applied
   */
  dart_html.Element getStyleElement() {
    return getElement();
  }

  /**
   * Intended to be used to pull the value out of a CSS length. If the
   * value is "auto" or "inherit", 0 will be returned.
   *
   * @param s The CSS length string to extract
   * @return The leading numeric portion of <code>s</code>, or 0 if "auto" or
   *         "inherit" are passed in.
   */
  double extractLengthValue(String s) {
    if (s == "auto" || s == "inherit" || s == "") {
      return 0.0;
    } else {
      // numberRegex divides the string into a leading numeric portion
      // followed by an arbitrary portion.
      if(numberRegex.hasMatch(s)) {
        // Extract the leading numeric portion of string
        s = numberRegex.firstMatch(s)[0];
      }
      return double.parse(s);
    }
  }

  /**
   * Gets the object's absolute left position in pixels, as measured from the
   * browser window's client area.
   *
   * @return the object's absolute left position
   */
  int getAbsoluteLeft() {
    return Dom.getAbsoluteLeft(getElement());
  }

  /**
   * Gets the object's absolute top position in pixels, as measured from the
   * browser window's client area.
   *
   * @return the object's absolute top position
   */
  int getAbsoluteTop() {
    return Dom.getAbsoluteTop(getElement());
  }

  /**
   * Gets the object's offset height in pixels. This is the total height of the
   * object, including decorations such as border and padding, but not margin.
   *
   * @return the object's offset height
   */
  int getOffsetHeight() {
    return getElement().offset.height; // Dom.getElementPropertyInt(getElement(), "offsetHeight");
  }

  /**
   * Gets the object's offset width in pixels. This is the total width of the
   * object, including decorations such as border and padding, but not margin.
   *
   * @return the object's offset width
   */
  int getOffsetWidth() {
    return getElement().offset.width; // Dom.getElementPropertyInt(getElement(), "offsetWidth");
  }

  /**
   * This method is overridden so that any object can be viewed in the debugger
   * as an HTML snippet.
   *
   * @return a string representation of the object
   */
  String toString() {
    if (_element == null) {
      return "(null handle)";
    }
    return getElement().toString();
  }

  //*******
  // Events
  //*******

  /**
   * Sinks a named event. Note that only {@link Widget widgets} may actually
   * receive events, but can receive events from all objects contained within
   * them.
   *
   * @param eventTypeName name of the event to sink on this element
   * @see com.google.gwt.user.client.Event
   */
  void sinkBitlessEvent(String eventTypeName) {
    Dom.sinkBitlessEvent(getElement(), eventTypeName);
  }

  /**
   * Adds a set of events to be sunk by this object. Note that only
   * {@link Widget widgets} may actually receive events, but can receive events
   * from all objects contained within them.
   *
   * @param eventBitsToAdd a bitfield representing the set of events to be added
   *          to this element's event set
   * @see com.google.gwt.user.client.Event
   */
  void sinkEvents(int eventBitsToAdd) {
    Dom.sinkEvents(getElement(), eventBitsToAdd | Dom.getEventsSunk(getElement()));
  }

  /**
   * Removes a set of events from this object's event list.
   *
   * @param eventBitsToRemove a bitfield representing the set of events to be
   *          removed from this element's event set
   * @see #sinkEvents
   * @see com.google.gwt.user.client.Event
   */
  void unsinkEvents(int eventBitsToRemove) {
    Dom.sinkEvents(getElement(), Dom.getEventsSunk(getElement()) & (~eventBitsToRemove));
  }
}
