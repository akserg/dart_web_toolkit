//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that presents a list of choices to the user, either as a list box or
 * as a drop-down list.
 *
 * <p>
 * <img class='gallery' src='doc-files/ListBox.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-ListBox { }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.ListBoxExample}
 * </p>
 *
 * <p>
 * <h3>Built-in Bidi Text Support</h3>
 * This widget is capable of automatically adjusting its direction according to
 * its content. This feature is controlled by {@link #setDirectionEstimator},
 * and is off by default.
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * The items of a ListBox element are laid out in &lt;g:item> elements.
 * Each item contains text that will be added to the list of available
 * items that will be shown, either in the drop down or list. (Note that
 * the tags of the item elements are not capitalized. This is meant to
 * signal that the item is not a runtime object, and so cannot have a
 * <code>ui:field</code> attribute.) It is also possible to explicitly
 * specify item's value using value attribute as shown below.
 * <p>
 * For example:
 *
 * <pre>
 * &lt;g:ListBox>
 *  &lt;g:item>
 *    first
 *  &lt;/g:item>
 *  &lt;g:item value='2'>
 *    second
 *  &lt;/g:item>
 * &lt;/g:ListBox>
 * </pre>
 * <p>
 * <h3>Important usage note</h3>
 * <b>Subclasses should neither read nor write option text directly from the
 * option elements created by this class, since such text may need to be wrapped
 * in Unicode bidi formatting characters. They can use the getOptionText and/or
 * setOptionText methods for this purpose instead.</b>
 */
class ListBox extends FocusWidget implements HasChangeHandlers, HasName,
  HasDirectionEstimator {

  static final int INSERT_AT_END = -1;

  static final String BIDI_ATTR_NAME = "bidiwrapped";

  /**
   * Creates a ListBox widget that wraps an existing &lt;select&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   * @return list box
   */
  factory ListBox.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    ListBox listBox = new ListBox(false, element);

    // Mark it attached and remember it for cleanup.
    listBox.onAttach();
    RootPanel.detachOnWindowClose(listBox);

    return listBox;
  }
  
  /**
   * Creates an empty list box in single selection mode.
   */
  ListBox([bool isMultipleSelect = false, dart_html.Element element = null]) : super(element == null ? new dart_html.SelectElement() : element) {
    setMultipleSelect(isMultipleSelect);
  }

  //************************************
  // Implementation of HasChangeHandlers
  //************************************

  /**
   * Adds a {@link ChangeEvent} handler.
   *
   * @param handler the change handler
   * @return {@link HandlerRegistration} used to remove this handler
   */
  HandlerRegistration addChangeHandler(ChangeHandler handler) {
    return addDomHandler(handler, ChangeEvent.TYPE);
  }

  //**************************
  // Implementation of HasName
  //**************************

  /**
   * Sets the widget's name.
   *
   * @param name the widget's new name
   */
  void set name(String value) {
    _getSelectElement().name = value;
  }

  /**
   * Gets the widget's name.
   *
   * @return the widget's name
   */
  String get name => _getSelectElement().name;

  //******
  // Items
  //******

  /**
   * Adds an item to the list box. This method has the same effect as
   *
   * <pre>
   * addItem(item, item)
   * </pre>
   *
   * @param item the text of the item to be added
   */
  void addItem(String item, [String value = null]) {
    if (value != null) {
      insertItem(item, null, value, INSERT_AT_END);
    } else {
      insertItem(item, null, item, INSERT_AT_END);
    }
  }

  /**
   * Removes all items from the list box.
   */
  void clear() {
    _getSelectElement().children.clear();
  }

  /**
   * Gets the number of items present in the list box.
   *
   * @return the number of items
   */
  int getItemCount() {
    return _getSelectElement().options.length;
  }

  /**
   * Gets the text associated with the item at the specified index.
   *
   * @param index the index of the item whose text is to be retrieved
   * @return the text associated with the item
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  String getItemText(int index) {
    _checkIndex(index);
    return getOptionText(_getSelectElement().options[index]);
  }

  /**
   * Gets the currently-selected item. If multiple items are selected, this
   * method will return the first selected item ({@link #isItemSelected(int)}
   * can be used to query individual items).
   *
   * @return the selected index, or <code>-1</code> if none is selected
   */
  int getSelectedIndex() {
    return _getSelectElement().selectedIndex;
  }

  /**
   * Gets the value associated with the item at a given index.
   *
   * @param index the index of the item to be retrieved
   * @return the item's associated value
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  String getValue(int index) {
    _checkIndex(index);
    return _getSelectElement().options[index].value;
  }

  /**
   * Gets the number of items that are visible. If only one item is visible,
   * then the box will be displayed as a drop-down list.
   *
   * @return the visible item count
   */
  int getVisibleItemCount() {
    return _getSelectElement().size;
  }

  /**
   * Sets the number of items that are visible. If only one item is visible,
   * then the box will be displayed as a drop-down list.
   *
   * @param visibleItems the visible item count
   */
  void setVisibleItemCount(int visibleItems) {
    _getSelectElement().size = visibleItems;
  }

  /**
   * Inserts an item into the list box, specifying its direction and an initial
   * value for the item. If the index is less than zero, or greater than or
   * equal to the length of the list, then the item will be appended to the end
   * of the list.
   *
   * @param item the text of the item to be inserted
   * @param dir the item's direction. If {@code null}, the item is displayed in
   *          the widget's overall direction, or, if a direction estimator has
   *          been set, in the item's estimated direction.
   * @param value the item's value, to be submitted if it is part of a
   *          {@link FormPanel}.
   * @param index the index at which to insert it
   */
  void insertItem(String item, TextDirection dir, String value, int index) {
    dart_html.SelectElement select = _getSelectElement();
    dart_html.OptionElement option = new dart_html.OptionElement();
    setOptionText(option, item, dir);
    option.value = value;

    int itemCount = select.length;
    if (index < 0 || index > itemCount) {
      index = itemCount;
    }
    if (index == itemCount) {
      select.children.add(option);
    } else {
      //dart_html.OptionElement before = select.options[index];
//      select.children.insertRange(index, 1);
//      select.children[index] = option;
      select.children.insert(index, option);
    }
  }

  /**
   * Determines whether an individual list item is selected.
   *
   * @param index the index of the item to be tested
   * @return <code>true</code> if the item is selected
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  bool isItemSelected(int index) {
    _checkIndex(index);
    return _getSelectElement().options[index].selected;
  }

  /**
   * Removes the item at the specified index.
   *
   * @param index the index of the item to be removed
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  void removeItem(int index) {
    _checkIndex(index);
    _getSelectElement().options[index].remove();
  }

  /**
   * Sets whether an individual list item is selected.
   *
   * <p>
   * Note that setting the selection programmatically does <em>not</em> cause
   * the {@link ChangeHandler#onChange(ChangeEvent)} event to be fired.
   * </p>
   *
   * @param index the index of the item to be selected or unselected
   * @param selected <code>true</code> to select the item
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  void setItemSelected(int index, bool selected) {
    _checkIndex(index);
    _getSelectElement().options[index].selected = selected;
  }

  /**
   * Sets the text associated with the item at a given index.
   *
   * @param index the index of the item to be set
   * @param text the item's new text
   * @param dir the item's direction.
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  void setItemText(int index, String text, TextDirection dir) {
    _checkIndex(index);
    if (text == null) {
      throw new Exception("NullPointer. Cannot set an option to have null text");
    }
    setOptionText(_getSelectElement().options[index], text, dir);
  }

  /**
   * Sets the currently selected index.
   *
   * After calling this method, only the specified item in the list will remain
   * selected. For a ListBox with multiple selection enabled, see
   * {@link #setItemSelected(int, boolean)} to select multiple items at a time.
   *
   * <p>
   * Note that setting the selected index programmatically does <em>not</em>
   * cause the {@link ChangeHandler#onChange(ChangeEvent)} event to be fired.
   * </p>
   *
   * @param index the index of the item to be selected
   */
  void setSelectedIndex(int index) {
    _getSelectElement().selectedIndex = index;
  }

  /**
   * Sets the value associated with the item at a given index. This value can be
   * used for any purpose, but is also what is passed to the server when the
   * list box is submitted as part of a {@link FormPanel}.
   *
   * @param index the index of the item to be set
   * @param value the item's new value; cannot be <code>null</code>
   * @throws IndexOutOfBoundsException if the index is out of range
   */
  void setValue(int index, String value) {
    _checkIndex(index);
    _getSelectElement().options[index].value = value;
  }

  /**
   * Retrieves the text of an option element. If the text was set by
   * {@link #setOptionText} and was wrapped with Unicode bidi formatting
   * characters, also removes those additional formatting characters.
   *
   * @param option an option element
   * @return the element's text
   */
  String getOptionText(dart_html.OptionElement option) {
    String text = option.text;
    if (option.attributes[BIDI_ATTR_NAME] != null && text.length > 1) {
      text = text.substring(1, text.length - 1);
    }
    return text;
  }

  /**
   * Sets the text of an option element. If the direction of the text is
   * opposite to the page's direction, also wraps it with Unicode bidi
   * formatting characters to prevent garbling, and indicates that this was done
   * by setting the option's <code>BIDI_ATTR_NAME</code> custom attribute.
   *
   * @param option an option element
   * @param text text to be set to the element
   * @param dir the text's direction. If {@code null} and direction estimation
   *          is turned off, direction is ignored.
   */
  void setOptionText(dart_html.OptionElement option, String text, [TextDirection dir = null]) {
//    if (dir == null && estimator != null) {
//      dir = estimator.estimateDirection(text);
//    }
    if (dir == null) {
      option.text = text;
      option.attributes.remove(BIDI_ATTR_NAME);
//    } else {
//      String formattedText = BidiFormatter.getInstanceForCurrentLocale().unicodeWrapWithKnownDir(dir, text, false /* isHtml */, false /* dirReset */);
//      option.setText(formattedText);
//      if (formattedText.length > text.length) {
//        option.attribute[BIDI_ATTR_NAME] = "";
//      } else {
//        option.attribute[BIDI_ATTR_NAME].remove();
//      }
    }
  }

  /**
   * Gets whether this list allows multiple selection.
   *
   * @return <code>true</code> if multiple selection is allowed
   */
  bool isMultipleSelect() {
    return _getSelectElement().multiple;
  }

  void setMultipleSelect(bool multiple) {
    _getSelectElement().multiple = multiple;
  }

  void _checkIndex(int index) {
    if (index < 0 || index >= getItemCount()) {
      throw new Exception("IndexOutOfBoundsException");
    }
  }

  dart_html.SelectElement _getSelectElement() {
    return getElement() as dart_html.SelectElement;
  }
}
