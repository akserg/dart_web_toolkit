//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of uibinder;

class Creator {
  
  /**
   * Create main widget
   */
  static dynamic create(u) {
    ClassMirror uClassMirror = reflectClass(u);
    return uClassMirror.newInstance(const Symbol(""), []).reflectee;
  }

  
  /**
   * Create new instance of widget by wrapping [element]. 
   */
  static InstanceMirror instantiateWidget(ClassMirror clazz, Element element) {
    return clazz.newInstance(const Symbol("wrap"), [element]);
  }

}