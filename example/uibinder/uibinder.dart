//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library test_uibinder;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/uibinder.dart';

part 'login_view.dart';
part 'name_lookup.dart';

void main() {
  dart_html.query("#loading").remove();
  //
//  String loginTemplate = """
//<div class='dyn-panel'>
//  <H1>My Form</h1>
//  <div ui:field='userLabel' class='dyn-message'>User Name</div>
//  <input ui:field='userInput'>
//  <div ui:field='passwordLabel' class='dyn-message'>Password</div>
//  <input ui:field='passwordInput'>
//  <button ui:field='logonButton'>Logon</button>
//</div>""";
//  
//  ui.RootPanel.get().add(new LoginView(loginTemplate));
//  
  ui.RootPanel.get().add(new NameLookup(['1', '2', '3']));
}