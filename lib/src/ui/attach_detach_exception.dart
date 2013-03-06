//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * An exception that is thrown when the panel fails to attach or detach its
 * children.
 */
class AttachDetachException extends UmbrellaException {

  /**
   * The singleton command used to attach widgets.
   */
  static AttachExceptionCommand attachCommand = new AttachExceptionCommand();

  /**
   * The singleton command used to detach widgets.
   */
  static DetachExceptionCommand detachCommand = new DetachExceptionCommand();

  /**
   * <p>
   * Iterator through all child widgets, trying to perform the specified
   * {@link Command} for each. All widgets will be visited even if the Command
   * throws an exception. If one or more exceptions occur, they will be combined
   * and thrown as a single {@link AttachDetachException}.
   * </p>
   * <p>
   * Use this method when attaching or detaching a widget with children to
   * ensure that the logical and physical state of all children match the
   * logical and physical state of the parent.
   * </p>
   *
   * @param hasWidgets children to iterate
   * @param c the {@link Command} to try on all children
   */
  static void tryCommand(Iterator<Widget> hasWidgets, AttachCommand c) {
    Set<Exception> caught = null;
    for (;hasWidgets.moveNext(); ) {
      Widget w = hasWidgets.current;
      try {
        c.execute(w);
      } on Exception catch (e) {
        // Catch all exceptions to prevent some children from being attached
        // while others are not.
        if (caught == null) {
          caught = new Set<Exception>();
        }
        caught.add(e);
      }
    }

    // Throw the combined exceptions now that all children are attached.
    if (caught != null) {
      throw new AttachDetachException(caught);
    }
  }

  /**
   * <p>
   * Iterator through all child widgets, trying to perform the specified
   * {@link Command} for each. All widgets will be visited even if the Command
   * throws an exception. If one or more exceptions occur, they will be combined
   * and thrown as a single {@link AttachDetachException}.
   * </p>
   * <p>
   * Use this method when attaching or detaching a widget with children to
   * ensure that the logical and physical state of all children match the
   * logical and physical state of the parent.
   * </p>
   *
   * @param c the {@link Command} to try on all children
   * @param widgets children to iterate, null children are ignored
   */
  static void tryCommand2(AttachCommand c, List<IsWidget> widgets) {
    Set<Exception> caught = null;
    for (IsWidget w in widgets) {
      try {
        if (w != null) {
          c.execute(w.asWidget());
        }
      } on Exception catch (e) {
        // Catch all exceptions to prevent some children from being attached
        // while others are not.
        if (caught == null) {
          caught = new Set<Exception>();
        }
        caught.add(e);
      }
    }

    // Throw the combined exceptions now that all children are attached.
    if (caught != null) {
      throw new AttachDetachException(caught);
    }
  }

  /**
   * Construct a new {@link AttachDetachException}.
   *
   * @param causes the causes of the exception
   */
  AttachDetachException(Set<Exception> causes) : super (causes);
}

/**
 * The command to execute when iterating through child widgets.
 */
abstract class AttachCommand {

  void execute(Widget w);
}

class AttachExceptionCommand implements AttachCommand {

  /**
   * The singleton command used to attach widgets.
   */
  void execute(Widget w) {
    w.onAttach();
  }
}

class DetachExceptionCommand implements AttachCommand {

  /**
   * The singleton command used to attach widgets.
   */
  void execute(Widget w) {
    w.onDetach();
  }
}