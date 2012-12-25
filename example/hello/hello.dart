//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/shared.dart' as shared;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/util.dart' as util;

void main() {
// Create a panel to layout the widgets
  ui.VerticalPanel vpanel = new ui.VerticalPanel();
  vpanel.spacing = 5;
  
  // Add a normal and disabled text box
  ui.TextBox normalText = new ui.TextBox();
  // Set the normal text box to automatically adjust its direction according
  // to the input text. Use the Any-RTL heuristic, which sets an RTL direction
  // iff the text contains at least one RTL character.
  //normalText.setDirectionEstimator(AnyRtlDirectionEstimator.get());
  
  ui.TextBox disabledText = new ui.TextBox();
  disabledText.text = "read only"; //(constants.cwBasicTextReadOnly());
  disabledText.enabled = false;
  //vpanel.add(new HTML(constants.cwBasicTextNormalLabel()));
  vpanel.add(normalText);
  vpanel.add(disabledText);
  
  // Add a normal and disabled password text box
  ui.PasswordTextBox normalPassword = new ui.PasswordTextBox();
  ui.PasswordTextBox disabledPassword = new ui.PasswordTextBox();
  disabledPassword.text = "123456"; //constants.cwBasicTextReadOnly();
  disabledPassword.enabled = false;
  vpanel.add(normalPassword);
  vpanel.add(disabledPassword);
  
  // Add a text area
  ui.TextArea textArea = new ui.TextArea();
  textArea.setVisibleLines(5);
  vpanel.add(textArea);
  
  ui.RootPanel.get("testId").add(vpanel);
}

void main5() {

  List<String> listTypes = ["One", "Two", "Three", "4444", "555", "666"];
  
  // Create a panel to align the Widgets
  ui.HorizontalPanel hPanel = new ui.HorizontalPanel();
  hPanel.spacing = 20;

  // Add a drop box with the list types
  ui.ListBox dropBox = new ui.ListBox();
  //List<String> listTypes = constants.cwListBoxCategories();
  for (int i = 0; i < listTypes.length; i++) {
    dropBox.addItem(listTypes[i]);
  }
  //dropBox.ensureDebugId("cwListBox-dropBox");
  ui.VerticalPanel dropBoxPanel = new ui.VerticalPanel();
  dropBoxPanel.spacing = 4;
  //dropBoxPanel.add(new HTML(constants.cwListBoxSelectCategory()));
  dropBoxPanel.add(dropBox);
  hPanel.add(dropBoxPanel);

  // Add a list box with multiple selection enabled
  ui.ListBox multiBox = new ui.ListBox(true);
  //multiBox.ensureDebugId("cwListBox-multiBox");
  multiBox.setWidth("11em");
  multiBox.setVisibleItemCount(10);
  for (int i = 0; i < listTypes.length; i++) {
    multiBox.addItem(listTypes[i]);
  }
  ui.VerticalPanel multiBoxPanel = new ui.VerticalPanel();
  multiBoxPanel.spacing = 4;
  //multiBoxPanel.add(new HTML(constants.cwListBoxSelectAll()));
  multiBoxPanel.add(multiBox);
  hPanel.add(multiBoxPanel);

  // Add a handler to handle drop box events
//  dropBox.addChangeHandler(new ChangeHandler() {
//    public void onChange(ChangeEvent event) {
//      showCategory(multiBox, dropBox.getSelectedIndex());
//      multiBox.ensureDebugId("cwListBox-multiBox");
//    }
//  });

  // Show default category
  //showCategory(multiBox, 0);
  //multiBox.ensureDebugId("cwListBox-multiBox");
  
  ui.RootPanel.get("testId").add(hPanel);
}

void main4() {
  // Create a panel to layout the widgets
  ui.VerticalPanel vpanel = new ui.VerticalPanel();
  ui.HorizontalPanel pushPanel = new ui.HorizontalPanel();
  pushPanel.spacing = 10;
  ui.HorizontalPanel togglePanel = new ui.HorizontalPanel();
  togglePanel.spacing = 10;

  // Combine all the panels
  //vpanel.add(new HTML(constants.cwCustomButtonPush()));
  vpanel.add(pushPanel);
  //vpanel.add(new HTML("<br><br>" + constants.cwCustomButtonToggle()));
  vpanel.add(togglePanel);

  //************************
  // Add a normal PushButton
  //************************
  
  //ui.PushButton normalPushButton = new ui.PushButton(new Image(Showcase.images.gwtLogo()));
  ui.PushButton normalPushButton = new ui.PushButton.fromText("Register");
  //normalPushButton.ensureDebugId("cwCustomButton-push-normal");
  pushPanel.add(normalPushButton);

  // Add a disabled PushButton
  //ui.PushButton disabledPushButton = new ui.PushButton(new Image(Showcase.images.gwtLogo()));
  ui.PushButton disabledPushButton = new ui.PushButton.fromText("Logon");
  //disabledPushButton.ensureDebugId("cwCustomButton-push-disabled");
  disabledPushButton.enabled = false;
  pushPanel.add(disabledPushButton);
  
  //**************************
  // Add a normal ToggleButton
  //**************************
  
  ui.ToggleButton normalToggleButton = new ui.ToggleButton.fromText("Toggle");
  //normalToggleButton.ensureDebugId("cwCustomButton-toggle-normal");
  togglePanel.add(normalToggleButton);

  // Add a disabled ToggleButton
  ui.ToggleButton disabledToggleButton = new ui.ToggleButton.fromText("Disabled toggle");
  //disabledToggleButton.ensureDebugId("cwCustomButton-toggle-disabled");
  disabledToggleButton.enabled = false;
  disabledToggleButton.setDown(true);
  togglePanel.add(disabledToggleButton);

  
  ui.RootPanel.get("testId").add(vpanel);
}

void main3() {
  //*****************
  // SplitLayoutPanel
  //*****************

  ui.SplitLayoutPanel p = new ui.SplitLayoutPanel();
  p.addWest(new ui.Button("navigation"), 128.0);
  p.addNorth(new ui.Button("list"), 384.0);
  p.add(new ui.FileUpload());

  // Attach the LayoutPanel to the RootLayoutPanel. The latter will listen for
  // resize events on the window to ensure that its children are informed of
  // possible size changes.
  ui.RootLayoutPanel rp = ui.RootLayoutPanel.get();
  rp.add(p);
}

void main2() {
  //****************
  // DockLayoutPanel
  //****************

  ui.DockLayoutPanel p = new ui.DockLayoutPanel(util.Unit.PX);
  p.getElement().id = "dock";
  //
  p.addNorth(new ui.Button("north"), 50.0);
  p.addSouth(new ui.Button("south"), 100.0);
  p.addEast(new ui.Button("east"), 150.0);
  p.addWest(new ui.Button("west"), 200.0);
  p.add(new ui.Button("center"));

  //
  ui.RootLayoutPanel root = ui.RootLayoutPanel.get();
  root.getElement().id = "root";
  root.add(p);

}

void main1() {
  //*******
  // Anchor
  //*******

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

  //*******
  // Button
  //*******

  ui.Button button = new ui.Button("Click me");
  ui.RootPanel.get("testId").add(button);

  //************
  // HeaderPanel
  //************

  ui.HeaderPanel headerPanel = new ui.HeaderPanel();

  headerPanel.setSize("150px", "100px");

  headerPanel.setHeaderWidget(new ui.Button("Header"));
  headerPanel.setFooterWidget(new ui.CheckBox("Active Footer"));
  headerPanel.setContentWidget(new ui.RadioButton("group", "Center"));

  ui.RootPanel.get("testId").add(headerPanel);

  //**************
  // VerticalPanel
  //**************

  ui.VerticalPanel vPanel = new ui.VerticalPanel();
  vPanel.spacing = 5;

  // Add some content to the panel
  for (int i = 1; i < 10; i++) {
    vPanel.add(new ui.Button("Button $i"));
  }

  ui.RootPanel.get("testId").add(vPanel);

  //**************
  // HorizontalPanel
  //**************

  ui.HorizontalPanel hPanel = new ui.HorizontalPanel();
  hPanel.spacing = 5;

  // Add some content to the panel
  for (int i = 1; i < 10; i++) {
    hPanel.add(new ui.Button("Button ${i}1"));
  }

  ui.RootPanel.get("testId").add(hPanel);
}
