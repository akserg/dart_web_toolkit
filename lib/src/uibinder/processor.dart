//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of uibinder;

/**
 * Processor for UiBinder.
 */
class Processor<O> {
  
  Parser _parser;
  O _owner;
  
  /**
   * Create new instance. 
   */
  Processor(this._owner) {
    _parser = new Parser<O>();
    // Parse owner to find annotations
    _parser.parse(_owner);
  }
  
  /**
   * Parse template and bind filds to elements from template wrapped to widgets.
   */
  void parse(Element root) {
    _process(root);
  }
  
  /**
   * Process each [element] of owner.
   */
  void _process(Element element) {
    Node child = element.firstChild;
    // We only processing Eements
    while (child != null) {
      if (child is Element) {
        _tryToAssign(child);
      }
      
      if (child.hasChildNodes()) {
        _process(child);
      }

      if (child is Element) {
        child = (child as Element).nextElementSibling;
      } else {
        child = child.nextNode;
      }
    } 
  }
  
  /**
   * Try to assign [element] to one of fields of owner.
   */
  void _tryToAssign(Element element) {
    String field = element.attributes["ui:field"]; //$dom_getAttribute("ui:field");
    if (field != null) {
      _tryToInstantiateVariable(field, element);
    }
  }
  
  /**
   * Try to instantiate [field] wrapping [element]. 
   */
  void _tryToInstantiateVariable(String field, Element element) {
    try {
      // Get variable by name
      VariableMirror variableMirror = _parser.variables[field];
      // Instantiate widget by 'wrap' constructor
       dynamic variable = Creator.instantiateWidget(variableMirror.type, element).reflectee;
       // Set widget to variable in owner
       _parser.ownerInstance.setField(variableMirror.simpleName, variable);
    } on Exception catch(ex) {
      print(ex);
    }
  }
}