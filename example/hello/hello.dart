//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/shared.dart' as shared;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/util.dart' as util;

void main() {
  String html = "<div id='one' style='border:3px dotted blue;'></div><div id='two' style='border:3px dotted green;'></div>";
  ui.HtmlPanel panel = new ui.HtmlPanel(html);
  panel.setSize("200px", "120px");
  //panel.addStyleName("demo-panel");
  panel.addById(new ui.Button("Do Nothing"), "one");
  panel.addById(new ui.TextBox(), "two");
  
  ui.RootPanel.get("testId").add(panel);
}

void main15() {

  ui.FlowPanel flowpanel = new ui.FlowPanel();
  flowpanel.setSize("380px", "380px");
  
  ui.Button label = new ui.Button("My Button");
  shared.Dom.setStyleAttribute(label.getElement(), "border", "1px solid #00f");
  shared.Dom.setStyleAttribute(label.getElement(), "backgroundColor", "blue");
  label.setSize("100px", "100px");
  flowpanel.add(label);
  
  ui.RootPanel.get("testId").add(flowpanel);
}

void main14() {
  ui.Image image = new ui.Image("img/test.jpg");
  ui.RootPanel.get("testId").add(image);
}

void main13() {
  
  ui.DateLabel dLabel = new ui.DateLabel();
  dLabel.setValue(new Date.now());
  
  ui.RootPanel.get("testId").add(dLabel);
  
  ui.RootPanel.get("testId").add(new ui.Html(""));
  
  ui.NumberLabel nLabel = new ui.NumberLabel();
  nLabel.setValue(123.12);
  
  ui.RootPanel.get("testId").add(nLabel);
}

void main12() {
  ui.DeckLayoutPanel dPanel = new ui.DeckLayoutPanel();
  
  dPanel.setSize("500px", "400px");
  dPanel.add(new ui.Button("Button 1"));
  dPanel.add(new ui.Button("Button 2"));
  dPanel.showWidgetAt(1);
  
  ui.RootPanel.get("testId").add(dPanel);
}

void main11() {
  ui.DoubleBox dBox = new ui.DoubleBox();
  dBox.setMaxLength(10);
  dBox.setVisibleLength(5);
  dBox.setValue(123.4543453);
  ui.RootPanel.get("testId").add(dBox);
  
  ui.IntBox iBox = new ui.IntBox();
  iBox.setMaxLength(10);
  iBox.setVisibleLength(5);
  iBox.setValue(123123);
  ui.RootPanel.get("testId").add(iBox);

  ui.SimpleCheckBox sCheckBox = new ui.SimpleCheckBox();
  sCheckBox.setValue(true);
  sCheckBox.enabled = false;
  ui.RootPanel.get("testId").add(sCheckBox);
  
  ui.SimpleRadioButton rCheckBox = new ui.SimpleRadioButton();
  rCheckBox.setValue(true);
  rCheckBox.enabled = false;
  ui.RootPanel.get("testId").add(rCheckBox);
}

void main10() { 
  // Create Html
  ui.Html html = new ui.Html("<div id='fred' style='background-color: yellow; border: 1px dotted red; width: 200px; text-align: center;'> This is an HTML Widget </div>");
  ui.RootPanel.get("testId").add(html);
}

void main9() {
  // Create Label
  ui.Label label = new ui.Label("This is a Label");
  ui.RootPanel.get("testId").add(label);
}

void main8() {
  // Create a new stack layout panel.
  ui.StackLayoutPanel stackPanel = new ui.StackLayoutPanel(util.Unit.EM);
  stackPanel.setPixelSize(200, 400);

  // Add the Mail folders.
  //ui.Widget mailHeader = createHeaderWidget("Mail");
  //stackPanel.addWidget(createMailItem(), mailHeader, 4);
  stackPanel.addWidget(createMailItem(), "Mail", false, 4.0);

//  // Add a list of filters.
//  //ui.Widget filtersHeader = createHeaderWidget("<b>Filters</b>");
//  //stackPanel.addWidget(createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), filtersHeader, 4);
//  stackPanel.addWidget(createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), "<b>Filters</b>", true, 4.0);
//
//  // Add a list of contacts.
//  //ui.Widget contactsHeader = createHeaderWidget("Contacts");
//  //stackPanel.add(createContactsItem(), contactsHeader, 4);
//  stackPanel.addWidget(createContactsItem(), "Contacts", false, 4.0);
  
  ui.RootPanel.get("testId").add(stackPanel);
}

/**
 * Create a widget to display in the header that includes an image and some
 * text.
 * 
 * @param text the header text
 * @param image the {@link ImageResource} to add next to the header
 * @return the header widget
 */
ui.Widget createHeaderWidget(String text) {
  // Add the image and text to a horizontal panel
  ui.HorizontalPanel hPanel = new ui.HorizontalPanel();
  hPanel.setHeight("100%");
  hPanel.spacing = 0;
  hPanel.setVerticalAlignment(shared.HasVerticalAlignment.ALIGN_MIDDLE);
  //hPanel.add(new Image(image));
  ui.Button headerText = new ui.Button(text);
  headerText.clearAndSetStyleName("cw-StackPanelHeader");
  hPanel.add(headerText);
  return new ui.SimplePanel(hPanel);
}

void main7() {

  // Create a new stack panel
  //ui.StackPanel stackPanel = new ui.StackPanel();
  ui.DecoratedStackPanel stackPanel = new ui.DecoratedStackPanel();
  stackPanel.setWidth("200px");

  // Add the Mail folders
  String mailHeader = "Mail";
  stackPanel.add(createMailItem(), mailHeader, false);

  // Add a list of filters
  String filtersHeader = "<b>Filters</b>";
  stackPanel.add(createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), filtersHeader, true);

  // Add a list of contacts
  String contactsHeader = "Contacts";
  stackPanel.add(createContactsItem(), contactsHeader, false);
  
  stackPanel.showStack(1);

  ui.RootPanel.get("testId").add(stackPanel);
}

ui.VerticalPanel createMailItem() {
  ui.VerticalPanel mailsPanel = new ui.VerticalPanel();
  mailsPanel.spacing = 4;
  mailsPanel.add(new ui.Button("Refresh"));
  return mailsPanel;
}

ui.VerticalPanel createFiltersItem(List<String> filters){
  ui.VerticalPanel filtersPanel = new ui.VerticalPanel();
  filtersPanel.spacing = 4;
  for (String filter in filters) {
    filtersPanel.add(new ui.CheckBox(filter));
  }
  return filtersPanel;
}

ui.VerticalPanel createContactsItem() {
  // Create a popup to show the contact info when a contact is clicked
  ui.VerticalPanel contactPopupContainer = new ui.VerticalPanel();
  contactPopupContainer.spacing = 5;
  String name = "contacts";
  contactPopupContainer.add(new ui.RadioButton(name, "Sergey", false));
  contactPopupContainer.add(new ui.RadioButton(name, "Lada", false));
  contactPopupContainer.add(new ui.RadioButton(name, "Alex", false));
  return contactPopupContainer;
}

void main6() {
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
