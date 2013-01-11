//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that wraps the HTML &lt;input type='file'&gt; element. This widget
 * must be used with {@link com.google.gwt.user.client.ui.FormPanel} if it is to
 * be submitted to a server.
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.FormPanelExample}
 * </p>
 */
class FileUpload extends Widget implements HasName, HasChangeHandlers, HasEnabled {

  /**
   * Creates a FileUpload widget that wraps an existing &lt;input
   * type='file'&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory FileUpload.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    //assert (Document.get().getBody().isOrHasChild(element);

    FileUpload fileUpload = new FileUpload(element);

    // Mark it attached and remember it for cleanup.
    fileUpload.onAttach();
    RootPanel.detachOnWindowClose(fileUpload);

    return fileUpload;
  }

  FileUploadImpl _impl;

  /**
   * Constructs a new file upload widget.
   */
  FileUpload([dart_html.InputElement element]) {
    if (?element) {
      setElement(element);
    } else {
      element = new dart_html.InputElement();
      element.type = "file";
      setElement(element);
      clearAndSetStyleName("dwt-FileUpload");
      _impl = new FileUploadImpl.browserDependent(); //GWT.create(FileUploadImpl.class);
      _impl.init(this);
    }
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

  //************************************
  // Implementation of HasName
  //************************************

  String get name => _getInputElement().name;

  void set name(String value) {
    _getInputElement().name = value;
  }

  //*****************************
  // Implementation of HasEnabled
  //*****************************

  /**
   * Gets whether this widget is enabled.
   *
   * @return <code>true</code> if the widget is enabled
   */
  bool get enabled => !_getInputElement().disabled;

  /**
   * Sets whether this widget is enabled.
   *
   * @param enabled <code>true</code> to enable the widget, <code>false</code>
   *          to disable it
   */
  void set enabled(bool value) {
    _getInputElement().disabled = !value;
  }

  //****

  /**
   * Gets the filename selected by the user. This property has no mutator, as
   * browser security restrictions preclude setting it.
   *
   * @return the widget's filename
   */
  String getFilename() {
    return _getInputElement().value;
  }

  void onBrowserEvent(dart_html.Event event) {
    if (_impl.onBrowserEvent(event)) {
      super.onBrowserEvent(event);
    }
  }

  dart_html.InputElement _getInputElement() {
    return getElement();
  }
}

/**
 * Implementation class for {@link FileUpload}.
 */
class FileUploadImpl {

  /**
   * Create instance of [DomHelper] depends on broswer.
   */
  factory FileUploadImpl.browserDependent() {
    return new FileUploadImpl._internal();
  }

  FileUploadImpl._internal();

  /**
   * Initialize the impl class.
   *
   * @param fileUpload the {@link FileUpload} to handle
   */
  void init(FileUpload fileUpload) {}

  /**
   * Handle the browser event.
   *
   * @param event the native event
   * @return true to fire the event normally, false to ignore it
   */
  bool onBrowserEvent(dart_html.Event event) {
    return true;
  }
}