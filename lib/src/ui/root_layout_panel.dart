//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A singleton implementation of {@link LayoutPanel} that always attaches itself
 * to the document body (i.e. {@link RootPanel#get()}).
 *
 * <p>
 * This panel automatically calls {@link RequiresResize#onResize()} on itself
 * when initially created, and whenever the window is resized.
 * </p>
 *
 * <p>
 * NOTE: This widget will <em>only</em> work in standards mode, which requires
 * that the HTML page in which it is run have an explicit &lt;!DOCTYPE&gt;
 * declaration.
 * </p>
 *
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.LayoutPanelExample}
 * </p>
 */
class RootLayoutPanel extends LayoutPanel {

  static RootLayoutPanel _singleton;

  /**
   * Gets the singleton instance of RootLayoutPanel. This instance will always
   * be attached to the document body via {@link RootPanel#get()}.
   *
   * <p>
   * Note that, unlike {@link RootPanel#get(String)}, this class provides no way
   * to get an instance for any element on the page other than the document
   * body. This is because we know of no way to get resize events for anything
   * but the window.
   * </p>
   */
  static RootLayoutPanel get() {
    if (_singleton == null) {
      _singleton = new RootLayoutPanel._initial();
      RootPanel.get().add(_singleton);
    }
    return _singleton;
  }

  RootLayoutPanel._initial() {
    dart_html.window.onResize.listen((dart_html.Event event){
      onResize();
    });

    // TODO(jgw): We need notification of font-size changes as well.
    // I believe there's a hidden iframe trick that we can use to get
    // a font-size-change event (really an em-definition-change event).
  }

  void onLoad() {
    getLayout().onAttach();
    getLayout().fillParent();
  }
}
