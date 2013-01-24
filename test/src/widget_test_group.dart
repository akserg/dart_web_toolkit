//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_test;

/**
 * Test Widget.
 */
class WidgetTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Widget";

    this.testList["verify"] = verifyTest;
  }

  /**
   * Varify process of creation Widget.
   */
  void verifyTest() {
    ui.Widget widget = new ui.Widget();
    expect(widget, isNotNull);
  }
}