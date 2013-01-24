//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_test;

/**
 * Abstract test group class made for help create group of tests.
 */
abstract class TestGroup {

  final LinkedHashMap<String, Function> testList;

  String testGroupName;

  /**
   * Create an instance of [TestGroup].
   */
  TestGroup() :
    testList = new LinkedHashMap<String, Function>() {

    registerTests();
  }

  /**
   * Method to be implemented in extended classes to register tests.
   */
  void registerTests();
}
