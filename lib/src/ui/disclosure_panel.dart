//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that consists of a _header and a content panel that discloses the
 * content when a user clicks on the _header.
 * 
 * <h3>CSS Style Rules</h3> 
 * <dl class="css"> 
 * <dt>.gwt-DisclosurePanel 
 * <dd>the panel's primary style 
 * <dt>.gwt-DisclosurePanel-open 
 * <dd> dependent style set when panel is open 
 * <dt>.gwt-DisclosurePanel-closed 
 * <dd> dependent style set when panel is closed
 * </dl>
 * <p>
 * <img class='gallery' src='doc-files/DisclosurePanel.png'/>
 * </p>
 * 
 * <p>
 * The _header and content sections can be easily selected using css with a child
 * selector:<br/>
 * .gwt-DisclosurePanel-open ._header { ... }
 * </p>
 * <h3>Use in UiBinder Templates</h3>
 * <p>
 * DisclosurePanel elements in  
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates can 
 * have one widget child and one of two types of _header elements. A 
 * &lt;g:_header> element can hold text (not html), or a &lt;g:customHeader> element
 * can hold a widget. (Note that the tags of the _header elements are not
 * capitalized. This is meant to signal that the _header is not a runtime object, 
 * and so cannot have a <code>ui:field</code> attribute.) 
 * <p>
 * For example:<pre>
 * &lt;g:DisclosurePanel>
 *   &lt;g:_header>Text _header&lt;/g:_header>
 *   &lt;g:Label>Widget body&lt;/g:Label>
 * &lt;/g:DisclosurePanel>
 *
 * &lt;g:DisclosurePanel>
 *   &lt;g:customHeader>
 *     &lt;g:Label>Widget _header&lt;/g:Label>
 *   &lt;/g:customHeader>
 *   &lt;g:Label>Widget body&lt;/g:Label>
 * &lt;/g:DisclosurePanel>
 * </pre>
 */

class DisclosurePanel 
  extends Composite
  implements HasWidgetsForIsWidget, HasAnimation, 
    HasOpenHandlers<DisclosurePanel>, HasCloseHandlers<DisclosurePanel> {
  
  static final _DefaultImages DEFAULT_IMAGES = new _DefaultImages();
  
  /**
   * The duration of the animation.
   */
  static final int _ANIMATION_DURATION = 350;

  // Stylename constants.
  static final String _STYLENAME_DEFAULT = "dwt-DisclosurePanel";

  static final String _STYLENAME_SUFFIX_OPEN = "open";

  static final String _STYLENAME_SUFFIX_CLOSED = "closed";

  static final String _STYLENAME_HEADER = "_header";

  static final String _STYLENAME_CONTENT = "content";

  /**
   * The {@link Animation} used to open and close the content.
   */
  static _ContentAnimation _contentAnimation;

  /**
   * top level widget. The first child will be a reference to {@link #_header}.
   * The second child will be a reference to {@link #_contentWrapper}.
   */
  final VerticalPanel _mainPanel = new VerticalPanel();

  /**
   * The wrapper around the content widget.
   */
  final SimplePanel _contentWrapper = new SimplePanel();

  /**
   * holds the _header widget.
   */
  _ClickableHeader _header;

  bool _isAnimationEnabled = false;

  bool _isOpen = false;
  
  /**
   * Creates an empty DisclosurePanel that is initially closed.
   */
  DisclosurePanel() {
    _init();
  }
  
  void _init() {
    _header = new _ClickableHeader(this);
    //
    initWidget(_mainPanel);
    _mainPanel.add(_header);
    _mainPanel.add(_contentWrapper);
    Dom.setStyleAttribute(_contentWrapper.getElement(), "padding", "0px");
    Dom.setStyleAttribute(_contentWrapper.getElement(), "overflow", "hidden");
    clearAndSetStyleName(_STYLENAME_DEFAULT);
    _setContentDisplay(false);
  }
  
  /**
   * Creates a DisclosurePanel with the specified header text, an initial
   * open/close state and a bundle of images to be used in the default header
   * widget.
   * 
   * @param openImage the open state image resource
   * @param closedImage the closed state image resource
   * @param headerText the text to be displayed in the header
   */
  DisclosurePanel.fromImageResources(ImageResource openImage, ImageResource closedImage, String headerText) {
    _init();
    setHeader(new _DefaultHeader.fromImageResources(this, openImage, closedImage, headerText));
  }

  /**
   * Creates a DisclosurePanel that will be initially closed using the specified
   * text in the header.
   * 
   * @param headerText the text to be displayed in the header
   */
  DisclosurePanel.fromText(String headerText) : this.fromImageResources(DEFAULT_IMAGES.disclosurePanelOpen(), DEFAULT_IMAGES.disclosurePanelClosed(), headerText);
  
  void add(Widget w) {
    if (this.getContent() == null) {
      setContent(w);
    } else {
      throw new Exception("A DisclosurePanel can only contain two Widgets.");
    }
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #add(Widget)
   */
  void addIsWidget(IsWidget w) {
    this.add(Widget.asWidgetOrNull(w));
  }

  HandlerRegistration addCloseHandler(CloseHandler<DisclosurePanel> handler) {
    return addHandler(handler, CloseEvent.TYPE);
  }
  
  HandlerRegistration addOpenHandler(OpenHandler<DisclosurePanel> handler) {
    return addHandler(handler, OpenEvent.TYPE);
  }

  void clear() {
    setContent(null);
  }

  /**
   * Gets the widget that was previously set in {@link #setContent(Widget)}.
   * 
   * @return the panel's current content widget
   */
  Widget getContent() {
    return _contentWrapper.getWidget();
  }

  /**
   * Gets the widget that is currently being used as a header.
   * 
   * @return the widget currently being used as a header
   */
  Widget getHeader() {
    return _header.getWidget();
  }

  /**
   * Gets a {@link HasText} instance to provide access to the headers's text, if
   * the header widget does provide such access.
   * 
   * @return a reference to the header widget if it implements {@link HasText},
   *         <code>null</code> otherwise
   */
  HasText getHeaderTextAccessor() {
    Widget widget = _header.getWidget();
    return (widget is HasText) ? widget as HasText : null;
  }

  bool isAnimationEnabled() {
    return _isAnimationEnabled;
  }

  /**
   * Determines whether the panel is open.
   * 
   * @return <code>true</code> if panel is in open state
   */
  bool isOpen() {
    return _isOpen;
  }

  Iterator<Widget> iterator() {
    return WidgetIterators.createWidgetIterator(this, [getContent()]);
  }

  bool remove(Widget w) {
    if (w == getContent()) {
      setContent(null);
      return true;
    }
    return false;
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #remove(Widget)
   */
  bool removeIsWidget(IsWidget w) {
    return this.remove(Widget.asWidgetOrNull(w));
  }

//  /**
//   * Removes an event handler from the panel.
//   * 
//   * @param handler the handler to be removed
//   * @deprecated Use the {@link HandlerRegistration#removeHandler} method on the
//   *             object returned by an add*Handler method instead
//   */
//  @Deprecated
//  void removeEventHandler(DisclosureHandler handler) {
//    ListenerWrapper.WrappedOldDisclosureHandler.remove(this, handler);
//  }

  void setAnimationEnabled(bool enable) {
    _isAnimationEnabled = enable;
  }

  /**
   * Sets the content widget which can be opened and closed by this panel. If
   * there is a preexisting content widget, it will be detached.
   * 
   * @param content the widget to be used as the content panel
   */
  void setContent(Widget content) {
    final Widget currentContent = getContent();

    // Remove existing content widget.
    if (currentContent != null) {
      _contentWrapper.setWidget(null);
      currentContent.removeStyleName(_STYLENAME_CONTENT);
    }

    // Add new content widget if != null.
    if (content != null) {
      _contentWrapper.setWidget(content);
      content.addStyleName(_STYLENAME_CONTENT);
      _setContentDisplay(false);
    }
  }

  /**
   * Sets the widget used as the header for the panel.
   * 
   * @param headerWidget the widget to be used as the header
   */
  void setHeader(Widget headerWidget) {
    _header.setWidget(headerWidget);
  }

  /**
   * Changes the visible state of this <code>DisclosurePanel</code>.
   * 
   * @param isOpen <code>true</code> to open the panel, <code>false</code> to
   *          close
   */
  void setOpen(bool isOpen) {
    if (_isOpen != isOpen) {
      _isOpen = isOpen;
      _setContentDisplay(true);
      _fireEvent();
    }
  }

  void _fireEvent() {
    if (_isOpen) {
      OpenEvent.fire(this, this);
    } else {
      CloseEvent.fire(this, this);
    }
  }

  void _setContentDisplay(bool animate) {
    if (_isOpen) {
      removeStyleDependentName(_STYLENAME_SUFFIX_CLOSED);
      addStyleDependentName(_STYLENAME_SUFFIX_OPEN);
    } else {
      removeStyleDependentName(_STYLENAME_SUFFIX_OPEN);
      addStyleDependentName(_STYLENAME_SUFFIX_CLOSED);
    }

    if (getContent() != null) {
      if (_contentAnimation == null) {
        _contentAnimation = new _ContentAnimation();
      }
      _contentAnimation.setOpen(this, animate && _isAnimationEnabled);
    }
  }
}

/**
 * A ClientBundle that contains the default resources for this widget.
 */
abstract class DisclosureResource extends ClientBundle {
  
  //@ImageOptions(flipRtl = true)
  ImageResource disclosurePanelClosed();
  
  ImageResource disclosurePanelOpen();
}

/**
 * Default disclosure resources.
 */
class _DefaultImages implements DisclosureResource {

  Map<String, ImageResource> _resources = new Map<String, ImageResource>();

  static const String CLOSED_RESOURCE = "disclosurePanelClosed.png";
  static const String CLOSED_RESOURCE_RTL = "disclosurePanelClosed_rtl.png";
  static const String OPEN_RESOURCE = "disclosurePanelOpen.png";

  _DefaultImages();

  Source get source {
    return null;
  }

  /**
   * An image indicating a disclosure panel closed state.
   */
  ImageResource disclosurePanelClosed() {
    if (!_resources.containsKey(CLOSED_RESOURCE)) {
      // We must check is left or right based locales we using here.
      _resources[CLOSED_RESOURCE] = _getImageResourcePrototype(CLOSED_RESOURCE);
    }
    return _resources[CLOSED_RESOURCE];
  }

  /**
   * An image indicating a disclosure panel open state.
   */
  ImageResource disclosurePanelOpen() {
    if (!_resources.containsKey(OPEN_RESOURCE)) {
      _resources[OPEN_RESOURCE] = _getImageResourcePrototype(OPEN_RESOURCE);
    }
    return _resources[OPEN_RESOURCE];
  }
  
  ImageResourcePrototype _getImageResourcePrototype(String name) {
    String uri = DWT.getModuleBaseURL() + "resource/images/" + name;
    ImageResourcePrototype imageResource = new ImageResourcePrototype(name, 
        UriUtils.fromTrustedString(uri), 0, 0, 16, 16, false, false);
    return imageResource;
  }
}

/**
 * Used to wrap widgets in the _header to provide click support. Effectively
 * wraps the widget in an <code>anchor</code> to get automatic keyboard
 * access.
 */
class _ClickableHeader extends SimplePanel {

  DisclosurePanel _panel;
  
  _ClickableHeader(this._panel) : super.fromElement (new dart_html.AnchorElement()) {
    // Anchor is used to allow keyboard access.
//    super(DOM.createAnchor());
    dart_html.Element elem = getElement();
    //DOM.setElementProperty(elem, "href", "javascript:void(0);");
    Dom.setElementProperty(elem, "href", "javascript:void(0);");
    // Avoids layout problems from having blocks in inlines.
    //DOM.setStyleAttribute(elem, "display", "block");
    Dom.setElementProperty(elem, "display", "block");
    sinkEvents(IEvent.ONCLICK);
    //setStyleName(_STYLENAME_HEADER);
    clearAndSetStyleName(DisclosurePanel._STYLENAME_HEADER);
  }

  void onBrowserEvent(dart_html.Event event) {
    // no need to call super.
    //switch (DOM.eventGetType(event)) {
    switch (Dom.eventGetType(event)) {
      case IEvent.ONCLICK:
        // Prevent link default action.
        //DOM.eventPreventDefault(event);
        event.preventDefault();
        _panel.setOpen(!_panel._isOpen);
        break;
    }
  }
}

/**
 * An {@link Animation} used to open the content.
 */
class _ContentAnimation extends Animation {
  /**
   * Whether the item is being opened or closed.
   */
  bool _opening;

  /**
   * The {@link DisclosurePanel} being affected.
   */
  DisclosurePanel _curPanel;

  _ContentAnimation();
  
  /**
   * Open or close the content.
   * 
   * @param panel the panel to open or close
   * @param animate true to animate, false to open instantly
   */
  void setOpen(DisclosurePanel panel, bool animate) {
    // Immediately complete previous open
    cancel();

    // Open the new item
    if (animate) {
      _curPanel = panel;
      _opening = panel._isOpen;
      run(DisclosurePanel._ANIMATION_DURATION);
    } else {
      panel._contentWrapper.visible = panel._isOpen;
      if (panel._isOpen) {
        // Special treatment on the visible case to ensure LazyPanel works
        panel.getContent().visible = true;
      }
    }
  }

  void onComplete() {
    if (!_opening) {
      _curPanel._contentWrapper.visible = false;
    }
    Dom.setStyleAttribute(_curPanel._contentWrapper.getElement(), "height", "auto");
    _curPanel = null;
  }

  void onStart() {
    super.onStart();
    if (_opening) {
      _curPanel._contentWrapper.visible = true;
      // Special treatment on the visible case to ensure LazyPanel works
      _curPanel.getContent().visible = true;
    }
  }

  void onUpdate(double progress) {
    int scrollHeight = Dom.getElementPropertyInt(_curPanel._contentWrapper.getElement(), "scrollHeight");
    int height = (progress * scrollHeight).toInt();
    if (!_opening) {
      height = scrollHeight - height;
    }
    height = dart_math.max(height, 1);
    Dom.setStyleAttribute(_curPanel._contentWrapper.getElement(), "height", "${height}px");
    Dom.setStyleAttribute(_curPanel._contentWrapper.getElement(), "width", "auto");
  }
}

abstract class _Imager {
  Image makeImage();

  void updateImage(bool open, Image image);
}

class _ImageResourceImager implements _Imager {
  final ImageResource openImage;
  final ImageResource closedImage;
  
  _ImageResourceImager(this.openImage, this.closedImage);

  Image makeImage() {
    return new Image.fromImageResource(closedImage);
  }

  void updateImage(bool open, Image image) {
    if (open) {
      image.setResource(openImage);
    } else {
      image.setResource(closedImage);
    }
  }
}

/**
 * The default _header widget used within a {@link DisclosurePanel}.
 */
class _DefaultHeader extends Widget implements HasText, OpenHandler<DisclosurePanel>, CloseHandler<DisclosurePanel> {

  DisclosurePanel _panel;
  
  /**
   * imageTD holds the image for the icon, not null. labelTD holds the text
   * for the label.
   */
  dart_html.TableCellElement _labelTD;

  Image _iconImage;
  _Imager _imager;

  _DefaultHeader(this._panel, _Imager imager, String text) {
    _init(imager, text);
  }
  
  _DefaultHeader.fromImageResources(DisclosurePanel panel, ImageResource openImage, ImageResource closedImage, String text) : this(panel, new _ImageResourceImager(openImage, closedImage), text);
  
  void _init(_Imager imager, String text) {
    _imager = imager;
    _iconImage = _imager.makeImage();

    // I do not need any Widgets here, just a DOM structure.
    dart_html.TableElement root = new dart_html.TableElement(); //DOM.createTable();
    dart_html.Element tbody = root.createTBody();
    dart_html.TableRowElement tr = new dart_html.TableRowElement(); // DOM.createTR();
    dart_html.TableCellElement imageTD = new dart_html.TableCellElement(); // DOM.createTD();
    _labelTD = new dart_html.TableCellElement(); // DOM.createTD();

    setElement(root);

    //DOM.appendChild(root, tbody);
    root.append(tbody);
    //DOM.appendChild(tbody, tr);
    tbody.append(tr);
    //DOM.appendChild(tr, imageTD);
    tr.append(imageTD);
    //DOM.appendChild(tr, _labelTD);
    tr.append(_labelTD);

    // set image TD to be same width as image.
    Dom.setElementProperty(imageTD, "align", "center");
    Dom.setElementProperty(imageTD, "valign", "middle");
    Dom.setStyleAttribute(imageTD, "width", _iconImage.getWidth().toString() + "px");

    //DOM.appendChild(imageTD, _iconImage.getElement());
    imageTD.append(_iconImage.getElement());

    this.text = text;

    _panel.addOpenHandler(this);
    _panel.addCloseHandler(this);
    _setStyle();
  }

  String get text => _labelTD.text; //DOM.getInnerText(_labelTD);

  void onClose(CloseEvent<DisclosurePanel> event) {
    _setStyle();
  }

  void onOpen(OpenEvent<DisclosurePanel> event) {
    _setStyle();
  }

  //void setText(String text) {
  void set text(String value) {
    //DOM.setInnerText(_labelTD, text);
    _labelTD.text = value;
  }

  void _setStyle() {
    _imager.updateImage(_panel._isOpen, _iconImage);
  }
}