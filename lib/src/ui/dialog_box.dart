//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A form of popup that has a caption area at the top and can be dragged by the
 * user. Unlike a PopupPanel, calls to {@link #setWidth(String)} and
 * {@link #setHeight(String)} will set the width and height of the dialog box
 * itself, even if a widget has not been added as yet.
 * <p>
 * <img class='gallery' src='doc-files/DialogBox.png'/>
 * </p>
 * <h3>CSS Style Rules</h3>
 *
 * <ul>
 * <li>.dwt-DialogBox { the outside of the dialog }</li>
 * <li>.dwt-DialogBox .Caption { the caption }</li>
 * <li>.dwt-DialogBox .dialogContent { the wrapper around the content }</li>
 * <li>.dwt-DialogBox .dialogTopLeft { the top left cell }</li>
 * <li>.dwt-DialogBox .dialogTopLeftInner { the inner element of the cell }</li>
 * <li>.dwt-DialogBox .dialogTopCenter { the top center cell, where the caption
 * is located }</li>
 * <li>.dwt-DialogBox .dialogTopCenterInner { the inner element of the cell }</li>
 * <li>.dwt-DialogBox .dialogTopRight { the top right cell }</li>
 * <li>.dwt-DialogBox .dialogTopRightInner { the inner element of the cell }</li>
 * <li>.dwt-DialogBox .dialogMiddleLeft { the middle left cell }</li>
 * <li>.dwt-DialogBox .dialogMiddleLeftInner { the inner element of the cell }</li>
 * <li>.dwt-DialogBox .dialogMiddleCenter { the middle center cell, where the
 * content is located }</li>
 * <li>.dwt-DialogBox .dialogMiddleCenterInner { the inner element of the cell }
 * </li>
 * <li>.dwt-DialogBox .dialogMiddleRight { the middle right cell }</li>
 * <li>.dwt-DialogBox .dialogMiddleRightInner { the inner element of the cell }</li>
 * <li>.dwt-DialogBox .dialogBottomLeft { the bottom left cell }</li>
 * <li>.dwt-DialogBox .dialogBottomLeftInner { the inner element of the cell }</li>
 * <li>.dwt-DialogBox .dialogBottomCenter { the bottom center cell }</li>
 * <li>.dwt-DialogBox .dialogBottomCenterInner { the inner element of the cell }
 * </li>
 * <li>.dwt-DialogBox .dialogBottomRight { the bottom right cell }</li>
 * <li>.dwt-DialogBox .dialogBottomRightInner { the inner element of the cell }</li>
 * </ul>
 * <p>
 * <h3>Example</h3>
 * {@example com.google.dwt.examples.DialogBoxExample}
 * </p>
 *
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * DialogBox elements in {@link com.google.dwt.uibinder.client.UiBinder
 * UiBinder} templates can have one widget child and one &lt;g:caption> child.
 * (Note the lower case "c", meant to signal that the caption is not a runtime
 * object, and so cannot have a <code>ui:field</code> attribute.) The body of
 * the caption can be html.
 *
 * <p>
 *
 * For example:
 *
 * <pre>
 * &lt;g:DialogBox autoHide="true" modal="true">
 *   &lt;g:caption>&lt;b>Caption text&lt;/b>&lt;/g:caption>
 *   &lt;g:HtmlPanel>
 *     Body text
 *     &lt;g:Button ui:field='cancelButton'>Cancel&lt;/g:Button>
 *     &lt;g:Button ui:field='okButton'>Okay&lt;/g:Button>
 *   &lt;/g:HtmlPanel>
 * &lt;/g:DialogBox>
 * </pre>
 *
 * You may also create your own header caption. The caption must implement
 * {@link Caption}.
 *
 * <p>
 *
 * For example:
 *
 * <p>
 *
 * <pre>
 * &lt;g:DialogBox autoHide="true" modal="true">
 *   &lt;-- foo is your prefix and Bar is a class that implements {@link Caption}-->
 *   &lt;g:customCaption>&lt;foo:Bar/>&lt;/g:customCaption>
 *   &lt;g:HtmlPanel>
 *     Body text
 *     &lt;g:Button ui:field='cancelButton'>Cancel&lt;/g:Button>
 *     &lt;g:Button ui:field='okButton'>Okay&lt;/g:Button>
 *   &lt;/g:HtmlPanel>
 * &lt;/g:DialogBox>
 * </pre>
 *
 */
class DialogBox extends DecoratedPopupPanel implements HasHtml, HasSafeHtml/*, MouseListener*/ {

  /**
   * The default style name.
   */
  static final String DEFAULT_STYLENAME = "dwt-DialogBox";

  Caption caption;
  bool dragging = false;
  int dragStartX, dragStartY;
  int windowWidth;
  int clientLeft;
  int clientTop;

  HandlerRegistration resizeHandlerRegistration;

//  /**
//   * Creates an empty dialog box. It should not be shown until its child widget
//   * has been added using {@link #add(Widget)}.
//   */
//  DialogBox() {
//    this(false);
//  }
//
//  /**
//   * Creates an empty dialog box specifying its "auto-hide" property. It should
//   * not be shown until its child widget has been added using
//   * {@link #add(Widget)}.
//   *
//   * @param autoHide <code>true</code> if the dialog should be automatically
//   *          hidden when the user clicks outside of it
//   */
//  DialogBox(bool autoHide) {
//    this(autoHide, true);
//  }
//
//  /**
//   * Creates an empty dialog box specifying its {@link Caption}. It should not
//   * be shown until its child widget has been added using {@link #add(Widget)}.
//   *
//   * @param captionWidget the widget that is the DialogBox's header.
//   */
//  DialogBox(Caption captionWidget) {
//    this(false, true, captionWidget);
//  }
//
//  /**
//   * Creates an empty dialog box specifying its "auto-hide" and "modal"
//   * properties. It should not be shown until its child widget has been added
//   * using {@link #add(Widget)}.
//   *
//   * @param autoHide <code>true</code> if the dialog should be automatically
//   *          hidden when the user clicks outside of it
//   * @param modal <code>true</code> if keyboard and mouse events for widgets not
//   *          contained by the dialog should be ignored
//   */
//  DialogBox(bool autoHide, bool modal) {
//    this(autoHide, modal, new CaptionImpl());
//  }

  /**
   *
   * Creates an empty dialog box specifying its "auto-hide", "modal" properties
   * and an implementation a custom {@link Caption}. It should not be shown
   * until its child widget has been added using {@link #add(Widget)}.
   *
   * @param autoHide <code>true</code> if the dialog should be automatically
   *          hidden when the user clicks outside of it
   * @param modal <code>true</code> if keyboard and mouse events for widgets not
   *          contained by the dialog should be ignored
   * @param captionWidget the widget that is the DialogBox's header.
   */
  DialogBox([bool autoHide = false, bool modal = true, Caption captionWidget = null]) : super(autoHide, modal, "dialog") {

    if (captionWidget == null) {
      captionWidget = new DialogBoxCaptionImpl();
    }
    captionWidget.asWidget().removeFromParent();
    caption = captionWidget;

    // Add the caption to the top row of the decorator panel. We need to
    // logically adopt the caption so we can catch mouse events.
    dart_html.Element td = getCellElement(0, 1);
    td.append(caption.asWidget().getElement());
    adopt(caption.asWidget());

    // Set the style name
    clearAndSetStyleName(DEFAULT_STYLENAME);

    windowWidth = Dom.getClientWidth();
    clientLeft = dart_html.document.body.offset.left ;// Document.get().getBodyOffsetLeft();
    clientTop = dart_html.document.body.offset.top; //Document.get().getBodyOffsetTop();

//    AllMouseHandlersAdapter mouseHandler = new AllMouseHandlersAdapter((DwtEvent event){
//      if (event is MouseDownEvent) {
//        beginDragging(event);
//      } else if (event is MouseMoveEvent) {
//        continueDragging(event);
//      } else if (event is MouseOutEvent) {
//        DialogBox.this.onMouseLeave(caption.asWidget());
//      } else if (event is MouseOverEvent) {
//        DialogBox.this.onMouseEnter(caption.asWidget());
//      } else if (event is MouseUpEvent) {
//        endDragging(event);
//      }
//    });
//    addDomHandler(mouseHandler, MouseDownEvent.TYPE);
//    addDomHandler(mouseHandler, MouseUpEvent.TYPE);
//    addDomHandler(mouseHandler, MouseMoveEvent.TYPE);
//    addDomHandler(mouseHandler, MouseOverEvent.TYPE);
//    addDomHandler(mouseHandler, MouseOutEvent.TYPE);
    addDomHandler(new MouseDownHandlerAdapter((MouseDownEvent event){
      beginDragging(event);
    }), MouseDownEvent.TYPE);
    addDomHandler(new MouseUpHandlerAdapter((MouseUpEvent event){
      endDragging(event);
    }), MouseUpEvent.TYPE);
    addDomHandler(new MouseMoveHandlerAdapter((MouseMoveEvent event){
      continueDragging(event);
    }), MouseMoveEvent.TYPE);
    addDomHandler(new MouseOverHandlerAdapter((MouseOverEvent event){
      //onMouseEnter(caption.asWidget());
    }), MouseOverEvent.TYPE);
    addDomHandler(new MouseOutHandlerAdapter((MouseOutEvent event){
      //onMouseLeave(caption.asWidget());
    }), MouseOutEvent.TYPE);
  }

  /**
   * Provides access to the dialog's caption.
   *
   * @return the logical caption for this dialog box
   */
  Caption getCaption() {
    return caption;
  }

  String get html => caption.html;

  String get text => caption.text;


  void hide([bool autoClosed = false]) {
    if (resizeHandlerRegistration != null) {
      resizeHandlerRegistration.removeHandler();
      resizeHandlerRegistration = null;
    }
    super.hide(autoClosed);
  }


  void onBrowserEvent(dart_html.Event event) {
    // If we're not yet dragging, only trigger mouse events if the event occurs
    // in the caption wrapper
    switch (Event.getTypeInt(event.type)) {
      case Event.ONMOUSEDOWN:
      case Event.ONMOUSEUP:
      case Event.ONMOUSEMOVE:
      case Event.ONMOUSEOVER:
      case Event.ONMOUSEOUT:
        if (!dragging && !isCaptionEvent(event)) {
          return;
        }
        break;
    }

    super.onBrowserEvent(event);
  }

  /**
   * Sets the html string inside the caption by calling its
   * {@link #setHtml(SafeHtml)} method.
   *
   * Use {@link #setWidget(Widget)} to set the contents inside the
   * {@link DialogBox}.
   *
   * @param html the object's new Html
   */
  void setHtml(SafeHtml html) {
    caption.html = html.toString();
  }

  /**
   * Sets the html string inside the caption by calling its
   * {@link #setHtml(SafeHtml)} method. Only known safe Html should be inserted
   * in here.
   *
   * Use {@link #setWidget(Widget)} to set the contents inside the
   * {@link DialogBox}.
   *
   * @param html the object's new Html
   */
  void set html(String val) {
    caption.html = SafeHtmlUtils.fromTrustedString(val).asString();
  }

  /**
   * Sets the text inside the caption by calling its {@link #setText(String)}
   * method.
   *
   * Use {@link #setWidget(Widget)} to set the contents inside the
   * {@link DialogBox}.
   *
   * @param text the object's new text
   */
  void set text(String val) {
    caption.text = val;
  }


  void show() {
    if (resizeHandlerRegistration == null) {
//      resizeHandlerRegistration = Window.addResizeHandler(new ResizeHandler() {
//        void onResize(ResizeEvent event) {
//          windowWidth = event.getWidth();
//        }
//      });
    }
    super.show();
  }

  /**
   * Called on mouse down in the caption area, begins the dragging loop by
   * turning on event capture.
   *
   * @see Dom#setCapture
   * @see #continueDragging
   * @param event the mouse down event that triggered dragging
   */
  void beginDragging(MouseDownEvent event) {
    if (Dom.getCaptureElement() == null) {
      /*
       * Need to check to make sure that we aren't already capturing an element
       * otherwise events will not fire as expected. If this check isn't here,
       * any class which extends custom button will not fire its click event for
       * example.
       */
      dragging = true;
      Dom.setCapture(getElement());
      dragStartX = event.getX();
      dragStartY = event.getY();
    }
  }

  /**
   * Called on mouse move in the caption area, continues dragging if it was
   * started by {@link #beginDragging}.
   *
   * @see #beginDragging
   * @see #endDragging
   * @param event the mouse move event that continues dragging
   */
  void continueDragging(MouseMoveEvent event) {
    if (dragging) {
      int absX = event.getX() + getAbsoluteLeft();
      int absY = event.getY() + getAbsoluteTop();

      // if the mouse is off the screen to the left, right, or top, don't
      // move the dialog box. This would let users lose dialog boxes, which
      // would be bad for modal popups.
      if (absX < clientLeft || absX >= windowWidth || absY < clientTop) {
        return;
      }

      setPopupPosition(absX - dragStartX, absY - dragStartY);
    }
  }


  void doAttachChildren() {
    try {
      super.doAttachChildren();
    } finally {
      // See comment in doDetachChildren for an explanation of this call
      caption.asWidget().onAttach();
    }
  }


  void doDetachChildren() {
    try {
      super.doDetachChildren();
    } finally {
      /*
       * We need to detach the caption specifically because it is not part of
       * the iterator of Widgets that the {@link SimplePanel} super class
       * returns. This is similar to a {@link ComplexPanel}, but we do not want
       * to expose the caption widget, as its just an internal implementation.
       */
      caption.asWidget().onDetach();
    }
  }

  /**
   * Called on mouse up in the caption area, ends dragging by ending event
   * capture.
   *
   * @param event the mouse up event that ended dragging
   *
   * @see Dom#releaseCapture
   * @see #beginDragging
   * @see #endDragging
   */
  void endDragging(MouseUpEvent event) {
    dragging = false;
    Dom.releaseCapture(getElement());
  }

  /**
   * <b>Affected Elements:</b>
   * <ul>
   * <li>-caption = text at the top of the {@link DialogBox}.</li>
   * <li>-content = the container around the content.</li>
   * </ul>
   *
   * @see UIObject#onEnsureDebugId(String)
   */

  void onPreviewNativeEvent(NativePreviewEvent event) {
    // We need to preventDefault() on mouseDown events (outside of the
    // DialogBox content) to keep text from being selected when it
    // is dragged.
    dart_html.Event nativeEvent = event.getNativeEvent();

    if (!event.isCanceled() && (Event.getTypeInt(nativeEvent.type) == Event.ONMOUSEDOWN)
        && isCaptionEvent(nativeEvent)) {
      nativeEvent.preventDefault();
    }

    super.onPreviewNativeEvent(event);
  }

  bool isCaptionEvent(dart_html.Event event) {
    dart_html.EventTarget target = event.target;
    if (target is dart_html.Element) {
      return Dom.isOrHasChild(getCellElement(0, 1).parent, target as dart_html.Element);
    }
    return false;
  }
}

/**
 * Set of characteristic interfaces supported by the {@link DialogBox}
 * caption.
*
 */
abstract class Caption implements HasAllMouseHandlers, HasHtml, HasSafeHtml, IsWidget {
}

/**
 * Default implementation of Caption. This will be created as the header if
 * there isn't a header specified.
 */
class DialogBoxCaptionImpl extends Html implements Caption {

  DialogBoxCaptionImpl() : super() {
    clearAndSetStyleName("Caption");
  }
}