//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract base class for panels that can contain multiple child widgets.
 */
abstract class ComplexPanel extends Panel implements IndexedPanelForIsWidget {

  List<Widget> _children = new List<Widget>();

  /**
   * The command used to orphan children.
   */
  Command _orphanCommand;

  //*****************************
  // Implementation of HasWidgets
  //*****************************

  /**
   * Removes a child widget.
   *
   * <p>
   * <b>How to Override this Method</b>
   * </p>
   * <p>
   * There are several important things that must take place in the correct
   * order to properly remove a Widget from a Panel. Not all of these steps will
   * be relevant to every Panel, but all of the steps must be considered.
   * <ol>
   * <li><b>Validate:</b> Make sure this Panel is actually the parent of the
   * child Widget; return <code>false</code> if it is not.</li>
   * <li><b>Orphan:</b> Call {@link #orphan(Widget)} first while the child
   * Widget is still attached.</li>
   * <li><b>Physical Detach:</b> Adjust the DOM to account for the removal of
   * the child Widget. The Widget's Element must be physically removed from the
   * DOM.</li>
   * <li><b>Logical Detach:</b> Update the Panel's state variables to reflect
   * the removal of the child Widget. Example: the Widget is removed from the
   * Panel's {@link WidgetCollection}.</li>
   * </ol>
   * </p>
   *
   * @param child the widget to be removed
   * @return <code>true</code> if the child was present
   *
   */
  bool remove(Widget w) {
    // Validate.
    if (w.getParent() != this) {
      return false;
    }
    // Orphan.
    try {
      orphan(w);
    } finally {
      // Physical detach.
      dart_html.Element elem = w.getElement();
      //Dom.removeChild(DOM.getParent(elem), elem);
      elem.remove();

      // Logical detach.
      int indx = getChildren().indexOf(w);
      if (indx != -1) {
        getChildren().removeAt(indx);
      }
    }
    return true;
  }

  Iterator<Widget> iterator() {
    return getChildren().iterator();
  }
  //*******************************
  // Implementation of IndexedPanel
  //*******************************

  /**
   * Gets the child widget at the specified index.
   *
   * @param index the child widget's index
   * @return the child widget
   */
  Widget getWidget(int index) {
    return getChildren()[index];
  }

  /**
   * Gets the number of child widgets in this panel.
   *
   * @return the number of children
   */
  int getWidgetCount() {
    return getChildren().length;
  }

  /**
   * Gets the index of the specified child widget.
   *
   * @param child the widget to be found
   * @return the widget's index, or <code>-1</code> if it is not a child of this
   *         panel
   */
  int getWidgetIndex(Widget child) {
    return getChildren().indexOf(child);
  }

  /**
   * Removes the widget at the specified index.
   *
   * @param index the index of the widget to be removed
   * @return <code>false</code> if the widget is not present
   */
  bool removeAt(int index) {
    return remove(getWidget(index));
  }

  //******************************************
  // Implementation of IndexedPanelForIsWidget
  //******************************************

  int getWidgetIndexIsWidget(IsWidget child) {
    return getWidgetIndex(asWidgetOrNull(child));
  }

  //*********
  // Children
  //*********

  /**
   * Adds a new child widget to the panel, attaching its Element to the
   * specified container Element.
   *
   * @param child the child widget to be added
   * @param container the element within which the child will be contained
   */
  void addWidget(Widget child, dart_html.Element container) {
    // Detach new child.
    child.removeFromParent();

    // Logical attach.
    getChildren().add(child);

    // Physical attach.
    //Dom.appendChild(container, child.getElement());
    container.append(child.getElement());

    // Adopt.
    adopt(child);
  }

  /**
   * Adjusts beforeIndex to account for the possibility that the given widget is
   * already a child of this panel.
   *
   * @param child the widget that might be an existing child
   * @param beforeIndex the index at which it will be added to this panel
   * @return the modified index
   */
  int adjustIndex(Widget child, int beforeIndex) {
    checkIndexBoundsForInsertion(beforeIndex);

    // Check to see if this widget is already a direct child.
    if (child.getParent() == this) {
      // If the Widget's previous position was left of the desired new position
      // shift the desired position left to reflect the removal
      int idx = getWidgetIndex(child);
      if (idx < beforeIndex) {
        beforeIndex--;
      }
    }

    return beforeIndex;
  }

  /**
   * Checks that <code>index</code> is in the range [0, getWidgetCount()), which
   * is the valid range on accessible indexes.
   *
   * @param index the index being accessed
   */
  void checkIndexBoundsForAccess(int index) {
    if (index < 0 || index >= getWidgetCount()) {
      throw new Exception("Index Out Of Bounds Exception");
    }
  }

  /**
   * Checks that <code>index</code> is in the range [0, getWidgetCount()], which
   * is the valid range for indexes on an insertion.
   *
   * @param index the index where insertion will occur
   */
  void checkIndexBoundsForInsertion(int index) {
    if (index < 0 || index > getWidgetCount()) {
      throw new Exception("Index Out Of Bounds Exception");
    }
  }

  /**
   * Gets the list of children contained in this panel.
   *
   * @return a collection of child widgets
   */
  List<Widget> getChildren() {
    return _children;
  }

  /**
   * Insert a new child Widget into this Panel at a specified index, attaching
   * its Element to the specified container Element. The child Element will
   * either be attached to the container at the same index, or simply appended
   * to the container, depending on the value of <code>domInsert</code>.
   *
   * @param child the child Widget to be added
   * @param container the Element within which <code>child</code> will be
   *          contained
   * @param beforeIndex the index before which <code>child</code> will be
   *          inserted
   * @param domInsert if <code>true</code>, insert <code>child</code> into
   *          <code>container</code> at <code>beforeIndex</code>; otherwise
   *          append <code>child</code> to the end of <code>container</code>.
   */
  void insert(Widget child, dart_html.Element container, int beforeIndex,
      bool domInsert) {
    // Validate index; adjust if the widget is already a child of this panel.
    beforeIndex = adjustIndex(child, beforeIndex);

    // Detach new child.
    child.removeFromParent();

    // Logical attach.
    //getChildren().insert(child, beforeIndex);
    getChildren().insertRange(beforeIndex, 1); //, [child]);
    getChildren()[beforeIndex] = child;

    // Physical attach.
    if (domInsert) {
      //DOM.insertChild(container, child.getElement(), beforeIndex);
      dart_html.Element refChild = container.elements[beforeIndex];
      container.insertBefore(child.getElement(), refChild);
    } else {
      //DOM.appendChild(container, child.getElement());
      container.append(child.getElement());
    }

    // Adopt.
    adopt(child);
  }

  void doLogicalClear() {
    // TODO(jgw): When Layout work has landed, deprecate FlowPanel (the only
    // caller of this method in our code), and deprecate this method with an eye
    // to making it private down the road.

    // Only use one orphan command per panel to avoid object creation.
    if (_orphanCommand == null) {
      _orphanCommand = new OrpahExceptionCommand(this);
    }
    try {
      AttachDetachException.tryCommand(this, _orphanCommand);
    } finally {
      _children = new List<Widget>();
    }
  }
}

class OrpahExceptionCommand implements Command {

  Panel _panel;

  OrpahExceptionCommand(this._panel);

  /**
   * The singleton command used to attach widgets.
   */
  void execute(Widget w) {
    _panel.orphan(w);
  }
}
