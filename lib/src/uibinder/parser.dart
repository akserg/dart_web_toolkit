//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of uibinder;

/**
 * Owner class parser. It looks UiField anotations of fields and collect them in
 * [variables]. It keeps instance mirror of owner in [ownerInstance].
 */
class Parser<O> {

  Map<String, VariableMirror> variables = new Map<String, VariableMirror>();
  InstanceMirror ownerInstance;
  
  /**
   * Parse owner class to find UiFields.
   */
  void parse(O owner) {
    ownerInstance = reflect(owner);
    _findVariables();
  }
  
  /**
   * Find all UiField variables. 
   */
  void _findVariables() {
    _uiFieldVariables(ownerInstance.type).forEach((DeclarationMirror variable){
      if (variable is VariableMirror) {
        variables[_symbolAsString(variable.simpleName)] = variable;
      }
    });
  }
  
  /**
   * Returns ui field variables from [clazz].
   */
  Iterable<DeclarationMirror> _uiFieldVariables(ClassMirror clazz) =>
    clazz.declarations.values.where(_testUiField);
  
  /**
   * Test method returns true if the declared [element] is UiField
   */
  bool _testUiField(DeclarationMirror element) =>
    element.metadata.any((InstanceMirror im) => im.reflectee is _UiField);
  
  //********
  // Utility
  //********
  
  String _symbolAsString(Symbol symbol) => MirrorSystem.getName(symbol);
}