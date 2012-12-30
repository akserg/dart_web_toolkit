//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A simple radio button widget, with no label.
 * 
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.gwt-SimpleRadioButton { }</li>
 * <li>.gwt-SimpleRadioButton-disabled { Applied when radio button is disabled }</li>
 * </ul>
 */
class SimpleRadioButton extends SimpleCheckBox {
  
  /**
   * Creates a SimpleRadioButton widget that wraps an existing &lt;input
   * type='radio'&gt; element.
   * 
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   * 
   * @param element the element to be wrapped
   */
  factory SimpleRadioButton.wrap(dart_html.RadioButtonInputElement element) {
    // Assert that the element is attached.
    //assert Document.get().getBody().isOrHasChild(element);

    SimpleRadioButton radioButton = new SimpleRadioButton(element);

    // Mark it attached and remember it for cleanup.
    radioButton.onAttach();
    RootPanel.detachOnWindowClose(radioButton);

    return radioButton;
  }
  
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
  SimpleRadioButton([dart_html.InputElement element = null, String name = null]) : super(element == null ? new dart_html.InputElement(type: 'radio') : element) {
    if (name != null) {
      this.name = name;
    }
    clearAndSetStyleName("dwt-SimpleRadioButton");
  }
}
