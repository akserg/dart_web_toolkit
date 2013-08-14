//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of uibinder;

/**
 * Class that generate DOM or Widget structures from string template, 
 * and which inject portions of the generated UI into the fields of an owner.
 *
 * @param <U> The type of the root object of the generated UI, typically a
 *          subclass of {@link com.google.gwt.dom.client.Element Element} or
 *          {@link com.google.gwt.user.client.ui.UIObject UiObject}
 * @param <O> The type of the object that will own the generated UI
 */
class UiBinder<U extends Widget, O> {
  
  String viewTemplate;
  Map<String, VariableMirror> _variables;
  InstanceMirror _ownerInstanceMirror;
  
  /**
   * Instantiate UiBinder.
   * We check is that instance was annotated with @UiTemplate and read 
   * information into viewTemplate here.
   */
  UiBinder() {
    InstanceMirror mineIM = reflect(this);
    ClassMirror mineCM = mineIM.type;
    InstanceMirror templateIM = mineCM.metadata.firstWhere((InstanceMirror im) { 
      return im.reflectee is UiTemplate;
    }, orElse:() {
      return null;
    });
    if (templateIM != null) {
      UiTemplate tmpl = templateIM.reflectee as UiTemplate;
      //
      var httpRequest = new HttpRequest();
      httpRequest
        ..open('GET', tmpl.path)
        ..onLoadEnd.listen((){
          if (httpRequest.status == 200) {
            viewTemplate = httpRequest.responseText;
          } else {
            // Can't load specified template
            throw new Exception("Can't load template from ${tmpl.path}.\nError status: ${httpRequest.status}");
          }
        })
        ..send();
    }
  }
  
  /**
   * Creates and returns the root object of the UI, and fills any fields of owner
   * tagged with {@link UiField}.
   *
   * @param owner the object whose {@literal @}UiField needs will be filled
   */
  U createAndBindUi(O owner) {
    // Parse owner to find annotations
    _parse(owner);
    // Create an instance of main widget
    ClassMirror uClassMirror = reflectClass(U);
    U widget = uClassMirror.newInstance(const Symbol(""), []).reflectee as U;
    widget.getElement().innerHtml = viewTemplate;
    document.body.append(widget.getElement());
    _parseTemplate(widget.getElement(), owner);
    widget.getElement().remove();
    return widget;
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
    String fieldName = child.$dom_getAttribute("ui:field");
    if (fieldName != null) {
      _instantiateVariable(fieldName, child);
    }
  }
  
  void _instantiateVariable(String fieldName, Element element) {
    try {
      VariableMirror variableMirror = _variables[fieldName];
       dynamic variable = _instantiateAndWrap(variableMirror.type, element);
       _ownerInstanceMirror.setField(variableMirror.simpleName, variable);
    } on Exception catch(ex) {
      print(ex);
    }
  }

  dynamic _instantiateAndWrap(TypeMirror tm, Element element) {
    
    InstanceMirror im = _newInstance(tm, element);
    return im.reflectee;
  }
  
  // create a new instance of classMirror and inject it
  InstanceMirror _newInstance(ClassMirror classMirror, Element child) {
    // Instantiate Widget
    print("Instantiate ${symbolAsString(classMirror.simpleName)}");
    return classMirror.newInstance(const Symbol("wrap"), [child]);
  }
  
  Iterable<MethodMirror> _wrapableConstructor(ClassMirror classMirror) {
    return classMirror.constructors.values.where(_testWrapConstructor);
  }
  
  /** Returns true if the declared [element] has 'wrap' factory */
  bool _testWrapConstructor(MethodMirror method) => 
      method.simpleName.toString().contains("wrap");
  
  String symbolAsString(Symbol symbol) => MirrorSystem.getName(symbol);

  //*******
  // Parser
  //*******
  
  /**
   * Parse owner class to find UiFields.
   */
  void _parse(O owner) {
    Map fields = new Map();
    //
    _ownerInstanceMirror = reflect(owner);
    _findVariables(_ownerInstanceMirror);
  }
  
  /**
   * Find all UiField variables in [InstanceMirror]. 
   */
  void _findVariables(InstanceMirror instanceMirror) {
    _variables = new Map<String, VariableMirror>();
    _uiFieldVariables(instanceMirror.type).forEach((VariableMirror variable){
      _variables[symbolAsString(variable.simpleName)] = variable;
    });
  }
  
  /** Returns ui field variables */
  Iterable<VariableMirror> _uiFieldVariables(ClassMirror classMirror) => 
      classMirror.variables.values.where(_testUiField);
  
  /** Returns true if the declared [element] is UiField */
  bool _testUiField(DeclarationMirror element) => 
      element.metadata.any((InstanceMirror im) => im.reflectee is _UiField);
}