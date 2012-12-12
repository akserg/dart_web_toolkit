//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Abstract base class for all panels, which are widgets that can contain other
 * widgets.
 */
abstract class Panel extends Widget implements HasWidgetsForIsWidget {
  
  //*****************************
  // Implementation of HasWidgets
  //*****************************
  /**
   * Adds a child widget.
   * 
   * <p>
   * <b>How to Override this Method</b>
   * </p>
   * <p>
   * There are several important things that must take place in the correct
   * order to properly add or insert a Widget to a Panel. Not all of these steps
   * will be relevant to every Panel, but all of the steps must be considered.
   * <ol>
   * <li><b>Validate:</b> Perform any sanity checks to ensure the Panel can
   * accept a new Widget. Examples: checking for a valid index on insertion;
   * checking that the Panel is not full if there is a max capacity.</li>
   * <li><b>Adjust for Reinsertion:</b> Some Panels need to handle the case
   * where the Widget is already a child of this Panel. Example: when performing
   * a reinsert, the index might need to be adjusted to account for the Widget's
   * removal. See {@link ComplexPanel#adjustIndex(Widget, int)}.</li>
   * <li><b>Detach Child:</b> Remove the Widget from its existing parent, if
   * any. Most Panels will simply call {@link Widget#removeFromParent()} on the
   * Widget.</li>
   * <li><b>Logical Attach:</b> Any state variables of the Panel should be
   * updated to reflect the addition of the new Widget. Example: the Widget is
   * added to the Panel's {@link WidgetCollection} at the appropriate index.</li>
   * <li><b>Physical Attach:</b> The Widget's Element must be physically
   * attached to the Panel's Element, either directly or indirectly.</li>
   * <li><b>Adopt:</b> Call {@link #adopt(Widget)} to finalize the add as the
   * very last step.</li>
   * </ol>
   * </p>
   * 
   * @param child the widget to be added
   * @throws UnsupportedOperationException if this method is not supported (most
   *           often this means that a specific overload must be called)
   * @see HasWidgets#add(Widget)
   */
  void add(Widget child) {
    throw new Exception("This panel does not support no-arg add()");
  }

  /**
   * Removes all child widgets.
   */
  void clear() {
    Iterator<Widget> it = iterator();
    while (it.hasNext) {
      it.next();
      //it.remove();
    }
  }
  
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
   * bool remove(Widget child);
   */
  
  //****************************************
  // Implementation of HasWidgetsForIsWidget
  //****************************************
  
  void addIsWidget(IsWidget child) {
    this.add(asWidgetOrNull(child));
  }

  bool removeIsWidget(IsWidget child) {
    return remove(asWidgetOrNull(child));
  }
  
  
  //*********
  // Children
  //*********
  
  /**
   * Finalize the attachment of a Widget to this Panel. This method is the
   * <b>last</b> step in adding or inserting a Widget into a Panel, and should
   * be called after physical attachment in the DOM is complete. This Panel
   * becomes the parent of the child Widget, and the child will now fire its
   * {@link Widget#onAttach()} event if this Panel is currently attached.
   * 
   * @param child the widget to be adopted
   * @see #add(Widget)
   */
  void adopt(Widget child) {
    assert (child.getParent() == null);
    child.setParent(this);
  }
  
  void doAttachChildren() {
    AttachDetachException.tryCommand(this, AttachDetachException.attachCommand);
  }
  
  void doDetachChildren() {
    AttachDetachException.tryCommand(this, AttachDetachException.detachCommand);
  }
  
  /**
   * <p>
   * This method must be called as part of the remove method of any Panel. It
   * ensures that the Widget's parent is cleared. This method should be called
   * after verifying that the child Widget is an existing child of the Panel,
   * but before physically removing the child Widget from the DOM. The child
   * will now fire its {@link Widget#onDetach()} event if this Panel is
   * currently attached.
   * </p>
   * <p>
   * Calls to {@link #orphan(Widget)} should be wrapped in a try/finally block
   * to ensure that the widget is physically detached even if orphan throws an
   * exception.
   * </p>
   * 
   * @param child the widget to be disowned
   * @see #add(Widget)
   */
  void orphan(Widget child) {
    assert (child.getParent() == this);
    child.setParent(null);
  }
}