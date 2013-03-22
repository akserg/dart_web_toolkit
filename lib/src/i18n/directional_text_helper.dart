//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * A helper class for displaying bidi (i.e. potentially opposite-direction) text
 * or HTML in an element.
 * Note: this class assumes that callers perform all their text/html and
 * direction manipulations through it alone.
 */
class DirectionalTextHelper implements HasDirectionEstimator {

  /**
   * A default direction estimator instance.
   */
  static DirectionEstimator DEFAULT_DIRECTION_ESTIMATOR;// = WordCountDirectionEstimator.get();

  /**
   * The DirectionEstimator object.
   */
  DirectionEstimator directionEstimator;

  /**
   * Whether direction was explicitly set on the last {@code setTextOrHtml}
   * call. If so, {@link #setDirectionEstimator} will refrain from modifying the
   * direction until {@link #setTextOrHtml} is called without specifying an
   * explicit direction.
   */
  bool isDirectionExplicitlySet = false;

  /**
   * Whether the element contains a nested &lt;span&gt; element used to
   * indicate the content's direction.
   * <p>
   * The element itself is used for this purpose when it is a block element
   * (i.e. !isElementInline), but doing so on an inline element often results in
   * garbling what follows it. Thus, when the element is inline, a nested
   * &lt;span&gt; must be used to carry the content's direction, with an LRM or
   * RLM character afterwards to prevent the garbling.
   */
  bool isSpanWrapped = false;

  /**
   * The target element.
   */
  dart_html.Element element;

  /**
   * The initial direction of the element.
   */
  Direction initialElementDir;

  /**
   * Whether the element is inline (e.g. a &lt;span&gt; element, but not a block
   * element like &lt;div&gt;).
   * This is needed because direction is handled differently for inline elements
   * and for non-inline elements.
   */
  bool isElementInline = false;

  /**
   * The direction of the element's content.
   * Note: this may not match the direction attribute of the element itself.
   * See
   * {@link #setTextOrHtml(String, com.google.gwt.i18n.client.HasDirection.Direction, boolean) setTextOrHtml(String, Direction, boolean)}
   * for details.
   */
  Direction textDir;

  /**
   * @param element The widget's element holding text.
   * @param isElementInline Whether the element is an inline element.
   */
  DirectionalTextHelper(dart_html.Element element, bool isElementInline) {
    this.element = element;
    this.isElementInline = isElementInline;
    isSpanWrapped = false;
    this.initialElementDir = BidiUtils.getDirectionOnElement(element);
    textDir = initialElementDir;
    // setDirectionEstimator shouldn't refresh appearance of initial empty text.
    isDirectionExplicitlySet = true;
  }

  DirectionEstimator getDirectionEstimator() {
    return directionEstimator;
  }

  /**
   * See note at
   * {@link #setDirectionEstimator(com.google.gwt.i18n.shared.DirectionEstimator)}.
   */
  void enableDefaultDirectionEstimator(bool enabled) {
    setDirectionEstimator(enabled ? DEFAULT_DIRECTION_ESTIMATOR : null);
  }

  /**
   * Note: if the element already has non-empty content, this will update
   * its direction according to the new estimator's result. This may cause
   * flicker, and thus should be avoided; DirectionEstimator should be set
   * before the element has any content.
   */
  void setDirectionEstimator(DirectionEstimator directionEstimator) {
    this.directionEstimator = directionEstimator;
    /*
     * Refresh appearance unless direction was explicitly set on last
     * setTextOrHtml call.
     */
    if (!isDirectionExplicitlySet) {
      setTextOrHtml(getTextOrHtml(true), true);
    }
  }

  /**
   * Get the inner text or html of the element, taking the inner span wrap into
   * consideration, if needed.
   *
   * @param isHtml true to get the inner html, false to get the inner text
   * @return the text or html
   */
  String getTextOrHtml(bool isHtml) {
    dart_html.Element elem = isSpanWrapped ? element.$dom_firstElementChild : element;
    return isHtml ? elem.innerHtml : elem.text;
  }

  /**
   * Sets the element's content to the given value (either plain text or HTML).
   * If direction estimation is off, the direction is verified to match the
   * element's initial direction. Otherwise, the direction is affected as
   * described at
   * {@link #setTextOrHtml(String, com.google.gwt.i18n.client.HasDirection.Direction, boolean) setTextOrHtml(String, Direction, boolean)}.
   *
   * @param content the element's new content
   * @param isHtml whether the content is HTML
   */
  void setTextOrHtml(String content, bool isHtml, [Direction dir = null]) {
    if (directionEstimator == null) {
      isSpanWrapped = false;
      setInnerTextOrHtml(content, isHtml);

      /*
       * Preserves the initial direction of the element. This is different from
       * passing the direction parameter explicitly as DEFAULT, which forces the
       * element to inherit the direction from its parent.
       */
      if (textDir != initialElementDir) {
        textDir = initialElementDir;
        BidiUtils.setDirectionOnElement(element, initialElementDir);
      }
    } else {
      setTextOrHtmlWithDirection(content, directionEstimator.estimateStringDirection(content, isHtml), isHtml);
    }
    isDirectionExplicitlySet = false;
  }

  /**
   * Sets the element's content to the given value (either plain text or HTML),
   * applying the given direction.
   * <p>
   * Implementation details:
   * <ul>
   * <li> If the element is a block element, sets its dir attribute according
   * to the given direction.
   * <li> Otherwise (i.e. the element is inline), the direction is set using a
   * nested &lt;span dir=...&gt; element which holds the content of the element.
   * This nested span may be followed by a zero-width Unicode direction
   * character (LRM or RLM). This manipulation is necessary to prevent garbling
   * in case the direction of the element is opposite to the direction of its
   * context. See {@link com.google.gwt.i18n.shared.BidiFormatter} for more
   * details.
   * </ul>
   *
   * @param content the element's new content
   * @param dir the content's direction
   * @param isHtml whether the content is HTML
   */
  void setTextOrHtmlWithDirection(String content, Direction dir, bool isHtml) {
    textDir = dir;
    // Set the text and the direction.
    if (isElementInline) {
      isSpanWrapped = true;
      element.innerHtml = BidiFormatter.getInstanceForCurrentLocale(true /* alwaysSpan */).spanWrapWithKnownDir(dir, content, isHtml);
    } else {
      isSpanWrapped = false;
      BidiUtils.setDirectionOnElement(element, dir);
      setInnerTextOrHtml(content, isHtml);
    }
    isDirectionExplicitlySet = true;
  }

  Direction getTextDirection() {
    return textDir;
  }

  void setInnerTextOrHtml(String content, bool isHtml) {
    if (isHtml) {
      element.innerHtml = content;
    } else {
      element.text = content;
    }
  }
}
