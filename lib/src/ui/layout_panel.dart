//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that lays its children out in arbitrary
 * {@link com.google.gwt.layout.client.Layout.Layer layers} using the
 * {@link Layout} class.
 * 
 * <p>
 * This widget will <em>only</em> work in standards mode, which requires that
 * the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 * 
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.LayoutPanelExample}
 * </p>
 * 
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * LayoutPanel elements in {@link com.google.gwt.uibinder.client.UiBinder
 * UiBinder} templates lay out their children with arbitrary constraints, using
 * &lt;g:layer> elements. Each layer may have any of the following constraint
 * attributes specified as CSS length attributes: <code>left</code>,
 * <code>top</code>, <code>right</code>, <code>bottom</code>, <code>width</code>
 * , and <code>height</code>.
 * 
 * <p>
 * Precisely zero or two constraints are required for each axis (horizontal and
 * vertical). Specifying no constraints implies that the child should fill that
 * axis completely.
 * 
 * <p>
 * The valid sets of horizontal constraints are:
 * <dl>
 * <dt>(none)
 * <dd>Fill the parent's horizontal axis
 * <dt>left, width
 * <dd>Fixed width, positioned from parent's left edge
 * <dt>right, width
 * <dd>Fixed width, positioned from parent's right edge
 * <dt>left, right
 * <dd>Width implied by fixed distance from parent's left and right edges
 * </dl>
 * 
 * <p>
 * The valid sets of vertical constraints are:
 * <dl>
 * <dt>(none)
 * <dd>Fill the parent's vertical axis
 * <dt>top, height
 * <dd>Fixed height, positioned from parent's top edge
 * <dt>bottom, height
 * <dd>Fixed height, positioned from parent's bottom edge
 * <dt>top, bottom
 * <dd>Height implied by fixed distance from parent's top and bottom edges
 * </dl>
 * 
 * <p>
 * The values of constraint attributes can be any valid <a
 * href='http://www.w3.org/TR/CSS21/syndata.html#length-units'>CSS length</a>,
 * such as <code>1px</code>, <code>3em</code>, or <code>0</code> (zero lengths require no
 * units).
 * 
 * <p>
 * For example:
 * 
 * <pre>
 * &lt;g:LayoutPanel>
 *   &lt;!-- No constraints causes the layer to fill the parent -->
 *   &lt;g:layer>
 *     &lt;g:Label>Lorem ipsum...&lt;/g:Label>
 *   &lt;/g:layer>
 *   &lt;!-- Position horizontally 25% from each edge;
 *        Vertically 4px from the top and 10em tall. -->
 *   &lt;g:layer left='25%' right='25%' top='4px' height='10em'>
 *     &lt;g:Label>Header&lt;/g:Label>
 *   &lt;/g:layer>
 * &lt;/g:LayoutPanel>
 * </pre>
 */
class LayoutPanel extends ComplexPanel implements AnimatedLayout, RequiresResize, ProvidesResize {
  
  Layout _layout;
  LayoutCommand _layoutCmd;
  
  /**
   * Creates an empty layout panel.
   */
  LayoutPanel() {
    setElement(new dart_html.DivElement());
    _layout = new Layout(getElement());
    _layoutCmd = new LayoutCommand(_layout);
  }
  
  /**
   * Adds a widget to this panel.
   * 
   * <p>
   * By default, each child will fill the panel. To build more interesting
   * layouts, set child widgets' layout constraints using
   * {@link #setWidgetLeftRight(Widget, double, Style.Unit, double, Style.Unit)}
   * and related methods.
   * </p>
   * 
   * @param widget the widget to be added
   */
  void add(Widget widget) {
    _insert(widget, getWidgetCount());
  }
  
  void animate(int duration, [LayoutAnimationCallback callback = null]) {
    _layoutCmd.schedule(duration, callback);
  }
  
  void forceLayout() {
    _layoutCmd.cancel();
    _layout.layout();
    onResize();
  }
  
  /**
   * Gets the container element wrapping the given child widget.
   * 
   * @param child
   * @return the widget's container element
   */
  dart_html.Element getWidgetContainerElement(Widget child) {
    _assertIsChild(child);
    return _getLayer(child).getContainerElement();
  }
  
  /**
   * Inserts a widget before the specified index.
   * 
   * <p>
   * By default, each child will fill the panel. To build more interesting
   * layouts, set child widgets' layout constraints using
   * {@link #setWidgetLeftRight(Widget, double, Style.Unit, double, Style.Unit)}
   * and related methods.
   * </p>
   * 
   * <p>
   * Inserting a widget in this way has no effect on the DOM structure, but can
   * be useful for other panels that wrap LayoutPanel to maintain insertion
   * order.
   * </p>
   * 
   * @param widget the widget to be inserted
   * @param beforeIndex the index before which it will be inserted
   * @throws IndexOutOfBoundsException if <code>beforeIndex</code> is out of
   *           range
   */
  void _insert(Widget widget, int beforeIndex) {
    // Detach new child.
    widget.removeFromParent();

    // Logical attach.
    getChildren().insert(widget, beforeIndex);

    // Physical attach.
    Layer layer = _layout.attachChild(widget.getElement(), userObject:widget);
    widget.setLayoutData(layer);

    // Adopt.
    adopt(widget);

    animate(0);
  }
  
  //*********************************
  // Implementation of RequiresResize
  //*********************************
  
  void onResize() {
    for (Widget child in getChildren()) {
      if (child is RequiresResize) {
        (child as RequiresResize).onResize();
      }
    }
  }
  
  bool remove(Widget w) {
    bool removed = super.remove(w);
    if (removed) {
      _layout.removeChild(w.getLayoutData() as Layer);
    }
    return removed;
  }
  
  /**
   * Sets the child widget's bottom and height values.
   * 
   * @param child
   * @param bottom
   * @param bottomUnit
   * @param height
   * @param heightUnit
   */
  void setWidgetBottomHeight(Widget child, double bottom, Unit bottomUnit, double height, Unit heightUnit) {
    _assertIsChild(child);
    _getLayer(child).setBottomHeight(bottom, bottomUnit, height, heightUnit);
    animate(0);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #setWidgetBottomHeight(Widget,double, Style.Unit, double, Style.Unit)
   */
  void setIsWidgetBottomHeight(IsWidget child, double bottom, Unit bottomUnit, double height, Unit heightUnit) {
    this.setWidgetBottomHeight(child.asWidget(), bottom, bottomUnit, height, heightUnit);
  }
  
  /**
   * Sets the child widget's horizontal position within its layer.
   * 
   * @param child
   * @param position
   */
  void setWidgetHorizontalPosition(Widget child, Alignment position) {
    _assertIsChild(child);
    _getLayer(child).setChildHorizontalPosition(position);
    animate(0);
  }
  
  /**
   * Sets the child widget's left and right values.
   * 
   * @param child
   * @param left
   * @param leftUnit
   * @param right
   * @param rightUnit
   */
  void setWidgetLeftRight(Widget child, double left, Unit leftUnit, double right, Unit rightUnit) {
    _assertIsChild(child);
    _getLayer(child).setLeftRight(left, leftUnit, right, rightUnit);
    animate(0);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #setWidgetLeftRight(Widget,double, Style.Unit, double, Style.Unit)
   */
  void setIsWidgetLeftRight(IsWidget child, double left, Unit leftUnit, double right, Unit rightUnit) {
    this.setWidgetLeftRight(child.asWidget(), left, leftUnit, right, rightUnit);
  }
  
  /**
   * Sets the child widget's left and width values.
   * 
   * @param child
   * @param left
   * @param leftUnit
   * @param width
   * @param widthUnit
   */
  void setWidgetLeftWidth(Widget child, double left, Unit leftUnit, double width, Unit widthUnit) {
    _assertIsChild(child);
    _getLayer(child).setLeftWidth(left, leftUnit, width, widthUnit);
    animate(0);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #setWidgetLeftWidth(Widget,double, Style.Unit, double, Style.Unit)
   */
  void setIsWidgetLeftWidth(IsWidget child, double left, Unit leftUnit, double width, Unit widthUnit) {
    this.setWidgetLeftWidth(child.asWidget(), left, leftUnit, width, widthUnit);
  }
  
  /**
   * Sets the child widget's right and width values.
   * 
   * @param child
   * @param right
   * @param rightUnit
   * @param width
   * @param widthUnit
   */
  void setWidgetRightWidth(Widget child, double right, Unit rightUnit, double width, Unit widthUnit) {
    _assertIsChild(child);
    _getLayer(child).setRightWidth(right, rightUnit, width, widthUnit);
    animate(0);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #setWidgetRightWidth(Widget,double, Style.Unit, double, Style.Unit)
   */
  void setIsWidgetRightWidth(IsWidget child, double right, Unit rightUnit, double width, Unit widthUnit) {
    this.setWidgetRightWidth(child.asWidget(), right, rightUnit, width, widthUnit);
  }
  
  /**
   * Sets the child widget's top and bottom values.
   * 
   * @param child
   * @param top
   * @param topUnit
   * @param bottom
   * @param bottomUnit
   */
  void setWidgetTopBottom(Widget child, double top, Unit topUnit, double bottom, Unit bottomUnit) {
    _assertIsChild(child);
    _getLayer(child).setTopBottom(top, topUnit, bottom, bottomUnit);
    animate(0);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #setWidgetTopBottom(Widget,double, Style.Unit, double, Style.Unit)
   */
  void setIsWidgetTopBottom(IsWidget child, double top, Unit topUnit, double bottom, Unit bottomUnit) {
    this.setWidgetTopBottom(child.asWidget(), top, topUnit, bottom, bottomUnit);
  }
  
  /**
   * Sets the child widget's top and height values.
   * 
   * @param child
   * @param top
   * @param topUnit
   * @param height
   * @param heightUnit
   */
  void setWidgetTopHeight(Widget child, double top, Unit topUnit, double height, Unit heightUnit) {
    _assertIsChild(child);
    _getLayer(child).setTopHeight(top, topUnit, height, heightUnit);
    animate(0);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #setWidgetTopHeight(Widget,double, Style.Unit, double, Style.Unit)
   */
  void setIsWidgetTopHeight(IsWidget child, double top, Unit topUnit, double height, Unit heightUnit) {
    this.setWidgetTopHeight(child.asWidget(), top, topUnit, height, heightUnit);
  }
  
  /**
   * Sets the child widget's vertical position within its layer.
   * 
   * @param child
   * @param position
   */
  void setWidgetVerticalPosition(Widget child, Alignment position) {
    _assertIsChild(child);
    _getLayer(child).setChildVerticalPosition(position);
    animate(0);
  }

  /**
   * Shows or hides the given widget and its layer. This method explicitly
   * calls {@link UIObject#setVisible(boolean)} on the child widget and ensures
   * that its associated layer is shown/hidden.
   * 
   * @param child
   * @param visible
   */
  void setWidgetVisible(Widget child, bool visible) {
    _assertIsChild(child);
    _getLayer(child).setVisible(visible);
    child.visible = visible;
    animate(0);
  }
  
  void onAttach() {
    super.onAttach();
    _layout.onAttach();
  }

  void onDetach() {
    super.onDetach();
    _layout.onDetach();
  }
  
  /**
   * Gets the {@link Layout} instance associated with this widget. This is made
   * package-protected for use by {@link RootLayoutPanel}.
   * 
   * @return this widget's layout instance
   */
  Layout getLayout() {
    return _layout;
  }
  
  void _assertIsChild(Widget widget) {
    assert ((widget == null) || (widget.getParent() == this)); // : "The specified widget is not a child of this panel";
  }

  Layer _getLayer(Widget child) {
    assert (child.getParent() == this); // : "The requested widget is not a child of this panel";
    return child.getLayoutData() as Layer;
  }
}
