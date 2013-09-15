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
  
  NodeTreeSanitizer treeSanitizer;
  
  /**
   * Creates and returns the root object of the UI fills any fields of owner 
   * tagged with [UiField].
   */
  U createAndBindUi(O owner) {
    Processor processor = new Processor(owner);
    // Create an instance of main widget
    U widget = Creator.create(U);
    // Set template to innerHtml
    widget.getElement().setInnerHtml(template, 
        treeSanitizer: treeSanitizer != null ? treeSanitizer : new _NullTreeSanitizer());
    print("Inner html: ${widget.getElement().innerHtml}");
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

/**
 * Dummy NodeTreeSanitizer.
 */
class _NullTreeSanitizer implements NodeTreeSanitizer {
  
  /**
   * Called with the root of the tree which is to be sanitized.
   *
   * This method needs to walk the entire tree and either remove elements and
   * attributes which are not recognized as safe or throw an exception which
   * will mark the entire tree as unsafe.
   */
  void sanitizeTree(Node node) {
    print("Sanitizing ${node.toString()}");
  }
}