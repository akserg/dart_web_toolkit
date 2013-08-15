//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of uibinder;

/**
 * Class that generate DOM structures from string template, 
 * and which inject portions of the generated UI into the fields of an owner.
 * 
 * @param <U> The type of the root object of the generated UI, typically [UiObject]
 * @param <O> The type of the object that will own the generated UI
 */
class UiBinder<U extends Widget, O> {
  
  String template;
  
  /**
   * Creates and returns the root object of the UI fills any fields of owner 
   * tagged with [UiField].
   */
  U createAndBindUi(O owner) {
    Processor processor = new Processor(owner);
    // Create an instance of main widget
    U widget = Creator.create(U);
    // Set template to innerHtml
    widget.getElement().innerHtml = template;
    // Now assign our widget's element to body
    document.body.append(widget.getElement());
    // Parse template
    processor.parse(widget.getElement());
    // Remove our element from body
    widget.getElement().remove();
    // This is it!
    return widget;
  }
}