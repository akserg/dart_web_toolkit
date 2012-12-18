//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Encapsulates an action for later execution, often from a different context.
 *
 * The Command interface provides a layer of separation between the code
 * specifying some behavior and the code invoking that behavior. This separation
 * aids in creating reusable code. For example, a
 * {@link com.google.gwt.user.client.ui.MenuItem} can have a Command associated
 * with it that it executes when the menu item is chosen by the user.
 * Importantly, the code that constructed the Command to be executed when the
 * menu item is invoked knows nothing about the internals of the MenuItem class
 * and vice-versa.

 * The Command interface is often implemented with an anonymous inner class. For
 * example,
 *
 * Command sayHello = new Command() {
 *   public void execute() {
 *     Window.alert("Hello");
 *   }
 * };
 * sayHello.execute();
 */
abstract class Command<H> {

  /**
   * Causes the Command to perform its encapsulated behavior.
   */
  void execute();
}
