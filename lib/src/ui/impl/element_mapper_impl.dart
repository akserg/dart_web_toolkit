//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Creates a mapping from elements to their associated ui objects.
 * 
 * @param <T> the type that the element is mapped to
 */
class ElementMapperImpl<T> {
  
  static void clearIndex(dart_html.Element elem) {
    elem["__uiObjectID"] = null;
  }

  static int getIndex(dart_html.Element elem) {
    var index = elem["__uiObjectID"];
    return (index == null) ? -1 : index;
  }

  static void setIndex(dart_html.Element elem, int index) {
    elem["__uiObjectID"] = index;
  }

  FreeNode freeList = null;

  final List<T> uiObjectList = new List<T>();

  /**
   * Returns the uiObject associated with the given element.
   * 
   * @param elem uiObject's element
   * @return the uiObject
   */
  T get(dart_html.Element elem) {
    int index = getIndex(elem);
    if (index < 0) {
      return null;
    }
    return uiObjectList[index];
  }

  /**
   * Gets the list of ui objects contained in this element mapper.
   * 
   * @return the list of ui objects
   */
  List<T> getObjectList() {
    return uiObjectList;
  }

  /**
   * Creates an iterator from the ui objects stored within.
   * 
   * @return an iterator of the ui objects indexed by this element mapper.
   */
  Iterator<T> iterator() {
    return uiObjectList.iterator();
  }

  /**
   * Adds the MappedType.
   * 
   * @param uiObject uiObject to add
   */
  void put(T uiObject) {
    int index;
    if (freeList == null) {
      index = uiObjectList.length;
      uiObjectList.add(uiObject);
    } else {
      index = freeList.index;
      uiObjectList[index] = uiObject;
      freeList = freeList.next;
    }
    setIndex((uiObject as UiObject).getElement(), index);
  }

  /**
   * Remove the uiObject associated with the given element.
   * 
   * @param elem the uiObject's element
   */
  void removeByElement(dart_html.Element elem) {
    int index = getIndex(elem);
    removeImpl(elem, index);
  }

  void removeImpl(dart_html.Element elem, int index) {
    clearIndex(elem);
    uiObjectList[index] = null;
    freeList = new FreeNode(index, freeList);
  }
}

class FreeNode {
  int index;
  FreeNode next;

  FreeNode(this.index, this.next);
}
