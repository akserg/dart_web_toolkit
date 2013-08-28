//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract base class for all text display widgets.
 *
 * <h3>Use in UiBinder Templates</h3>
 *
 * @param <T> the value type
 */
class LabelBase<T> extends Widget implements HasWordWrap,
  HasDirectionEstimator, HasAutoHorizontalAlignment {

  /**
   * The widget's DirectionalTextHelper object.
   */
  DirectionalTextHelper directionalTextHelper;

  /**
   * The widget's auto horizontal alignment policy.
   *
   * @see HasAutoHorizontalAlignment
   */
  AutoHorizontalAlignmentConstant _autoHorizontalAlignment;

  /**
   * The widget's horizontal alignment.
   */
  HorizontalAlignmentConstant _horzAlign;

  LabelBase(bool inline) : this._internal(inline ? new dart_html.SpanElement() : new dart_html.DivElement(), inline);

  LabelBase.fromElement(dart_html.Element element) : this._internal(element, "span" == element.tagName.toLowerCase());

  LabelBase._internal(dart_html.Element element, bool isElementInline) {
    assert ((isElementInline ? "span" : "div") == element.tagName.toLowerCase());
    setElement(element);
    directionalTextHelper = new DirectionalTextHelper(getElement(), isElementInline);
  }

  //********************************************
  // Implementation of HasAutoHorizontalAlignment
  //********************************************

  AutoHorizontalAlignmentConstant getAutoHorizontalAlignment() {
    return _autoHorizontalAlignment;
  }

  void setAutoHorizontalAlignment(AutoHorizontalAlignmentConstant autoAlignment) {
    _autoHorizontalAlignment = autoAlignment;
    updateHorizontalAlignment();
  }

  //***************************************
  // Implemntation of HasDirectionEstimator
  //***************************************

  /**
   * Returns the {@code DirectionEstimator} object.
   */
  DirectionEstimator getDirectionEstimator() {
    return directionalTextHelper.getDirectionEstimator();
  }

  /**
   * Toggles on / off direction estimation.
   *
   * @param enabled Whether to enable direction estimation. If {@code true},
   *          sets the {@link DirectionEstimator} object to a default
   *          {@code DirectionEstimator}.
   */
  void enableDefaultDirectionEstimator(bool enabled) {
    directionalTextHelper.enableDefaultDirectionEstimator(enabled);
    updateHorizontalAlignment();
  }

  /**
   * {@inheritDoc}
   * <p>
   * Note: DirectionEstimator should be set before the widget has any content;
   * it's highly recommended to set it using a constructor. Reason: if the
   * widget already has non-empty content, this will update its direction
   * according to the new estimator's result. This may cause flicker, and thus
   * should be avoided.
   */
  void setDirectionEstimator(DirectionEstimator directionEstimator) {
    directionalTextHelper.setDirectionEstimator(directionEstimator);
    updateHorizontalAlignment();
  }

  //****************************************
  //Implementation of HasHorizontalAlignment
  //****************************************

  /**
   * {@inheritDoc}
   *
   * <p>
   * Note: A subsequent call to {@link #setAutoHorizontalAlignment} may override
   * the horizontal alignment set by this method.
   * <p>
   * Note: For {@code null}, the horizontal alignment is cleared, allowing it to
   * be determined by the standard HTML mechanisms such as inheritance and CSS
   * rules.
   *
   * @see #setAutoHorizontalAlignment
   */
  void setHorizontalAlignment(HorizontalAlignmentConstant align) {
    setAutoHorizontalAlignment(align);
  }

  HorizontalAlignmentConstant getHorizontalAlignment() {
    return _horzAlign;
  }

  //******************************
  // Implementation of HasWordWrap
  //******************************

  bool get wordWrap => WhiteSpace.NOWRAP.value == getElement().style.whiteSpace;

  void set wordWrap(bool wrap) {
    getElement().style.whiteSpace = wrap ? WhiteSpace.NORMAL.value : WhiteSpace.NOWRAP.value;
  }

  /**
   * Sets the horizontal alignment of the widget according to the current
   * AutoHorizontalAlignment setting. Should be invoked whenever the horizontal
   * alignment may be affected, i.e. on every modification of the content or its
   * direction.
   */
  void updateHorizontalAlignment() {
    HorizontalAlignmentConstant align;
    if (_autoHorizontalAlignment == null) {
      align = null;
    } else if (_autoHorizontalAlignment is HorizontalAlignmentConstant) {
      align = _autoHorizontalAlignment as HorizontalAlignmentConstant;
    } else {
      /*
       * autoHorizontalAlignment is a truly automatic policy, i.e. either
       * ALIGN_CONTENT_START or ALIGN_CONTENT_END
       */
      align = _autoHorizontalAlignment == HasAutoHorizontalAlignment.ALIGN_CONTENT_START
          ? HorizontalAlignmentConstant.startOf(directionalTextHelper.getTextDirection())
          : HorizontalAlignmentConstant.endOf(directionalTextHelper.getTextDirection());
    }

    if (align != _horzAlign) {
      _horzAlign = align;
      getElement().style.textAlign = _horzAlign == null ? "" : _horzAlign.getTextAlignString();
    }
  }
}
