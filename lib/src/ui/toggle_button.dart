//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A <code>ToggleButton</code> is a stylish stateful button which allows the
 * user to toggle between <code>up</code> and <code>down</code> states.
 *
 * <p>
 * <img class='gallery' src='doc-files/ToggleButton.png'/>
 * </p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class="css">
 * <li>
 * .gwt-ToggleButton-up/down/up-hovering/down-hovering/up-disabled/down-disabled
 * {.html-face}</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3> {@example com.google.gwt.examples.ToggleButtonExample}
 * </p>
 */
class ToggleButton extends CustomButton implements HasValue<bool>, IsEditor<LeafValueEditor<bool>> {

static final String _STYLENAME_DEFAULT = "dwt-ToggleButton";

  /**
   * Constructor for <code>CustomButton</code>.
   *
   * @param upImage image for the default (_up) face of the button
   */
  ToggleButton.fromImage(Image upImage, {Image downImage:null, ClickHandler handler:null}) : super.fromImage(upImage, downImage:downImage, handler:handler);

  /**
   * Constructor for <code>CustomButton</code>.
   *
   * @param upText the text for the default (_up) face of the button
   */
  ToggleButton.fromText(String upText, {String downText:null, ClickHandler handler:null}) : super.fromText(upText, downText:downText, handler:handler);

  ToggleButton.internal() : super.internal();

  /**
   * Constructor for <code>CustomButton</code>.
   */
  void _init() {
    super._init();
    //
    clearAndSetStyleName(_STYLENAME_DEFAULT);
  }

  //*****************************************
  // Implementation of HasValueChangeHandlers
  //*****************************************

  /**
   * Adds a {@link ValueChangeEvent} handler.
   *
   * @param handler the handler
   * @return the registration for the event
   */
  HandlerRegistration addValueChangeHandler(ValueChangeHandler<bool> handler) {
    return addHandler(handler, ValueChangeEvent.TYPE);
  }

  //*****************************
  // Implementation of TakesValue
  //*****************************

  /**
   * Determines whether this button is currently down.
   *
   * @return <code>true</code> if the button is pressed, false otherwise. Will
   *         not return null
   */
  bool getValue() {
    return isDown();
  }

  /**
   * Sets whether this button is down, firing {@link ValueChangeEvent} if
   * appropriate.
   *
   * @param value true to press the button, false otherwise; null value implies
   *          false
   * @param fireEvents If true, and value has changed, fire a
   *          {@link ValueChangeEvent}
   */
  void setValue(bool value, [bool fireEvents = false]) {
    bool oldValue = isDown();
    setDown(value);
    if (fireEvents) {
      ValueChangeEvent.fireIfNotEqual(this, oldValue, value);
    }
  }

  void onClick() {
    toggleDown();
    super.onClick();
    ValueChangeEvent.fire(this, isDown());
  }
}
