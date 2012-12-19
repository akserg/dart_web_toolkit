//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/shared.dart' as shared;
import 'package:dart_web_toolkit/ui.dart' as ui;

void main() {
  ui.Anchor anchor = new ui.Anchor(true);
  print("Href: ${anchor.href}");
  //
  anchor.tabIndex = 1;
  print("TabIndex: ${anchor.tabIndex}");
  //
  anchor.name = "Test";
  print("Name: ${anchor.name}");
  //
  anchor.target = "New target";
  print("Name: ${anchor.target}");
  //
  anchor.wordWrap = true;
  print("WordWrap: ${anchor.wordWrap}");
  anchor.wordWrap = false;
  print("WordWrap: ${anchor.wordWrap}");
  //
  anchor.html = "<b>hi</b>";
  print("Html: ${anchor.html}");
  //
  anchor.text = "Just text";
  print("Text: ${anchor.text}");
  //
  anchor.direction = "right";
  print("Direction: ${anchor.direction}");
  //
//  event.HandlerRegistration handlerRegistration;
//  handlerRegistration = anchor.addClickHandler(new shared.ClickHandler((shared.ClickEvent evt){
//    dart_html.UIEvent uiEvent = evt.nativeEvent;
//    print("Event: ${uiEvent.type}");
//    //
//    print("Direction: ${anchor.direction}");
//    handlerRegistration.removeHandler();
//  }));

  ui.RootPanel.get("testId").add(anchor);

  ui.HeaderPanel headerPanel = new ui.HeaderPanel();
  headerPanel.setSize("150px", "100px");

  headerPanel.setHeaderWidget(new ui.Button("Header"));
  headerPanel.setFooterWidget(new ui.CheckBox("Active Footer"));
  headerPanel.setContentWidget(new ui.Button("Center"));
  ui.RootPanel.get("testId").add(headerPanel);
}