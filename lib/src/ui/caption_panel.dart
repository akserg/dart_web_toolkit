//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A panel that wraps its contents in a border with a caption that appears in
 * the upper left corner of the border. This is an implementation of the
 * fieldset HTML element.
 */
class CaptionPanel extends Composite implements HasWidgetsForIsWidget {
  
  /**
   * The implementation instance.
   */
  static CaptionPanelImpl impl = new CaptionPanelImpl.browserDependant();
  
  /**
   * The legend element used as the caption.
   */
  dart_html.LegendElement legend;

  /**
   * Constructs a CaptionPanel with specified caption text.
   *
   * @param caption the text of the caption
   */
  CaptionPanel.fromSafeHtml(SafeHtml caption) : this(caption.asString(), true);

  /**
   * Constructs a CaptionPanel having the specified caption.
   *
   * @param caption the caption to display
   * @param asHTML if <code>true</code>, the <code>caption</code> param is
   *            interpreted as HTML; otherwise, <code>caption</code> is
   *            treated as text and automatically escaped
   */
  CaptionPanel([String caption = "", bool asHtml = false]) {
    dart_html.FieldSetElement fieldSet = new dart_html.FieldSetElement();
    initWidget(new SimplePanel.fromElement(fieldSet));
    legend = new dart_html.LegendElement();
    fieldSet.append(legend);
    if (asHtml) {
      setCaptionHtml(caption);
    } else {
      setCaptionText(caption);
    }
  }
  
  void add(Widget w) {
    (getWidget() as SimplePanel).add(w);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #add(Widget)
   */
  void addIsWidget(IsWidget w) {
    this.add(asWidgetOrNull(w));
  }
  
  /**
   * Removes the content widget.
   */
  void clear() {
    (getWidget() as SimplePanel).clear();
  }

  /**
   * Returns the caption as HTML; note that if the caption was previously set
   * using {@link #setCaptionText(String)}, the return value is undefined.
   */
  String getCaptionHtml() {
    String html = legend.innerHtml;
    assert (html != null);
    return html;
  }
  
  /**
   * Sets the caption for the panel using an HTML fragment. Pass in empty string
   * to remove the caption completely, leaving just the unadorned panel.
   *
   * @param html HTML for the new caption; must not be <code>null</code>
   */
  void setCaptionHtml(String html) {
    assert (html != null);
    impl.setCaption(getElement() as dart_html.FieldSetElement, legend, html, true);
  }

  /**
   * Sets the caption for the panel using a SafeHtml string.
   *
   * @param html HTML for the new caption; must not be <code>null</code>
   */
  void setCaptionSafeHtml(SafeHtml html) {
    setCaptionHtml(html.asString());
  }

  /**
   * Returns the caption as text; note that if the caption was previously set
   * using {@link #setCaptionHTML(String)}, the return value is undefined.
   */
  String getCaptionText() {
    String text = legend.text;
    assert (text != null);
    return text;
  }
  
  /**
   * Sets the caption for the panel using text that will be automatically
   * escaped. Pass in empty string to remove the caption completely, leaving
   * just the unadorned panel.
   *
   * @param text text for the new caption; must not be <code>null</code>
   */
  void setCaptionText(String text) {
    assert (text != null);
    impl.setCaption(getElement() as dart_html.FieldSetElement, legend, text, false);
  }
  
  /**
   * Accesses the content widget, if present.
   *
   * @return the content widget specified previously in
   *         {@link #setContentWidget(Widget)}
   */
  Widget getContentWidget() {
    return (getWidget() as SimplePanel).getWidget();
  }
  
  /**
   * Sets or replaces the content widget within the CaptionPanel.
   *
   * @param w the content widget to be set
   */
  void setContentWidget(Widget w) {
    (getWidget() as SimplePanel).setWidget(w);
  }

  /**
   * Iterates over the singular content widget, if present.
   */
  Iterator<Widget> iterator() {
    return (getWidget() as SimplePanel).iterator();
  }

  /**
   * Removes the specified widget, although in practice the specified widget
   * must be the content widget.
   *
   * @param w the widget to remove; note that anything other than the Widget
   *            returned by {@link #getContentWidget()} will have no effect
   */
  bool remove(Widget w) {
    return (getWidget() as SimplePanel).remove(w);
  }
  
  /**
   * Overloaded version for IsWidget.
   * 
   * @see #remove(Widget)
   */
  bool removeIsWidget(IsWidget w) {
    return this.remove(asWidgetOrNull(w));
  }
}

/**
 * Implementation class without browser-specific hacks.
 */
class CaptionPanelImpl {
  
  factory CaptionPanelImpl.browserDependant() {
    return new CaptionPanelImpl();
  }
  
  CaptionPanelImpl();
  
  void setCaption(dart_html.FieldSetElement fieldset, dart_html.Element legend, String caption, [bool asHtml = true]) {
    // TODO(bruce): rewrite to be inlinable
    assert (caption != null);

    if (asHtml) {
      legend.innerHtml = caption;
    } else {
      legend.text = caption;
    }

    if ("" != caption) {
      // This is formulated to become an append (if there's no widget), an
      // insertion at index 0 (if there is a widget but no legend already), or
      // a no-op (if the legend is already in place).
      fieldset.insertBefore(legend, fieldset.$dom_firstChild);
    } else if (legend.parent != null) {
      // We remove the legend from the DOM because leaving it in with an empty
      // string renders as an ugly gap in the top border on some browsers.
      //fieldset.removeChild(legend);
      legend.remove();
    }
  }
}

/**
 * Implementation class that handles Mozilla rendering issues.
 */
class CaptionPanelImplMozilla extends CaptionPanelImpl {
  
  void setSafeCaption(dart_html.FieldSetElement fieldset, dart_html.Element legend, SafeHtml caption) {
    setCaption(fieldset, legend, caption.asString(), true);
  }

  void setCaption(dart_html.FieldSetElement fieldset, dart_html.Element legend, String caption, [bool asHtml = true]) {
    fieldset.style.display = "none";
    super.setCaption(fieldset, legend, caption, asHtml);
    fieldset.style.display = "";
  }
}

/**
 * Implementation class that handles Safari rendering issues.
 */
class CaptionPanelImplSafari extends CaptionPanelImpl {

  void setSafeCaption(dart_html.FieldSetElement fieldset, dart_html.Element legend, SafeHtml caption) {
    setCaption(fieldset, legend, caption.asString(), true);
  }

  void setCaption(dart_html.FieldSetElement fieldset, dart_html.Element legend, String caption, [bool asHtml = true]) {
    fieldset.style.visibility = "hidden";
    super.setCaption(fieldset, legend, caption, asHtml);
    Scheduler.get().scheduleDeferred(new _CaptionPanelImplSafariScheduledCommand(fieldset));
  }
}

class _CaptionPanelImplSafariScheduledCommand implements ScheduledCommand {
  
  dart_html.FieldSetElement _fieldset;
  
  _CaptionPanelImplSafariScheduledCommand(this._fieldset);
  
  void execute() {
    _fieldset.style.visibility = "";
  }
}