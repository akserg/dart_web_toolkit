//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A mutually-exclusive selection radio button widget. Fires
 * {@link com.google.gwt.event.dom.client.ClickEvent}s
 * when the radio button is clicked, and {@link ValueChangeEvent}s when the
 * button becomes checked. Note, however, that browser limitations prevent
 * ValueChangeEvents from being sent when the radio button is cleared as a side
 * effect of another in the group being clicked.
 *
 * <p>
 * <img class='gallery' src='doc-files/RadioButton.png'/>
 * </p>
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
 * <dl>
 * <dt>.gwt-RadioButton</dt>
 * <dd>the outer element</dd>
 * </dl>
 *
 * <p>
 * <h3>Example</h3> {@example com.google.gwt.examples.RadioButtonExample}
 * </p>
 */
class RadioButton extends CheckBox {

  bool _oldValue;

  /**
   * Creates a new radio associated with a particular group name. All radio
   * buttons associated with the same group name belong to a mutually-exclusive
   * set.
   *
   * Radio buttons are grouped by their name attribute, so changing their name
   * using the setName() method will also change their associated group.
   *
   * @param name the group name with which to associate the radio button
   */
  RadioButton(String name, [String label = null, bool asHtml = false]) : super.fromElement(new dart_html.InputElement()) {
    inputElem.type = "radio";
    //super(DOM.createInputRadio(name));
    inputElem.name = name;
    clearAndSetStyleName("dwt-RadioButton");

    if (label != null) {
      if (asHtml) {
        html = label;
      } else {
        text = label;
      }
    }
    sinkEvents(Event.ONCLICK);
    sinkEvents(Event.ONMOUSEUP);
    sinkEvents(Event.ONBLUR);
    sinkEvents(Event.ONKEYDOWN);
  }

  /**
   * Overridden to send ValueChangeEvents only when appropriate.
   */
  void onBrowserEvent(dart_html.Event event) {
    
    if (event.type == BrowserEvents.MOUSEUP ||
        event.type == BrowserEvents.BLUR ||
        event.type == BrowserEvents.KEYDOWN) {
      // Note the old value for onValueChange purposes (in ONCLICK case)
      _oldValue = getValue();
    } else if (event.type == BrowserEvents.CLICK) {
      dart_html.EventTarget target = (event as dart_html.MouseEvent).target;
      if (target is  dart_html.Element && Dom.isOrHasChild(labelElem, target as dart_html.Element)) {

        // They clicked the label. Note our pre-click value, and
        // short circuit event routing so that other click handlers
        // don't hear about it
        _oldValue = getValue();
        return;
      }

      // It's not the label. Let our handlers hear about the
      // click...
      super.onBrowserEvent(event);
      // ...and now maybe tell them about the change
      ValueChangeEvent.fireIfNotEqual(this, _oldValue, getValue());
      return;
    }

    super.onBrowserEvent(event);
  }
  
  //**************************
  // Implementation of HasName
  //**************************

  /**
   * Change the group name of this radio button.
   *
   * Radio buttons are grouped by their name attribute, so changing their name
   * using the setName() method will also change their associated group.
   *
   * If changing this group name results in a new radio group with multiple
   * radio buttons selected, this radio button will remain selected and the
   * other radio buttons will be unselected.
   *
   * @param name name the group with which to associate the radio button
   */
  void set name(String val) {
    // Just changing the radio button name tends to break groupiness,
    // so we have to replace it. Note that replaceInputElement is careful
    // not to propagate name when it propagates everything else
    dart_html.InputElement radio = new dart_html.InputElement();
    radio.type = "radio";
    radio.name = name;
    replaceInputElement(radio);
  }

  // Unlike other widgets the Radio button sinks on its inputElement, not
  // its wrapper
  void sinkEvents(int eventBitsToAdd) {
    // Like CheckBox, we want to hear about inputElem. We
    // also want to know what's going on with the label, to
    // make sure onBrowserEvent is able to record value changes
    // initiated by label events
    if (isOrWasAttached()) {
      Event.sinkEvents(inputElem, eventBitsToAdd | Event.getEventsSunk(inputElem));
      Event.sinkEvents(labelElem, eventBitsToAdd | Event.getEventsSunk(labelElem));
    } else {
      super.sinkEvents(eventBitsToAdd);
    }
  }
  
  /**
   * No-op. CheckBox's click handler is no good for radio button, so don't use
   * it. Our event handling is all done in {@link #onBrowserEvent}
   */
  void ensureDomEventHandlers() {}
}
