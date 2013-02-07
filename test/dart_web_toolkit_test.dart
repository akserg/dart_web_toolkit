//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library dart_web_toolkit_test;

import 'dart:html' as dart_html;
import 'package:unittest/unittest.dart';

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/util.dart' as util;
import 'package:dart_web_toolkit/i18n.dart' as i18n;

part 'test_group.dart';
part 'src/widget_test_group.dart';

vid main() {

  final _tList = new List<TestGroup>();

  _tList.add(new WidgetTestGroup());

  _tList.forEach((TestGroup t){
    group(t.testGroupName, (){
      t.testList.forEach((String name, Function testFunc){
        test(name, testFunc);
      });
    });
  });

}
