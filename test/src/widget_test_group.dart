//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_test;

/**
 * Test Widget.
 */
class WidgetTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Widget";

    this.testList["asWidget"] = asWidgetTest;
    this.testList["addAttachHandler"] = addAttachHandlerTest;
    this.testList["addHandler"] = addHandlerTest;
    this.testList["ensureHandlers"] = ensureHandlersTest;
    this.testList["getEventBus"] = getEventBusTest;
    this.testList["addBitlessDomHandler"] =  addBitlessDomHandlerTest;
    this.testList["addDomHandler"] = addDomHandlerTest;
    this.testList["createEventBus"] = createEventBusTest;
    this.testList["getLayoutData setLayoutData"] = getSetLayoutDataTest;
    this.testList["getParent setParent removeFromParent"] = getSetParentTest;
    this.testList["replaceElement"] = replaceElementTest;
    this.testList["onAttach onDetach isAttached"] = onAttachDetachTest;

//    this.testList["onBrowserEvent"] = onBrowserEventTest;
//    this.testList["fireEvent"] = fireEventTest;
//    this.testList["sinkEvents"] = sinkEventsTest;
//    this.testList["isOrWasAttached"] = isOrWasAttachedTest;
//    this.testList["delegateEvent"] = delegateEventTest;
  }

  /**
   * Check method [Widget.asWidget].
   * 
   * Returns the [Widget] aspect of the receiver.
   */
  void asWidgetTest() {
    ui.Widget widget = new ui.Widget();
    expect(widget.asWidget(), equals(widget));
  }
  
  /**
   * Check method [Widget.addAttachHandler].
   * 
   * Adds an [AttachEvent] handler.
   */
  void addAttachHandlerTest() {
    ui.Widget widget = new ui.Widget();
    // Create AttachEventHandler
    event.AttachEventHandler handler = new event.AttachEventHandlerAdapter((event.AttachEvent evt){});
    // Add it to widget
    event.HandlerRegistration handlerRegistration = widget.addAttachHandler(handler);
    // Check handlerRegistration
    expect(handlerRegistration, isNotNull);
  }
  
  /**
   * Check method [Widget.addHandler].
   * 
   * Adds this handler to the widget.
   */
  void addHandlerTest() {
    ui.Widget widget = new ui.Widget();
    // Create AttachEventHandler
    event.AttachEventHandler handler = new event.AttachEventHandlerAdapter((event.AttachEvent evt){});
    // Add it to widget
    event.HandlerRegistration handlerRegistration = widget.addHandler(handler, event.AttachEvent.TYPE);
    // Check handlerRegistration
    expect(handlerRegistration, isNotNull);
  }
  
  /**
   * Check method [Widget.ensureHandlers].
   * 
   * Ensures the existence of the event bus.
   */
  void ensureHandlersTest() {
    ui.Widget widget = new ui.Widget();
    // EventBus is null by default
    expect(widget.getEventBus(), isNull);
    // Method ensureHandlers creates eventBus if empty
    expect(widget.ensureHandlers(), isNotNull);
    // Request EventBus again and compare with first one
    expect(widget.ensureHandlers(), equals(widget.getEventBus()));
  }
  
  /**
   * Check method [Widget.getEventBus].
   * 
   * Return EventBus.
   */
  void getEventBusTest() {
    ui.Widget widget = new ui.Widget();
    // EventBus is null by default
    expect(widget.getEventBus(), isNull);
    // Create EventBus
    widget.ensureHandlers();
    // Request EventBus again
    expect(widget.getEventBus(), isNotNull);
  }
  
  /**
   * Check method [Widget.addBitlessDomHandler].
   * 
   * Adds bitless handler to the widget.
   */
  void addBitlessDomHandlerTest() {
    ui.Widget widget = new ui.Widget();
    // Create an Element
    dart_html.Element element = new dart_html.DivElement();
    // Set element
    widget.setElement(element);
    // Create DragHandler
    event.DragHandler handler = new event.DragHandlerAdapter((event.DragEvent evt){});
    // Add it to widget
    event.HandlerRegistration handlerRegistration = widget.addBitlessDomHandler(handler, event.DragEvent.TYPE);
    // Check handlerRegistration
    expect(handlerRegistration, isNotNull);
  }
  
  /**
   * Check method [Widget.addDomHandler].
   * 
   * Adds a native event handler to the widget and sinks the corresponding
   * native event.
   */
  void addDomHandlerTest() {
    ui.Widget widget = new ui.Widget();
    // Create an Element
    dart_html.Element element = new dart_html.DivElement();
    // Set element
    widget.setElement(element);
    // Create DragHandler
    event.ClickHandler handler = new event.ClickHandlerAdapter((event.ClickEvent evt){});
    // Add it to widget
    event.HandlerRegistration handlerRegistration = widget.addDomHandler(handler, event.ClickEvent.TYPE);
    // Check handlerRegistration
    expect(handlerRegistration, isNotNull);
  }
  
  /**
   * Check method [Widget.createEventBus].
   */
  void createEventBusTest() {
    ui.Widget widget = new ui.Widget();
    // Create two different EventBus
    expect(widget.createEventBus() != widget.createEventBus(), isTrue);
  }
  
  /**
   * Check method [Widget.getLayoutData] and [Widget.setLayoutData].
   * 
   * Returns whether or not the receiver is attached to the
   * [Document]'s [BodyElement].
   * Sets the panel-defined layout data associated with this widget.
   */
  void getSetLayoutDataTest() {
    ui.Widget widget = new ui.Widget();
    // Check LayoutData
    expect(widget.getLayoutData(), isNull);
    // Assign new data
    Object layoutData = new Object();
    widget.setLayoutData(layoutData);
    // Check it
    expect(widget.getLayoutData(), isNotNull);
    expect(widget.getLayoutData(), equals(layoutData));
  }
  
  /**
   * Check method [Widget.getParent] and [Widget.setParent].
   * 
   * Gets this widget's parent panel.
   * Sets this widget's parent.
   */
  void getSetParentTest() {
    ui.Widget widget = new ui.Widget();
    // Create an Element
    dart_html.Element element = new dart_html.DivElement();
    // Set element
    widget.setElement(element);
    // Create parent
    ui.Panel parentWidget = new ui.SimplePanel();
    // Check parent widget
    expect(widget.getParent(), isNull);
    // Attach widget to parent
    parentWidget.add(widget);
    // Check it
    expect(widget.getParent(), equals(parentWidget));
    // Remove from parent
    widget.removeFromParent();
    // Set new parent widget
    ui.Panel parentWidget2 = new ui.SimplePanel();
    // Set new parent
    widget.setParent(parentWidget2);
    // Check it
    expect(widget.getParent(), equals(parentWidget2));
  }
  
  /**
   * Check method [Widget.replaceElement].
   * 
   * Replaces this object's browser element.
   */
  void replaceElementTest() {
    ui.Widget widget = new ui.Widget();
    // Create an Element
    dart_html.Element element = new dart_html.DivElement();
    // Set element
    widget.setElement(element);
    // Check it
    expect(widget.getElement(), equals(element));
    // Replace element
    widget.replaceElement(new dart_html.DivElement());
    // Check it
    expect(widget.getElement() != element, isTrue);
  }
  
  /**
   * Check method [Widget.onAttach], [Widget.onDetach] and [Widget.isAttached].
   * 
   * This method is called when a widget is attached to the browser's document.
   * This method is called when a widget is detached from the browser's
   * document.
   * Returns whether or not the receiver is attached to the
   * [Document]'s [BodyElement].
   */
  void onAttachDetachTest() {
    ui.Widget widget = new ui.Widget();
    // Create an Element
    dart_html.Element element = new dart_html.DivElement();
    // Set element
    widget.setElement(element);
    // Element must not be attached
    expect(widget.isAttached(), isFalse);
    // Attach it
    ui.RootPanel.get().add(widget);
    // Widget's element must be attached to
    expect(widget.isAttached(), isTrue);
    // Detach it
    ui.RootPanel.get().remove(widget);
    // Widget's element must be attached to
    expect(widget.isAttached(), isFalse);
  }
}