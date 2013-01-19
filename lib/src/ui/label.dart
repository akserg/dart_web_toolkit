//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that contains arbitrary text, <i>not</i> interpreted as HTML.
 *
 * This widget uses a &lt;div&gt; element, causing it to be displayed with block
 * layout.
 *
 * <p>
 * <h3>Built-in Bidi Text Support</h3>
 * This widget is capable of automatically adjusting its direction according to
 * its content. This feature is controlled by {@link #setDirectionEstimator} or
 * passing a DirectionEstimator parameter to the constructor, and is off by
 * default.
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-Label { }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.HTMLExample}
 * </p>
 */
class Label extends LabelBase<String> implements HasDirectionalText,
  HasClickHandlers, HasDoubleClickHandlers,
  HasAllDragAndDropHandlers, //HasAllGestureHandlers, HasDirection
  HasAllMouseHandlers, HasAllTouchHandlers,
  IsEditor<LeafValueEditor<String>> {

  static final DirectionEstimator DEFAULT_DIRECTION_ESTIMATOR = DirectionalTextHelper.DEFAULT_DIRECTION_ESTIMATOR;

  /**
   * Creates a Label widget that wraps an existing &lt;div&gt; or &lt;span&gt;
   * element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory Label.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert (Document.get().getBody().isOrHasChild(element));

    Label label = new Label.fromElement(element);

    // Mark it attached and remember it for cleanup.
    label.onAttach();
    RootPanel.detachOnWindowClose(label);

    return label;
  }

  LeafValueEditor<String> editor;

  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be either a &lt;div&gt; or &lt;span&gt; element.
   *
   * @param element the element to be used
   */
  Label.fromElement(dart_html.Element element) : super.fromElement(element) {
    clearAndSetStyleName("dwt-Label");
  }

  /**
   * Creates an empty label.
   */
  Label([String text = null, bool wordWrap = null]) : super(false) {
    clearAndSetStyleName("dwt-Label");
    if (text != null) {
      this.text = text;
    }
    if (wordWrap != null) {
      this.wordWrap = wordWrap;
    }
  }

  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addDomHandler(handler, ClickEvent.TYPE);
  }

  HandlerRegistration addDoubleClickHandler(DoubleClickHandler handler) {
    return addDomHandler(handler, DoubleClickEvent.TYPE);
  }

  HandlerRegistration addDragEndHandler(DragEndHandler handler) {
    return addDomHandler(handler, DragEndEvent.TYPE);
  }

  HandlerRegistration addDragEnterHandler(DragEnterHandler handler) {
    return addDomHandler(handler, DragEnterEvent.TYPE);
  }

  HandlerRegistration addDragHandler(DragHandler handler) {
    return addDomHandler(handler, DragEvent.TYPE);
  }

  HandlerRegistration addDragLeaveHandler(DragLeaveHandler handler) {
    return addDomHandler(handler, DragLeaveEvent.TYPE);
  }

  HandlerRegistration addDragOverHandler(DragOverHandler handler) {
    return addDomHandler(handler, DragOverEvent.TYPE);
  }

  HandlerRegistration addDragStartHandler(DragStartHandler handler) {
    return addDomHandler(handler, DragStartEvent.TYPE);
  }

  HandlerRegistration addDropHandler(DropHandler handler) {
    return addDomHandler(handler, DropEvent.TYPE);
  }

//  HandlerRegistration addGestureChangeHandler(GestureChangeHandler handler) {
//    return addDomHandler(handler, GestureChangeEvent.TYPE);
//  }
//
//  HandlerRegistration addGestureEndHandler(GestureEndHandler handler) {
//    return addDomHandler(handler, GestureEndEvent.TYPE);
//  }
//
//  HandlerRegistration addGestureStartHandler(GestureStartHandler handler) {
//    return addDomHandler(handler, GestureStartEvent.TYPE);
//  }

  HandlerRegistration addMouseDownHandler(MouseDownHandler handler) {
    return addDomHandler(handler, MouseDownEvent.TYPE);
  }

  HandlerRegistration addMouseMoveHandler(MouseMoveHandler handler) {
    return addDomHandler(handler, MouseMoveEvent.TYPE);
  }

  HandlerRegistration addMouseOutHandler(MouseOutHandler handler) {
    return addDomHandler(handler, MouseOutEvent.TYPE);
  }

  HandlerRegistration addMouseOverHandler(MouseOverHandler handler) {
    return addDomHandler(handler, MouseOverEvent.TYPE);
  }

  HandlerRegistration addMouseUpHandler(MouseUpHandler handler) {
    return addDomHandler(handler, MouseUpEvent.TYPE);
  }

  HandlerRegistration addMouseWheelHandler(MouseWheelHandler handler) {
    return addDomHandler(handler, MouseWheelEvent.TYPE);
  }

  HandlerRegistration addTouchCancelHandler(TouchCancelHandler handler) {
    return addDomHandler(handler, TouchCancelEvent.TYPE);
  }

  HandlerRegistration addTouchEndHandler(TouchEndHandler handler) {
    return addDomHandler(handler, TouchEndEvent.TYPE);
  }

  HandlerRegistration addTouchMoveHandler(TouchMoveHandler handler) {
    return addDomHandler(handler, TouchMoveEvent.TYPE);
  }

  HandlerRegistration addTouchStartHandler(TouchStartHandler handler) {
    return addDomHandler(handler, TouchStartEvent.TYPE);
  }

  LeafValueEditor<String> asEditor() {
    if (editor == null) {
      editor = new HasTextEditor.of(this);
    }
    return editor;
  }

  String get text => directionalTextHelper.getTextOrHtml(false);

  /**
   * Sets the label's content to the given text.
   * <p>
   * Doesn't change the widget's direction or horizontal alignment if {@code
   * directionEstimator} is null. Otherwise, the widget's direction is set using
   * the estimator, and its alignment may therefore change as described in
   * {@link #setText(String, com.google.gwt.i18n.client.HasDirection.Direction) setText(String, Direction)}.
   *
   * @param text the widget's new text
   */
  void set text(String val) {
    directionalTextHelper.setTextOrHtml(val, false);
    updateHorizontalAlignment();
  }

  Direction getTextDirection() {
    return directionalTextHelper.getTextDirection();
  }

  /**
   * Sets the label's content to the given text, applying the given direction.
   * <p>
   * This will have the following effect on the horizontal alignment:
   * <ul>
   * <li> If the automatic alignment setting is ALIGN_CONTENT_START or
   * ALIGN_CONTENT_END, the horizontal alignment will be set to match the start
   * or end edge, respectively, of the new direction (the {@code dir}
   * parameter). If that is DEFAULT, the locale direction is used.
   * <li> Otherwise, the horizontal alignment value is not changed, but the
   * effective alignment may nevertheless change according to the usual HTML
   * rules, i.e. it will match the start edge of the new direction if the widget
   * element is a &lt;div&gt; and has no explicit alignment value even by
   * inheritance.
   * </ul>
   *
   * @param text the widget's new text
   * @param dir the text's direction. Note: {@code Direction.DEFAULT} means
   *        direction should be inherited from the widget's parent element.
   */
  void setText(String text, [Direction dir]) {
    if (?dir) {
//      directionalTextHelper.setTextOrHtml(text, dir, false);
    } else {
      directionalTextHelper.setTextOrHtml(text, false);
    }
    updateHorizontalAlignment();
  }
}
