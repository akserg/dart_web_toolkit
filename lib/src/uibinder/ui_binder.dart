//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of metadata;

/**
 * Interface implemented by classes that generate DOM or Widget structures from
 * ui.xml template files, and which inject portions of the generated UI into the
 * fields of an owner.
 * <p>
 * The generated UiBinder implementation will be based on an xml file resource
 * in the same package as the owner class, with the same name and a "ui.xml"
 * suffix. For example, a UI owned by class {@code bar.baz.Foo} will be sought
 * in {@code /bar/baz/Foo.ui.xml}. (To use a different template file, put the
 * {@link UiTemplate} annotation on your UiBinder interface declaration to point
 * the code generator at it.)
 *
 * @param <U> The type of the root object of the generated UI, typically a
 *          subclass of {@link com.google.gwt.dom.client.Element Element} or
 *          {@link com.google.gwt.user.client.ui.UIObject UiObject}
 * @param <O> The type of the object that will own the generated UI
 */
class UiBinder<U, O> {
  static const Symbol WRAP_SYMBOL = const Symbol("wrap");
  
  String viewTemplate;
  Map<String, VariableMirror> _variables;
  InstanceMirror _ownerInstanceMirror;
  
  /**
   * Creates and returns the root object of the UI, and fills any fields of owner
   * tagged with {@link UiField}.
   *
   * @param owner the object whose {@literal @}UiField needs will be filled
   */
  U createAndBindUi(O owner) {
    // Parse owner to find annotations
    _parse(owner);
    // Create dummy widget
    SimplePanel html2 = new SimplePanel();
    html2.getElement().innerHtml = viewTemplate;
    document.body.append(html2.getElement());
    _parseTemplate(html2.getElement(), owner);
    html2.getElement().remove();
    return html2 as U;
  }
  
  /**
   * Parse template and bind firlds and elements in template.
   */
  void _parseTemplate(Element root, O owner) {
    _process(root, owner);
  }
  
  void _process(Element root, O owner) {
    Element child = root.$dom_firstElementChild;
    while (child != null) {
      _assign(child, owner);

      if (child.hasChildNodes()) {
        _process(child, owner);
      }

      child = child.nextElementSibling;
    }
  }
  
  void _assign(Element child, O owner) {
    String fieldName = _getFieldName(child);
    if (fieldName != null) {
      _instantiateVariable(fieldName, child);
    }
  }
  
  String _getFieldName(Element element) {
    return element.$dom_getAttribute("ui:field");
  }
  
  void _parse(O owner) {
    Map fields = new Map();
    //
    _ownerInstanceMirror = reflect(owner);
    _findVariables(_ownerInstanceMirror);
  }
  
  void _findVariables(InstanceMirror instanceMirror) {
    _variables = new Map<String, VariableMirror>();
    _uiFieldVariables(instanceMirror.type).forEach((VariableMirror variable){
      _variables[symbolAsString(variable.simpleName)] = variable;
    });
  }
  
  void _instantiateVariable(String fieldName, Element element) {
    VariableMirror variableMirror = _variables[fieldName];
    if (variableMirror != null) {
       dynamic variable = _instantiateAndWrap(variableMirror.type, element);
       _ownerInstanceMirror.setField(variableMirror.simpleName, variable);
    }
  }
  
  /** Returns variables that need injection */
  Iterable<VariableMirror> _uiFieldVariables(ClassMirror classMirror) => classMirror.variables.values.where(_testUiField);
  
  /** Returns true if the declared [element] is injectable */
  bool _testUiField(DeclarationMirror element) => element.metadata.any((InstanceMirror im) => im.reflectee is _UiField);
  
  dynamic _instantiateAndWrap(TypeMirror tm, Element element) {
    
    InstanceMirror im = _newInstance(tm, element);
    return im.reflectee; //_resolveInjections(im);
  }
  
  // create a new instance of classMirror and inject it
  InstanceMirror _newInstance(ClassMirror classMirror, Element child) {
    // Instantiate Widget
    return classMirror.newInstance(WRAP_SYMBOL, [child]);
  }
  
  Iterable<MethodMirror> _wrapableConstructor(ClassMirror classMirror) {
    return classMirror.constructors.values.where(_testWrapConstructor);
  }
  
  /** Returns true if the declared [element] is injectable */
  bool _testWrapConstructor(MethodMirror method) => method.simpleName.toString().contains("wrap");
  
  String symbolAsString(Symbol symbol) => MirrorSystem.getName(symbol);
}