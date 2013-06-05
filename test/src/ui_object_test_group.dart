//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_test;

/**
 * UiObject Tests.
 */
class UiObjectTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "UiObject";

    // Static methods
    this.testList["isVisible"] = isVisibleTest;
    this.testList["setVisible"] = setVisibleTest;
    this.testList["getElementStyleName"] = getElementStyleNameTest;
    this.testList["setElementStyleName"] = setElementStyleNameTest;
    this.testList["getElementStylePrimaryName"] = getElementStylePrimaryNameTest;
    this.testList["setElementStylePrimaryName"] = setElementStylePrimaryNameTest;
    this.testList["manageElementStyleName"] = manageElementStyleNameTest;
    
    // Instance level methods
    this.testList["addStyleDependentName"] = addStyleDependentNameTest;
    this.testList["addStyleName"] = addStyleNameTest;
    this.testList["clearAndSetStyleName"] = clearAndSetStyleNameTest;
    this.testList["extractLengthValue"] = extractLengthValueTest;
    this.testList["getAbsoluteLeft"] = getAbsoluteLeftTest;
    this.testList["getAbsoluteTop"] = getAbsoluteTopTest;
    this.testList["getElement"] = getElementTest;
    this.testList["getOffsetHeight"] = getOffsetHeightTest;
    this.testList["getOffsetWidth"] = getOffsetWidthTest;
    this.testList["getStyleElement"] = getStyleElementTest;
    this.testList["getStyleName"] = getStyleNameTest;
    this.testList["getStylePrimaryName"] = getStylePrimaryNameTest;
    this.testList["removeStyleDependentName"] = removeStyleDependentNameTest;
    this.testList["removeStyleName"] = removeStyleNameTest;
    this.testList["replaceElement"] = replaceElementTest;
    this.testList["setElement"] = setElementTest;
    this.testList["setHeight"] = setHeightTest;
    this.testList["setPixelSize"] = setPixelSizeTest;
    this.testList["setSize"] = setSizeTest;
    this.testList["setStyleDependentName"] = setStyleDependentNameTest;
    this.testList["setStyleName"] = setStyleNameTest;
    this.testList["setStylePrimaryName"] = setStylePrimaryNameTest;
    this.testList["setWidth"] = setWidthTest;

    this.testList["getTitle"] = getTitleTest;
    this.testList["setTitle"] = setTitleTest;
    this.testList["getVisible"] = getVisibleUiObjectTest;
    this.testList["setVisible"] = setVisibleUiObjectTest;

//    this.testList["sinkBitlessEvent"] = sinkBitlessEventTest;
//    this.testList["sinkEvents"] = sinkEventsTest;
//    this.testList["unsinkEvents"] = unsinkEventsTest;
  }

  //***************
  // Static methods
  //***************
  
  /**
   * Check static method [UiObject.isVisible].
   * 
   * Returns whether the given element is visible.
   */
  void isVisibleTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element always visible
    expect(ui.UiObject.isVisible(element), isTrue);
    // Set element invisible
    element.style.display = "none";
    // Check does element invisible
    expect(ui.UiObject.isVisible(element), isFalse);
    // Set element visible
    element.style.display = "";
    // Check does element visible
    expect(ui.UiObject.isVisible(element), isTrue);
  }
  
  /**
   * Check static method [UiObject.setVisible].
   * 
   * Shows or hides the given element. Also updates the "aria-hidden" attribute.
   */
  void setVisibleTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element always visible
    expect(element.style.display,  isEmpty);
    // Set element invisible
    ui.UiObject.setVisible(element, false);
    // Check does element invisible
    expect(element.style.display,  equals("none"));
    // Check 'aria-hidden'
    expect(element.attributes['aria-hidden'], 'true');
    // Set element visible
    ui.UiObject.setVisible(element, true);
    // Check does element visible
    expect(element.style.display,  isEmpty);
    expect(element.attributes['aria-hidden'], 'false');

  }
  
  /**
   * Check static method [UiObject.getElementStyleName].
   * 
   * Gets all of the element's style names, as a space-separated list.
   */
  void getElementStyleNameTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element's style names empty.
    expect(ui.UiObject.getElementStyleName(element), isEmpty);
    // Set styles as a iterable list of styles
    element.classes.addAll(["selected", "tested"]);
    // Check styles names
    expect(ui.UiObject.getElementStyleName(element), equals("selected tested"));
  }
  
  /**
   * Check static method [UiObject.setElementStyleName].
   * 
   * Clears all of the element's style names and sets it to the given style.
   */
  void setElementStyleNameTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element's style names empty.
    expect(element.classes.length, equals(0));
    // Set styles as a space-separated list
    ui.UiObject.setElementStyleName(element, "selected tested");
    // Check styles names
    expect(element.classes.contains("selected"), isTrue);
    expect(element.classes.contains("tested"), isTrue);
  }
  
  /**
   * Check static method [UiObject.getElementStylePrimaryName].
   * 
   * Gets the element's primary style name.
   */
  void getElementStylePrimaryNameTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element's style names empty.
    expect(element.$dom_className, isEmpty);
    // Set element's style names
    element.$dom_className = 'ui-Object selected';
    // The primary style name is always the first token of the full CSS class
    // name.
    expect(ui.UiObject.getElementStylePrimaryName(element), equals('ui-Object'));
  }
  
  /**
   * Check static method [UiObject.setElementStylePrimaryName].
   * 
   * Sets the element's primary style name and updates all dependent style
   * names.
   */
  void setElementStylePrimaryNameTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element's style names empty.
    expect(element.$dom_className, isEmpty);
    // Set element's style names
    ui.UiObject.setElementStylePrimaryName(element, 'ui-Object');  
    // The primary style name is always the first token of the full CSS class
    // name.
    expect(element.$dom_className, equals('ui-Object'));
  }
  
  /**
   * Check static method [UiObject.manageElementStyleName].
   * 
   * This convenience method adds or removes a style name for a given element.
   */
  void manageElementStyleNameTest() {
    dart_html.Element element = new dart_html.DivElement();
    // By default element's style names empty.
    expect(element.$dom_className, isEmpty);
    // Add primary style name
    element.$dom_className = "ui-Object";
    // Add secondary style
    ui.UiObject.manageElementStyleName(element, "selected", true);
    // Check it
    expect(element.$dom_className.split(" ")[1], equals("selected"));
    // Remove secondary style
    ui.UiObject.manageElementStyleName(element, "selected", false);
    // Check it
    expect(element.$dom_className, equals("ui-Object"));
    // Remove secondary element's style without exception again
    ui.UiObject.manageElementStyleName(element, "selected", false);
    // Check it again
    expect(element.$dom_className, equals("ui-Object"));
  }
  
  //***********************
  // Instance level methods
  //***********************
  
  SolidUiObject _uiObject;
  dart_html.Element _element;
  
  void _initTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
  }
  
  /**
   * Check method [UiObject.addStyleDependentName].
   * 
   * Adds a dependent style name by specifying the style name's suffix. The
   * actual form of the style name that is added is:
   *
   * <pre class="code">
   * getStylePrimaryName() + '-' + styleSuffix
   * </pre>
   */
  void addStyleDependentNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set primary style name
    _element.$dom_className = "ui-Object";
    // Add name suffix
    _uiObject.addStyleDependentName("selected");
    // Check style
    expect(_element.$dom_className, equals("ui-Object ui-Object-selected"));
  }
  
  
  /**
   * Check method [UiObject.addStyleName].
   * 
   * Adds a secondary or dependent style name to this object.
   * 
   */
  void addStyleNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set primary style name
    _element.$dom_className = "ui-Object";
    // Add style
    _uiObject.addStyleName("selected");
    // Check style
    expect(_element.$dom_className, equals("ui-Object selected"));
  }
  
  /**
   * Check method [UiObject.clearAndSetStyleName].
   * 
   * Clears all of the object's style names and sets it to the given style.
   */
  void clearAndSetStyleNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set new style
    _uiObject.clearAndSetStyleName("ui-Object");
    // Check it
    expect(_element.$dom_className, equals("ui-Object"));
  }
  
  /**
   * Check method [UiObject.extractLengthValue].
   * 
   * Intended to be used to pull the value out of a CSS length. If the
   * value is "auto" or "inherit", 0 will be returned.
   */
  void extractLengthValueTest() {
    expect(_uiObject.extractLengthValue("auto"), equals(0.0));
    expect(_uiObject.extractLengthValue("inherit"), equals(0.0));
    expect(_uiObject.extractLengthValue(""), equals(0.0));
    expect(_uiObject.extractLengthValue("10.0px"), equals(10.0));
  }
  
  /**
   * Check method [UiObject.getAbsoluteLeft].
   * 
   * Gets the object's absolute left position in pixels, as measured from the
   * browser window's client area.
   */
  void getAbsoluteLeftTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
    // Check it
    expect(_uiObject.getAbsoluteLeft(), 0);
  }
  
  /**
   * Check method [UiObject.getAbsoluteLeft].
   * 
   * Gets the object's absolute top position in pixels, as measured from the
   * browser window's client area.
   */
  void getAbsoluteTopTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
    // Check it
    expect(_uiObject.getAbsoluteTop(), 0);
  }
 
  /**
   * Check method [UiObject.getElement].
   * 
   * Gets this object's browser element.
   */
  void getElementTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
    //
    expect(_uiObject.getElement(), equals(_element));
  }
  
  /**
   * Check method [UiObject.getOffsetHeight].
   * 
   * Gets the object's offset height in pixels. This is the total height of the
   * object, including decorations such as border and padding, but not margin.
   */
  void getOffsetHeightTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
    // Check it
    expect(_uiObject.getOffsetHeight(), 0);
  }
  
  /**
   * Check method [UiObject.getOffsetWidth].
   * 
   * Gets the object's offset width in pixels. This is the total width of the
   * object, including decorations such as border and padding, but not margin.
   */
  void getOffsetWidthTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
    // Check it
    expect(_uiObject.getOffsetWidth(), 0);
  }
  
  /**
   * Check method [UiObject.getStyleElement].
   * 
   * Template method that returns the element to which style names will be
   * applied. By default it returns the root element, but this method may be
   * overridden to apply styles to a child element.
   */
  void getStyleElementTest() {
    // Create UiObject
    _uiObject = new SolidUiObject();
    // Create element
    _element = new dart_html.DivElement();
    // Set element
    _uiObject.setElement(_element);
    //
    expect(_uiObject.getStyleElement(), equals(_element));
  }
  
  /**
   * Check method [UiObject.getStyleName].
   * 
   * Gets all of the object's style names, as a space-separated list.
   */
  void getStyleNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_uiObject.getStyleName(), isEmpty);
    // Set styles as a iterable list of styles
    _element.classes.addAll(["selected", "tested"]);
    // Check styles names
    expect(_uiObject.getStyleName(), equals("selected tested"));
  }
  
  /**
   * Check static method [UiObject.getStylePrimaryName].
   * 
   * Gets the primary style name associated with the object.
   */
  void getStylePrimaryNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set element's style names
    _element.$dom_className = 'ui-Object selected';
    // The primary style name is always the first token of the full CSS class
    // name.
    expect(_uiObject.getStylePrimaryName(), equals('ui-Object'));
  }
  
  /**
   * Check method [UiObject.removeStyleDependentName].
   * 
   * Removes a dependent style name by specifying the style name's suffix.
   */
  void removeStyleDependentNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set primary style name
    _element.$dom_className = "ui-Object";
    // Add name suffix
    _uiObject.addStyleDependentName("selected");
    // Check style
    expect(_element.$dom_className, equals("ui-Object ui-Object-selected"));
    // Remove
    _uiObject.removeStyleDependentName("selected");
    // Check style
    expect(_element.$dom_className, equals("ui-Object"));
  }
  
  /**
   * Check method [UiObject.removeStyleName].
   * 
   * Removes a style name. This method is typically used to remove secondary
   * style names.
   * 
   */
  void removeStyleNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set primary style name
    _element.$dom_className = "ui-Object";
    // Add style
    _uiObject.addStyleName("selected");
    // Check style
    expect(_element.$dom_className, equals("ui-Object selected"));
    // Remove
    _uiObject.removeStyleName("selected");
    // Check style
    expect(_element.$dom_className, equals("ui-Object"));
  }
  
  /**
   * Check method [UiObject.replaceElement].
   * 
   * Replaces this object's browser element.
   */
  void replaceElementTest() {
    _initTest();
    // Create new element
    dart_html.Element newElement = new dart_html.DivElement();
    // Replace 
    _uiObject.replaceElement(newElement);
    // Check it
    expect(_uiObject.getElement(), equals(newElement));
  }
  
  /**
   * Check method [UiObject.setElement].
   * 
   * Sets this object's browser element.
   */
  void setElementTest() {
    _initTest();
    // Check it
    expect(_uiObject.getElement(), equals(_element));
  }
  
  /**
   * Check method [UiObject.setHeight].
   * 
   * Sets the object's height. This height does not include decorations such as
   * border, margin, and padding.
   */
  void setHeightTest() {
    _initTest();
    // Element's default height is empty
    expect(_element.style.height, isEmpty);
    // Set height
    _uiObject.setHeight("100px");
    // Check it
    expect(_element.style.height, equals("100px"));
  }
  
  /**
   * Check method [UiObject.setPixelSize].
   * 
   * Sets the object's size, in pixels, not including decorations such as
   * border, margin, and padding.
   */
  void setPixelSizeTest() {
    _initTest();
    // Element's default wight and height are empty
    expect(_element.style.width, isEmpty);
    expect(_element.style.height, isEmpty);
    // Set pixel size
    _uiObject.setPixelSize(50, 100);
    // Check it
    expect(_element.style.width, equals("50px"));
    expect(_element.style.height, equals("100px"));
  }
  
  /**
   * Check method [UiObject.setSize].
   * 
   * Sets the object's size. This size does not include decorations such as
   * border, margin, and padding.
   */
  void setSizeTest() {
    _initTest();
    // Element's default wight and height are empty
    expect(_element.style.width, isEmpty);
    expect(_element.style.height, isEmpty);
    // Set size
    _uiObject.setSize("50px", "100%");
    // Check it
    expect(_element.style.width, equals("50px"));
    expect(_element.style.height, equals("100%"));
  }

  /**
   * Check method [UiObject.setStyleDependentName].
   * 
   * Adds or removes a dependent style name by specifying the style name's
   * suffix. The actual form of the style name that is added is:
   *
   * <pre class="code">
   * getStylePrimaryName() + '-' + styleSuffix
   * </pre>
   */
  void setStyleDependentNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set primary style name
    _element.$dom_className = "ui-Object";
    // Add name suffix
    _uiObject.setStyleDependentName("selected", true);
    // Check style
    expect(_element.$dom_className, equals("ui-Object ui-Object-selected"));
    // Remove name suffix
    _uiObject.setStyleDependentName("selected", false);
    // Check style
    expect(_element.$dom_className, equals("ui-Object"));
  }
  
  /**
   * Check method [UiObject.setStyleName].
   * 
   * Adds or removes a style name. This method is typically used to remove
   * secondary style names.
   * 
   */
  void setStyleNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set primary style name
    _element.$dom_className = "ui-Object";
    // Add style
    _uiObject.setStyleName("selected", true);
    // Check style
    expect(_element.$dom_className, equals("ui-Object selected"));
    // Remove style
    _uiObject.setStyleName("selected", false);
    // Check style
    expect(_element.$dom_className, equals("ui-Object"));
  }
  
  /**
   * Check static method [UiObject.setStylePrimaryName].
   * 
   * Sets the object's primary style name and updates all dependent style names.
   */
  void setStylePrimaryNameTest() {
    _initTest();
    // By default element's style names empty.
    expect(_element.$dom_className, isEmpty);
    // Set element's style names
    _element.$dom_className = 'ui-Object selected';
    // Check it
    expect(_uiObject.getStylePrimaryName(), equals('ui-Object'));
    // Set primary style name
    _uiObject.setStylePrimaryName("ui-Object2");
    // Check it
    expect(_uiObject.getStylePrimaryName(), equals('ui-Object2'));
  }
  
  /**
   * Check method [UiObject.setHeight].
   * 
   * Sets the object's height. This height does not include decorations such as
   * border, margin, and padding.
   */
  void setWidthTest() {
    _initTest();
    // Element's default height is empty
    expect(_element.style.width, isEmpty);
    // Set width
    _uiObject.setWidth("100px");
    // Check it
    expect(_element.style.width, equals("100px"));
  }
  
  /**
   * Check method [UiObject.title].
   * 
   * Gets the title associated with this object. The title is the 'tool-tip'
   * displayed to users when they hover over the object.
   */
  void getTitleTest() {
    _initTest();
    // Default title is empty
    expect(_uiObject.title, isEmpty);
    // Set new title
    _element.title = "New Title";
    // Check it
    expect(_uiObject.title, equals("New Title"));
  }
  
  /**
   * Check method [UiObject.title].
   * 
   * Sets the element's title.
   */
  void setTitleTest() {
    _initTest();
    // Default title is empty
    expect(_element.title, isEmpty);
    // Set new title
    _uiObject.title = "New Title";
    // Check it
    expect(_element.title, equals('New Title'));
  }
  
  /**
   * Check method [UiObject.visible].
   * 
   * Determines whether or not this object is visible.
   */
  void getVisibleUiObjectTest() {
    _initTest();
    // Default visible state is true
    expect(_uiObject.visible, isTrue);
    // Set new visible state
    _element.style.display = "none";
    // Check it
    expect(_uiObject.visible, isFalse);
    // Set new visible state
    _element.style.display = "";
    // Check it
    expect(_uiObject.visible, isTrue);
  }
  
  /**
   * Check method [UiObject.setVisible].
   * 
   * Sets whether this object is visible.
   */
  void setVisibleUiObjectTest() {
    _initTest();
    // Default visible state is empty
    expect(_element.style.display, isEmpty);
    // Set new visible state
    _uiObject.visible = false;
    // Check it
    expect(_element.style.display, equals("none"));
    // Set new visible state
    _uiObject.visible = true;
    // Check it
    expect(_element.style.display, isEmpty);
  }
  
  /**
   * Check method [UiObject.sinkBitlessEvent].
   * 
   * Sinks a named event.
   */
//  void sinkBitlessEventTest() {
//    _initTest();
    //
//    Function failure = (dart_async.AsyncError asyncError) {
//      fail("Failed");
//    };
    // By default elemen does not listen 'drop' event
//    _element.onDrop.length.then((int length){
//      expect(length, equals(0));
//      // Sink 'drop' event
//      _uiObject.sinkBitlessEvent("drop");
//      // Check it
//      dart_async.Future<int> futureLength2 = _element.onDrop.length;
//      futureLength2.then((int newLength) {
//        expect(newLength, equals(1));
//      }, onError:failure);
//    }, onError:failure);
//  }
}