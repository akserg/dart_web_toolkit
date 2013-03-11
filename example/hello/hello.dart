//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html' as dart_html;
import 'dart:math' as dart_math;
import 'dart:async' as dart_async;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/util.dart' as util;
import 'package:dart_web_toolkit/i18n.dart' as i18n;
import 'package:dart_web_toolkit/text.dart' as text;
import 'package:dart_web_toolkit/scheduler.dart' as scheduler;

// History managem,ent {
void main() {
  
  ui.Label lbl = new ui.Label();
  
  // Create three hyperlinks that change the application's history.
  ui.Hyperlink link0 = new ui.Hyperlink("link to foo", false, "foo");
  ui.Hyperlink link1 = new ui.Hyperlink("link to bar", false, "bar");
  ui.Hyperlink link2 = new ui.Hyperlink("link to baz", false, "baz");

  // If the application starts with no history token, redirect to a new
  // 'baz' state.
  String initToken = ui.History.getToken();
  if (initToken.length == 0) {
    ui.History.newItem("baz");
  }

  // Add widgets to the root panel.
  ui.VerticalPanel panel = new ui.VerticalPanel();
  panel.add(lbl);
  panel.add(link0);
  panel.add(link1);
  panel.add(link2);

  // Add history listener
  ui.History.addValueChangeHandler(new event.ValueChangeHandlerAdapter((event.ValueChangeEvent<String> evt){
    // This method is called whenever the application's history changes. Set
    // the label to reflect the current history token.
    lbl.text = "The current history token is: ${evt.value}";
  }));

  // Now that we've setup our listener, fire the initial history state.
  ui.History.fireCurrentHistoryState();
  
  ui.RootPanel.get().add(panel);
  
}
// Notification Mole
void main_46() {
  // This can be any panel that accepts children.
  ui.HasWidgets panel = ui.RootPanel.get("testId");
  ui.NotificationMole nm = new ui.NotificationMole();
  nm.setAnimationDuration(500);
  nm.title = "Title";
  nm.setHeight("100px");
  nm.setWidth("200px");
  nm.setMessage("Test message to be shown in mole");
  panel.add(nm);
  // Setup the NotificationMole...
  nm.show();
}

// MenuBar
void main_45() {

  // Create a command that will execute on menu item selection
  MenuCommand menuCommand = new MenuCommand();

  // Create a menu bar
  ui.MenuBar menu = new ui.MenuBar();
  menu.setAutoOpen(true);
  menu.setWidth("500px");
  menu.setAnimationEnabled(true);

  // Create a sub menu of recent documents
  ui.MenuBar recentDocsMenu = new ui.MenuBar(true);
  List<String> recentDocs = ["Fishing in the desert.txt", "How to tame a wild parrot", "Idiots Guide to Emu Farms"];
  for (int i = 0; i < recentDocs.length; i++) {
    recentDocsMenu.addTextItem(recentDocs[i], false, cmd:menuCommand);
  }

  // Create the file menu
  ui.MenuBar fileMenu = new ui.MenuBar(true);
  fileMenu.setAnimationEnabled(true);
  menu.addItem(new ui.MenuItem("File", false, subMenu:fileMenu));
  List<String> fileOptions = ["New", "Open", "Close", "Recent", "Exit"];
  for (int i = 0; i < fileOptions.length; i++) {
    if (i == 3) {
      fileMenu.addSeparator();
      fileMenu.addTextItem(fileOptions[i], false, popup:recentDocsMenu);
      fileMenu.addSeparator();
    } else {
      fileMenu.addTextItem(fileOptions[i], false, cmd:menuCommand);
    }
  }

  // Create the edit menu
  ui.MenuBar editMenu = new ui.MenuBar(true);
  menu.addItem(new ui.MenuItem("Edit", false, subMenu:editMenu));
  List<String> editOptions = ["Undo", "Redo", "Cut", "Copy", "Paste"];
  for (int i = 0; i < editOptions.length; i++) {
    editMenu.addTextItem(editOptions[i], false, cmd:menuCommand);
  }

  // Create the GWT menu
  ui.MenuBar gwtMenu = new ui.MenuBar(true);
  menu.addItem(new ui.MenuItem("GWT", true, subMenu:gwtMenu));
  List<String> gwtOptions = ["Download", "Examples", "Source Code", "GWT wit' the program"];
  for (int i = 0; i < gwtOptions.length; i++) {
    gwtMenu.addTextItem(gwtOptions[i], false, cmd:menuCommand);
  }

  // Create the help menu
  ui.MenuBar helpMenu = new ui.MenuBar(true);
  menu.addSeparator();
  menu.addItem(new ui.MenuItem("Help", true, subMenu:helpMenu));
  List<String> helpOptions = ["Contents", "Fortune Cookie", "About GWT"];
  for (int i = 0; i < helpOptions.length; i++) {
    helpMenu.addTextItem(helpOptions[i], false, cmd:menuCommand);
  }

  ui.RootPanel.get("testId").add(menu);
}

class MenuCommand implements scheduler.ScheduledCommand {
  int _curPhrase = 0;
  final List<String> phrases = ["Thank you for selecting a menu item", "A fine selection indeed", "Don't you have anything better to do than select menu items?", "Try something else", "this is just a menu!, Another wasted click"];

  void execute() {
    dart_html.window.alert(phrases[_curPhrase]);
    _curPhrase = (_curPhrase + 1) % phrases.length;
  }
}

void main_44() {
  // Create a static tree and a container to hold it
  ui.Tree staticTree = createStaticTree();
  staticTree.setAnimationEnabled(true);
  ui.ScrollPanel staticTreeWrapper = new ui.ScrollPanel(staticTree);
  staticTreeWrapper.setSize("300px", "300px");

  // Wrap the static tree in a DecoratorPanel
  ui.DecoratorPanel staticDecorator = new ui.DecoratorPanel();
  staticDecorator.setWidget(staticTreeWrapper);


  // Create a dynamically generated tree and a container to hold it
  ui.Tree dynamicTree = createDynamicTree();
  ui.ScrollPanel dynamicTreeWrapper = new ui.ScrollPanel(dynamicTree);
  dynamicTreeWrapper.setSize("300px", "300px");

  // Wrap the dynamic tree in a DecoratorPanel
  ui.DecoratorPanel dynamicDecorator = new ui.DecoratorPanel();
  dynamicDecorator.setWidget(dynamicTreeWrapper);


  // Combine trees onto the page
  ui.Grid grid = new ui.Grid(2, 3);
  grid.setCellPadding(2);
  grid.getRowFormatter().setVerticalAlign(1, i18n.HasVerticalAlignment.ALIGN_TOP);
  grid.setHtml(0, 0, "<b>Static Tree:</b>");
  grid.setHtml(0, 1, "   ");
  grid.setHtml(0, 2, "<b>Dynamic Tree:</b>");
  grid.setWidget(1, 0, staticDecorator);
  grid.setHtml(1, 1, "   ");
  grid.setWidget(1, 2, dynamicDecorator);

  ui.RootPanel.get("testId").add(grid);
}

/**
 * Create a static tree with some data in it.
*
 * @return the new tree
 */
ui.Tree createStaticTree() {
  // Create the tree
  List<String> composers = ["Beethoven", "Brahms", "Mozart"];
  String concertosLabel = "Concertos";
  String quartetsLabel = "Quartets";
  String sonatasLabel = "Sonatas";
  String symphoniesLabel = "Symphonies";
  ui.Tree staticTree = new ui.Tree();

  // Add some of Beethoven's music
  ui.TreeItem beethovenItem = staticTree.addTextItem(composers[0]);
  addMusicSection(beethovenItem, concertosLabel, ["No. 1 - C", "No. 2 - B-Flat Major", "No. 3 - C Minor", "No. 4 - G Major", "No. 5 - E-Flat Major"]);
  addMusicSection(beethovenItem, quartetsLabel, ["Six String Quartets", "Three String Quartets", "Grosse Fugue for String Quartets"]);
  addMusicSection(beethovenItem, sonatasLabel, ["Sonata in A Minor", "Sonata in F Major"]);
  addMusicSection(beethovenItem, symphoniesLabel, ["No. 2 - D Major", "No. 2 - D Major", "No. 3 - E-Flat Major", "No. 4 - B-Flat Major", "No. 5 - C Minor", "No. 6 - F Major", "No. 7 - A Major", "No. 8 - F Major", "No. 9 - D Minor"]);

  // Add some of Brahms's music
  ui.TreeItem brahmsItem = staticTree.addTextItem(composers[1]);
  addMusicSection(brahmsItem, concertosLabel, ["Violin Concerto", "Double Concerto - A Minor", "Piano Concerto No. 1 - D Minor", "Piano Concerto No. 2 - B-Flat Major"]);
  addMusicSection(brahmsItem, quartetsLabel, ["Piano Quartet No. 1 - G Minor", "Piano Quartet No. 2 - A Major", "Piano Quartet No. 3 - C Minor", "String Quartet No. 3 - B-Flat Minor"]);
  addMusicSection(brahmsItem, sonatasLabel, ["Two Sonatas for Clarinet - F Minor", "Two Sonatas for Clarinet - E-Flat Major"]);
  addMusicSection(brahmsItem, symphoniesLabel, ["No. 1 - C Minor", "No. 2 - D Minor", "No. 3 - F Major", "No. 4 - E Minor"]);

  // Add some of Mozart's music
  ui.TreeItem mozartItem = staticTree.addTextItem(composers[2]);
  addMusicSection(mozartItem, concertosLabel, ["Piano Concerto No. 12", "Piano Concerto No. 17", "Clarinet Concerto", "Violin Concerto No. 5", "Violin Concerto No. 4"]);

  // Return the tree
  return staticTree;
}

/**
 * Add a new section of music created by a specific composer.
*
 * @param parent the parent {@link TreeItem} where the section will be added
 * @param label the label of the new section of music
 * @param composerWorks an array of works created by the composer
 */
void addMusicSection(ui.TreeItem parent, String label, List<String> composerWorks) {
  ui.TreeItem section = parent.addTextItem(label);
  for (String work in composerWorks) {
    section.addTextItem(work);
  }
}

/**
 * Create a dynamic tree that will add a random number of children to each
 * node as it is clicked.
*
 * @return the new tree
 */
ui.Tree createDynamicTree() {
  // Create a new tree
  ui.Tree dynamicTree = new ui.Tree();

  // Add some default tree items
  for (int i = 0; i < 5; i++) {
    ui.TreeItem item = dynamicTree.addTextItem("Item $i");

    // Temporarily add an item so we can expand this node
    item.addTextItem("");
  }

  dart_math.Random random = new dart_math.Random(5);

  // Add a handler that automatically generates some children
  dynamicTree.addOpenHandler(new event.OpenHandlerAdapter((event.OpenEvent evt) {
    ui.TreeItem item = evt.getTarget();
    if (item.getChildCount() == 1) {
      // Close the item immediately
      item.setState(false, false);

      // Add a random number of children to the item
      String itemText = item.text;
      int numChildren = random.nextInt(5) + 2;
      for (int i = 0; i < numChildren; i++) {
        ui.TreeItem child = item.addTextItem(itemText.concat(".").concat(i.toString()));
        child.addTextItem("");
      }

      // Remove the temporary item when we finish loading
      item.getChild(0).remove();

      // Reopen the item
      item.setState(true, false);
    }
  }));

  // Return the tree
  return dynamicTree;
}

dart_html.Element _dragSourceEl;

// Port of DnD Basic example from [https://github.com/dart-lang/dart-html5-samples]
void main_43() {
  ui.FlowPanel columns = new ui.FlowPanel();
  columns.getElement().id = "columns";

  for (int i = 0; i < 3; i++) {
    ui.SimplePanel column = createDraggablePanel(i);
    columns.add(column);
  }

  ui.RootPanel.get("testId").add(columns);
}

/// Create DraggablePanel instance and add DnD handlers.
ui.SimplePanel createDraggablePanel(int i) {
  DraggablePanel column = new DraggablePanel();
  column.addStyleName("column");
  column.getElement().draggable = true;
  column.addDragStartHandler(new event.DragStartHandlerAdapter(_onDragStart));
  column.addDragEndHandler(new event.DragEndHandlerAdapter(_onDragEnd));
  column.addDragEnterHandler(new event.DragEnterHandlerAdapter(_onDragEnter));
  column.addDragOverHandler(new event.DragOverHandlerAdapter(_onDragOver));
  column.addDragLeaveHandler(new event.DragLeaveHandlerAdapter(_onDragLeave));
  column.addDropHandler(new event.DropHandlerAdapter(_onDrop));

  ui.Html header = new ui.Html("<header>${i.toString()}</header>");
  column.add(header);

  return column;
}

/// SimplePanel with DnD support
class DraggablePanel extends ui.SimplePanel implements event.HasAllDragAndDropHandlers {

  DraggablePanel() : super();

  event.HandlerRegistration addDragStartHandler(event.DragStartHandler handler) {
    return addBitlessDomHandler(handler, event.DragStartEvent.TYPE);
  }

  event.HandlerRegistration addDragHandler(event.DragHandler handler) {
    return addBitlessDomHandler(handler, event.DragEvent.TYPE);
  }

  event.HandlerRegistration addDragEndHandler(event.DragEndHandler handler) {
    return addBitlessDomHandler(handler, event.DragEndEvent.TYPE);
  }

  event.HandlerRegistration addDragEnterHandler(event.DragEnterHandler handler) {
    return addBitlessDomHandler(handler, event.DragEnterEvent.TYPE);
  }

  event.HandlerRegistration addDragOverHandler(event.DragOverHandler handler) {
    return addBitlessDomHandler(handler, event.DragOverEvent.TYPE);
  }

  event.HandlerRegistration addDragLeaveHandler(event.DragLeaveHandler handler) {
    return addBitlessDomHandler(handler, event.DragLeaveEvent.TYPE);
  }

  event.HandlerRegistration addDropHandler(event.DropHandler handler) {
    return addBitlessDomHandler(handler, event.DropEvent.TYPE);
  }
}


////*********************************
//// Drag and Drop callback functions
////*********************************

void _onDragStart(event.DragStartEvent evt){
  dart_html.Element dragTarget = evt.getNativeEvent().target;
  dragTarget.classes.add('moving');
  _dragSourceEl = dragTarget;
  evt.getDataTransfer().effectAllowed = 'move';
  evt.getDataTransfer().setData('text/html', dragTarget.innerHtml);
}

void _onDragEnd(event.DragEndEvent evt){
  dart_html.Element dragTarget = evt.getNativeEvent().target;
  dragTarget.classes.remove('moving');
  var cols = dart_html.document.queryAll('#columns .column');
  for (dart_html.Element col in cols) {
    col.classes.remove('over');
  }
}

void _onDragEnter(event.DragEnterEvent evt){
  dart_html.Element dropTarget = evt.getNativeEvent().target;
  dropTarget.classes.add('over');
}

void _onDragOver(event.DragOverEvent evt){
  // This is necessary to allow us to drop.
  evt.getNativeEvent().preventDefault();
  evt.getDataTransfer().dropEffect = 'move';
}

void _onDragLeave(event.DragLeaveEvent evt){
  dart_html.Element dropTarget = evt.getNativeEvent().target;
  dropTarget.classes.remove('over');
}

void _onDrop(event.DropEvent evt){
  // Stop the browser from redirecting.
  evt.getNativeEvent().stopPropagation();

  // Don't do anything if dropping onto the same column we're dragging.
  dart_html.Element dropTarget = evt.getNativeEvent().target;
  if (_dragSourceEl != dropTarget) {
    // Set the source column's HTML to the HTML of the column we dropped on.
    _dragSourceEl.innerHtml = dropTarget.innerHtml;
    dropTarget.innerHtml = evt.getDataTransfer().getData('text/html');
  }
}

// DialogBox
void main_42() {
  // Create the dialog box
  ui.DialogBox dialogBox = createDialogBox();
  dialogBox.setGlassEnabled(false);
  dialogBox.setAnimationEnabled(true);

  // Create a button to show the popup
  ui.Button openButton = new ui.Button("Show Basic Popup", new event.ClickHandlerAdapter((event.ClickEvent evt){
    dialogBox.show();
    dialogBox.center();
  }));
  ui.RootPanel.get("testId").add(openButton);

}

/**
 * Create the dialog box for this example.
*
 * @return the new dialog box
 */
ui.DialogBox createDialogBox() {
  // Create a dialog box and set the caption text
  ui.DialogBox dialogBox = new ui.DialogBox();
  dialogBox.text = "Sample DialogBox";

  // Create a table to layout the content
  ui.VerticalPanel dialogContents = new ui.VerticalPanel();
  dialogContents.spacing = 4;
  dialogBox.setWidget(dialogContents);

  // Add some text to the top of the dialog
  ui.Html details = new ui.Html("This is an example of a standard dialog box component.");
  dialogContents.add(details);
  dialogContents.setWidgetCellHorizontalAlignment(details, i18n.HasHorizontalAlignment.ALIGN_CENTER);

  // Add an image to the dialog
  ui.Image image = new ui.Image("img/lights.png");
  dialogContents.add(image);
  dialogContents.setWidgetCellHorizontalAlignment(image, i18n.HasHorizontalAlignment.ALIGN_CENTER);

  // Add a close button at the bottom of the dialog
  ui.Button closeButton = new ui.Button("Close", new event.ClickHandlerAdapter((event.ClickEvent evt){
    dialogBox.hide();
  }));
  dialogContents.add(closeButton);
  if (i18n.LocaleInfo.getCurrentLocale().isRTL()) {
    dialogContents.setWidgetCellHorizontalAlignment(closeButton, i18n.HasHorizontalAlignment.ALIGN_LEFT);
  } else {
    dialogContents.setWidgetCellHorizontalAlignment(closeButton, i18n.HasHorizontalAlignment.ALIGN_RIGHT);
  }

  // Return the dialog box
  return dialogBox;
}

// ValueListBox
void main_40() {

  ui.Grid grid = new ui.Grid(2, 2);
  grid.addStyleName("cw-FlexTable");

  ui.ValueListBox<Gender> lb = new ui.ValueListBox<Gender>(new GenderRenderer());
  lb.setAcceptableValues(Gender.GENDERS);
  ui.Label lb2 = new ui.Label();
  lb.addValueChangeHandler(new event.ValueChangeHandlerAdapter((event.ValueChangeEvent evt){
    lb2.text = evt.value.value;
  }));

  grid.setWidget(0, 0, new ui.Html("Gender:"));
  grid.setWidget(0, 1, lb);

  grid.setWidget(1, 0, new ui.Html("Selected:"));
  grid.setWidget(1, 1, lb2);

  ui.RootPanel.get("testId").add(grid);
}

/**
 * Gender Enum for the display property.
 */
class Gender<String> extends util.Enum<String> {

  const Gender(String type) : super (type);

  static const Gender MALE = const Gender("Mail");
  static const Gender FEMAIL = const Gender("Femail");

  static List<Gender> GENDERS = [Gender.MALE, Gender.FEMAIL];
}

/**
 * Gender Renderer
 */
class GenderRenderer implements text.Renderer<Gender> {

  /**
   * Renders {@code object} as plain text. Should never throw any exceptions!
   */
  String render(Gender object) {
    return object.value;
  }

  /**
   * Renders {@code object} as plain text, appended directly to {@code
   * appendable}. Should never throw any exceptions except if {@code appendable}
   * throws an {@code IOException}.
   */
  void renderTo(Gender object, text.Appendable appendable) {
    String s = render(object);
    appendable.append(s);
  }
}

// TabPanel
void main_39() {

  String text1 = "Lorem ipsum dolor sit amet...";
  String text2 = "Sed egestas, arcu nec accumsan...";
  String text3 = "Proin tristique, elit at blandit...";

  ui.TabPanel panel = new ui.TabPanel();
  ui.FlowPanel flowpanel;

  flowpanel = new ui.FlowPanel();
  flowpanel.add(new ui.Label(text1));
  panel.addTabText(flowpanel, "One");

  flowpanel = new ui.FlowPanel();
  flowpanel.add(new ui.Label(text2));
  panel.addTabText(flowpanel, "Two");

  flowpanel = new ui.FlowPanel();
  flowpanel.add(new ui.Label(text3));
  panel.addTabText(flowpanel, "Three");

  panel.selectTab(0);

  panel.setSize("500px", "250px");
  panel.addStyleName("table-center");

  ui.RootPanel.get("testId").add(panel);
}

//TabLayoutPanel
void main_38() {

  // Create a three-item tab panel, with the tab area 1.5em tall.
  ui.TabLayoutPanel tabPanel = new ui.TabLayoutPanel(1.5, util.Unit.EM);
  tabPanel.setAnimationDuration(1000);
  tabPanel.getElement().style.marginBottom = "10.0".concat(util.Unit.PX.value);

  tabPanel.add(new ui.Html("Home"), "[this]");
  tabPanel.add(new ui.Html("that"), "[that]");
  tabPanel.add(new ui.Html("the other"), "[the other]");

  // Attach the LayoutPanel to the RootLayoutPanel. The latter will listen for
  // resize events on the window to ensure that its children are informed of
  // possible size changes.
  ui.RootLayoutPanel.get().add(tabPanel);
}

// StackLayoutPanel
void main_37() {
  // Create a new stack layout panel.
  ui.StackLayoutPanel stackPanel = new ui.StackLayoutPanel(util.Unit.EM);
  //stackPanel.setPixelSize(200, 400);

  // Add the Mail folders.
  ui.Widget mailHeader = _createHeaderWidget("Mail");
  //stackPanel.addWidget(createMailItem(), mailHeader, 4);
  stackPanel.addWidget(_createMailItem(), "Mail", false, 4.0);

  // Add a list of filters.
  //ui.Widget filtersHeader = _createHeaderWidget("<b>Filters</b>");
//  //stackPanel.addWidget(createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), filtersHeader, 4);
  stackPanel.addWidget(_createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), "<b>Filters</b>", true, 4.0);

  // Add a list of contacts.
  ui.Widget contactsHeader = _createHeaderWidget("Contacts");
//  //stackPanel.add(createContactsItem(), contactsHeader, 4);
  stackPanel.addWidget(_createContactsItem(), "Contacts", false, 4.0);

  ui.RootLayoutPanel.get().add(stackPanel);
}

/**
 * Create a widget to display in the header that includes an image and some
 * text.
 *
 * @param text the header text
 * @param image the {@link ImageResource} to add next to the header
 * @return the header widget
 */
ui.Widget _createHeaderWidget(String text) {
  // Add the image and text to a horizontal panel
  ui.HorizontalPanel hPanel = new ui.HorizontalPanel();
  hPanel.setHeight("100%");
  hPanel.spacing = 0;
  hPanel.setVerticalAlignment(i18n.HasVerticalAlignment.ALIGN_MIDDLE);
  //hPanel.add(new Image(image));
  ui.Button headerText = new ui.Button(text);
  headerText.clearAndSetStyleName("cw-StackPanelHeader");
  hPanel.add(headerText);
  return new ui.SimplePanel(hPanel);
}

ui.VerticalPanel _createMailItem() {
  ui.VerticalPanel mailsPanel = new ui.VerticalPanel();
  mailsPanel.spacing = 4;
  mailsPanel.add(new ui.Button("Refresh"));
  return mailsPanel;
}

ui.VerticalPanel _createFiltersItem(List<String> filters){
  ui.VerticalPanel filtersPanel = new ui.VerticalPanel();
  filtersPanel.spacing = 4;
  for (String filter in filters) {
    filtersPanel.add(new ui.CheckBox(filter));
  }
  return filtersPanel;
}

ui.VerticalPanel _createContactsItem() {
  // Create a popup to show the contact info when a contact is clicked
  ui.VerticalPanel contactPopupContainer = new ui.VerticalPanel();
  contactPopupContainer.spacing = 5;
  String name = "contacts";
  contactPopupContainer.add(new ui.RadioButton(name, "Sergey", false));
  contactPopupContainer.add(new ui.RadioButton(name, "Lada", false));
  contactPopupContainer.add(new ui.RadioButton(name, "Alex", false));
  return contactPopupContainer;
}

// CaptionPanel
void main_36() {

  ui.CaptionPanel panel = new ui.CaptionPanel("Caption Goes Here");
  ui.RootPanel.get("testId").add(panel);

  panel.setContentWidget(new ui.Label("The main, wrapped widget goes here."));

  // Set up some style - normally you'd do this in CSS, but it's
  // easier to show like this

  event.Dom.setStyleAttribute(panel.getElement(), "border", "3px solid #00c");
  event.Dom.setStyleAttribute(panel.getContentWidget().getElement(), "margin", "5px 10px 10px 10px");
  event.Dom.setStyleAttribute(panel.getContentWidget().getElement(), "padding", "10px 10px 10px 10px");
  event.Dom.setStyleAttribute(panel.getContentWidget().getElement(), "border", "1px solid #ccf");
}

// Composite
void main_35() {
  DisplayBox displaybox = new DisplayBox("Header", "This is my data");
  ui.RootPanel.get("testId").add(displaybox);
}

class DisplayBox extends ui.Composite {

    DisplayBox(String header, String data) {
      ui.VerticalPanel widget = new ui.VerticalPanel();
      initWidget(widget);
      widget.addStyleName("demo-Composite");

      ui.Label headerText = new ui.Label(header);
      widget.add(headerText);
      headerText.addStyleName("demo-Composite-header");

      ui.Label dataText = new ui.Label(data);
      widget.add(dataText);
      dataText.addStyleName("demo-Composite-data");
    }
}

// ScrollPanel
void main_34() {

  ui.ScrollPanel panel = new ui.ScrollPanel(new ui.Html("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi sit amet massa ornare mauris lobortis laoreet. Pellentesque vel est at massa condimentum porta. Aliquam tincidunt scelerisque orci. Donec sit amet elit nec leo egestas vestibulum. Mauris et nibh quis ipsum volutpat congue. Ut tellus nibh, convallis sed, consectetuer sit amet, facilisis eget, lectus. Morbi hendrerit, dolor eget tincidunt tristique, velit enim laoreet erat, nec condimentum eros mi quis tellus. Fusce pharetra nibh vestibulum lacus. Integer vulputate eros at nisi. Phasellus elit quam, dignissim quis, volutpat vitae, egestas nec, nisi. Nullam sodales sagittis quam. Aliquam iaculis neque ut magna. Donec convallis interdum sem. Sed suscipit."));
  panel.setSize("200px", "120px");

  ui.RootPanel.get("testId").add(panel);
}

// DecoratedPopupPanel
void main_33() {
  // Create a basic popup widget
  ui.DecoratedPopupPanel simplePopup = new ui.DecoratedPopupPanel(true);
  simplePopup.setWidth("150px");
  //simplePopup.setGlassEnabled(true);
  simplePopup.setWidget(new ui.Html("Click anywhere outside this popup to make it disappear."));

  // Create a button to show the popup
  ui.Button openButton = new ui.Button("Show Basic Popup", new event.ClickHandlerAdapter((event.ClickEvent evt){
    // Reposition the popup relative to the button
    dart_html.ButtonElement source = evt.getSource();
    int left = source.offsetLeft + 10;
    int top = source.offsetTop + 10;
    simplePopup.setPopupPosition(left, top);

    // Show the popup
    simplePopup.show();
  }));
  ui.RootPanel.get("testId").add(openButton);
}

// PopupPanel
void main_32() {

  ui.PopupPanel imagePopup = new ui.PopupPanel(true);
  imagePopup.setAnimationEnabled(true);
  imagePopup.setWidget(new ui.Html("this is test"));

  imagePopup.center();
}

// FocusPanel
void main_31() {
  ui.FocusPanel panel = new ui.FocusPanel();
  panel.setSize("200px", "120px");
  panel.addStyleName("demo-panel-borderless");
  ui.Label label = new ui.Label("Label");
  label.setWidth("100px");
  label.addStyleName("demo-label");
  event.AllMouseHandlersAdapter allMouseHandlersAdapter = new event.AllMouseHandlersAdapter((event.MouseEvent evt){
    if (evt is event.MouseOverEvent) {
      label.addStyleName("demo-label-over");
    } else if (evt is event.MouseOutEvent) {
      label.removeStyleName("demo-label-over");
    }
  });
//  label.addMouseDownHandler(allMouseHandlersAdapter);
//  label.addMouseUpHandler(allMouseHandlersAdapter);
  label.addMouseOverHandler(allMouseHandlersAdapter);
  label.addMouseOutHandler(allMouseHandlersAdapter);
//  label.addMouseMoveHandler(allMouseHandlersAdapter);
//  label.addMouseWheelHandler(allMouseHandlersAdapter);

  panel.add(label);
  ui.RootPanel.get("testId").add(panel);
}

// DecoratorPanel
void main_30() {
  ui.FlexTable layout = new ui.FlexTable();
  layout.setCellSpacing(6);
  ui.FlexCellFormatter cellFormatter = layout.getFlexCellFormatter();

  // Add a title to the form
  layout.setHtml(0, 0, "Enter Search Criteria");
  cellFormatter.setColSpan(0, 0, 2);
  cellFormatter.setHorizontalAlignment(0, 0, i18n.HasHorizontalAlignment.ALIGN_CENTER);

  // Add some standard form options
  layout.setHtml(1, 0, "Name:");
  layout.setWidget(1, 1, new ui.TextBox());
  layout.setHtml(2, 0, "Description:");
  layout.setWidget(2, 1, new ui.TextBox());

  // Wrap the content in a DecoratorPanel
  ui.DecoratorPanel decPanel = new ui.DecoratorPanel();
  decPanel.setWidget(layout);

  ui.RootPanel.get("testId").add(decPanel);
}

// SimplePanel
void main_29() {
  ui.SimplePanel panel = new ui.SimplePanel();
  panel.setSize("200px", "120px");
  panel.addStyleName("demo-panel");

  ui.Label label = new ui.Label("Label");
  label.setWidth("100px");
  label.addStyleName("demo-label");
  panel.add(label);

  ui.RootPanel.get("testId").add(panel);
}

// Grid
void main_28() {

  // Create a grid
  ui.Grid grid = new ui.Grid(4, 4);
  grid.addStyleName("cw-FlexTable");

  // Add images to the grid
  int numRows = grid.getRowCount();
  int numColumns = grid.getColumnCount();
  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numColumns; col++) {
      grid.setWidget(row, col, new ui.Html("Cell $row.$col"));
    }
  }

  ui.RootPanel.get("testId").add(grid);
}

// FlexTable
void main_27() {
  ui.FlexTable flexTable = new ui.FlexTable();
  ui.FlexCellFormatter cellFormatter = flexTable.getFlexCellFormatter();
  flexTable.addStyleName("cw-FlexTable");
  flexTable.setWidth("32em");
  flexTable.setCellSpacing(5);
  flexTable.setCellPadding(3);

  // Add some text
  cellFormatter.setHorizontalAlignment(0, 1, i18n.HasHorizontalAlignment.ALIGN_LEFT);
  flexTable.setHtml(0, 0, "This is a FlexTable that supports <b>colspans</b> and <b>rowspans</b>. You can use it to format your page or as a special purpose table.");
  cellFormatter.setColSpan(0, 0, 2);

  // Add a button that will add more rows to the table
  ui.Button addRowButton = new ui.Button("Add", new event.ClickHandlerAdapter((event.ClickEvent evt){
    _addRow(flexTable);
  }));
  addRowButton.addStyleName("sc-FixedWidthButton");

  ui.Button removeRowButton = new ui.Button("Remove", new event.ClickHandlerAdapter((event.ClickEvent evt){
    _removeRow(flexTable);
  }));
  removeRowButton.addStyleName("sc-FixedWidthButton");

  ui.VerticalPanel buttonPanel = new ui.VerticalPanel();
  buttonPanel.clearAndSetStyleName("cw-FlexTable-buttonPanel");
  buttonPanel.add(addRowButton);
  buttonPanel.add(removeRowButton);
  flexTable.setWidget(0, 1, buttonPanel);
  cellFormatter.setVerticalAlignment(0, 1, i18n.HasVerticalAlignment.ALIGN_TOP);

  // Add two rows to start
  _addRow(flexTable);
  _addRow(flexTable);

  ui.RootPanel.get("testId").add(flexTable);
}

/**
 * Add a row to the flex table.
 */
void _addRow(ui.FlexTable flexTable) {
  int numRows = flexTable.getRowCount();
  flexTable.setWidget(numRows, 0, new ui.Html("Cell ${numRows}.0"));
  flexTable.setWidget(numRows, 1, new ui.Html("Cell ${numRows}.1"));
  flexTable.getFlexCellFormatter().setRowSpan(0, 1, numRows + 1);
}

/**
 * Remove a row from the flex table.
 */
void _removeRow(ui.FlexTable flexTable) {
  int numRows = flexTable.getRowCount();
  if (numRows > 1) {
    flexTable.removeRow(numRows - 1);
    flexTable.getFlexCellFormatter().setRowSpan(0, 1, numRows - 1);
  }
}

// HeaderPanel - Bug in Resizing
void main_26() {
//  ui.HeaderPanel headerPanel = new ui.HeaderPanel();
//  headerPanel.addStyleName("demo-panel");
//  headerPanel.setSize("150px", "100px");
//
//  ui.FlowPanel header = new ui.FlowPanel();
//  header.addStyleName(".header");
//  header.add(new ui.Label("This is the header"));
//  headerPanel.setHeaderWidget(header);
//
//  ui.ResizeLayoutPanel content = new ui.ResizeLayoutPanel();
//  content.addStyleName(".middle");
//  content.add(new ui.Label("This is the middle section"));
//  headerPanel.setContentWidget(content);
//
//  ui.FlowPanel footer = new ui.FlowPanel();
//  footer.addStyleName(".footer");
//  footer.add(new ui.Label("This is the footer"));
//  headerPanel.setFooterWidget(footer);
//
//  ui.RootPanel.get("testId").add(headerPanel);
}

// DecoratedStackPanel
void main_25() {
  ui.DecoratedStackPanel panel = new ui.DecoratedStackPanel();
  panel.setSize("400px", "200px");

  createStackPanelContent(panel, "Panel 1", "One");
  createStackPanelContent(panel, "Panel 2", "Two");
  createStackPanelContent(panel, "Panel 3", "Three");

  ui.RootPanel.get("testId").add(panel);
}

// CtackPanel
void main_24() {
  ui.StackPanel panel = new ui.StackPanel();
  panel.setSize("400px", "200px");

  createStackPanelContent(panel, "Panel 1", "One");
  createStackPanelContent(panel, "Panel 2", "Two");
  createStackPanelContent(panel, "Panel 3", "Three");

  ui.RootPanel.get("testId").add(panel);
}

void createStackPanelContent(ui.StackPanel panel, String text, String label, [bool asHtml = false]) {
  ui.Label content = new ui.Label(text);
  panel.add(content, label, asHtml);
}

//RootLayoutPanel
void main_23() {
  // Attach the LayoutPanel to the RootLayoutPanel. The latter will listen for
  // resize events on the window to ensure that its children are informed of
  // possible size changes.
  ui.RootLayoutPanel.get().add(new ui.Html("<div id='fred' style='background-color: yellow; border: 1px dotted red; width: 200px; text-align: center;'> This is an HTML Widget </div>"));
}

// Html Panel
void main_22() {

  String html = "<div id='one' style='border:3px dotted blue;'></div><div id='two' style='border:3px dotted green;'></div>";
  ui.HtmlPanel panel = new ui.HtmlPanel(html);
  panel.setSize("200px", "120px");
  //panel.addStyleName("demo-panel");
  panel.addById(new ui.Button("Do Nothing"), "one");
  panel.addById(new ui.TextBox(), "two");

  ui.RootPanel.get("testId").add(panel);
}

// FlowPanel
void main_21() {
  ui.FlowPanel flowPanel = new ui.FlowPanel();

  // Add some content to the panel
  for (int i = 0; i < 30; i++) {
    ui.CheckBox checkbox = new ui.CheckBox("Item $i");
    checkbox.addStyleName("cw-FlowPanel-checkBox");
    flowPanel.add(checkbox);
  }

  ui.RootPanel.get("testId").add(flowPanel);
}

// SplitLayoutPanel
void main_20() {
  ui.SplitLayoutPanel p = new ui.SplitLayoutPanel();
  p.addWest(new ui.Button("navigation"), 128.0);
  p.addNorth(new ui.Button("list"), 384.0);
  p.add(new ui.FileUpload());

  // Attach the SplitLayoutPanel to the RootLayoutPanel. The latter will listen for
  // resize events on the window to ensure that its children are informed of
  // possible size changes.
  ui.RootLayoutPanel.get().add(p);
}

// DockLayoutPanel
void main_19() {
  ui.DockLayoutPanel p = new ui.DockLayoutPanel(util.Unit.PX);
  p.addStyleName("demo-panel");

  p.addNorth(new ui.Html("<div style='background-color: #FF0000;'>north</div>"), 50.0);
  p.addSouth(new ui.Html("<div style='background-color: #00FF00;'>south</div>"), 100.0);
  p.addEast(new ui.Html("<div style='background-color: #0000FF;'>east</div>"), 150.0);
  p.addWest(new ui.Html("<div style='background-color: #FFFF00;'>west</div>"), 200.0);
  p.add(new ui.Html("<div style='background-color: #00FFFF;'>center</div>"));

  ui.RootLayoutPanel.get().add(p);
}

// DeckLayoutPanel
void main_18() {
  ui.DeckPanel panel = new ui.DeckPanel();
  panel.setSize("300px", "120px");
  panel.addStyleName("demo-panel");
  ui.Label label;

// This will get set to 100% wide and high
// and with a border will overflow the deck
  label = new ui.Label("Widget 0");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);

// Setting the height and width to "" will
// make the label act like an ordinary div
// in a div
  label = new ui.Label("Widget 1");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);
  label.setWidth("");
  label.setHeight("");

// So you have to set the width and height
// if you don't want them to be 100%. Normal
// defaults don't apply
  label = new ui.Label("Widget 2");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);
  label.setWidth("100px");
  label.setHeight("");

// Skip one, and you may get a surprise
  label = new ui.Label("Widget 3");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);
  label.setWidth("100px");

  ui.RootPanel.get("testId").add(panel);
  panel.showWidgetAt(0);

  util.Timer t = new util.Timer.get(()
  {
    int index = panel.getVisibleWidgetIndex();
    index++;
    if (index == panel.getWidgetCount()) {
      index = 0;
    }
    panel.showWidgetAt(index);
  });
  t.scheduleRepeating(1000);
}


// DeckLayoutPanel
void main_17() {
  ui.DeckLayoutPanel panel = new ui.DeckLayoutPanel();
  panel.setSize("300px", "120px");
  panel.addStyleName("demo-panel");
  ui.Label label;

// This will get set to 100% wide and high
// and with a border will overflow the deck
  label = new ui.Label("Widget 0");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);

// Setting the height and width to "" will
// make the label act like an ordinary div
// in a div
  label = new ui.Label("Widget 1");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);
  label.setWidth("");
  label.setHeight("");

// So you have to set the width and height
// if you don't want them to be 100%. Normal
// defaults don't apply
  label = new ui.Label("Widget 2");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);
  label.setWidth("100px");
  label.setHeight("");

// Skip one, and you may get a surprise
  label = new ui.Label("Widget 3");
  label.addStyleName("demo-label-bigborder");
  panel.add(label);
  label.setWidth("100px");

  ui.RootLayoutPanel.get().add(panel);
  panel.showWidgetAt(0);

  util.Timer t = new util.Timer.get(()
  {
    int index = panel.getVisibleWidgetIndex();
    index++;
    if (index == panel.getWidgetCount()) {
      index = 0;
    }
    panel.showWidgetAt(index);
  });
  t.scheduleRepeating(1000);
}

// Horizontal and Vertical Panels
void main_16() {
  ui.HorizontalPanel hPanel = new ui.HorizontalPanel();
  hPanel.spacing = 5;

  // Add some content to the panel
  for (int i = 1; i < 5; i++) {
    hPanel.add(new ui.Button("Button $i"));
  }
  ui.RootPanel.get("testId").add(hPanel);

  ui.VerticalPanel vPanel = new ui.VerticalPanel();
  vPanel.spacing = 5;

  // Add some content to the panel
  for (int i = 1; i < 10; i++) {
    vPanel.add(new ui.Button("Button $i"));
  }
  ui.RootPanel.get("testId").add(vPanel);
}

// DockPanel
void main_15() {
  ui.DockPanel dock = new ui.DockPanel();
  dock.clearAndSetStyleName("cw-DockPanel");
  dock.spacing = 4;
  dock.setHorizontalAlignment(i18n.HasHorizontalAlignment.ALIGN_CENTER);

  // Add text all around
  dock.addWidgetTo(new ui.Html("This is the first north component"), util.DockLayoutConstant.NORTH);
  dock.addWidgetTo(new ui.Html("This is the first south component"), util.DockLayoutConstant.SOUTH);
  dock.addWidgetTo(new ui.Html("This is the east component"), util.DockLayoutConstant.EAST);
  dock.addWidgetTo(new ui.Html("This is the west component"), util.DockLayoutConstant.WEST);
  dock.addWidgetTo(new ui.Html("This is the second north component"), util.DockLayoutConstant.NORTH);
  dock.addWidgetTo(new ui.Html("This is the second south component"),util.DockLayoutConstant.SOUTH);

  // Add scrollable text in the center
  ui.Html contents = new ui.Html("This is a ScrollPanel contained at the center of a DockPanel. By putting some fairly large contents in the middle and setting its size explicitly, it becomes a scrollable area within the page, but without requiring the use of an IFRAME./nHere's quite a bit more meaningless text that will serve primarily to make this thing scroll off the bottom of its visible area. Otherwise, you might have to make it really, really small in order to see the nifty scroll bars!");
  ui.ScrollPanel scroller = new ui.ScrollPanel(contents);
  scroller.setSize("400px", "100px");
  dock.addWidgetTo(scroller, util.DockLayoutConstant.CENTER);

  // Return the content
  ui.RootPanel.get("testId").add(dock);
}

// AbsolutePanel
void main_14() {
  ui.AbsolutePanel panel = new ui.AbsolutePanel();
  panel.setSize("200px", "120px");
  //panel.addStyleName("demo-panel");
  ui.Label label = new ui.Label("Label");
  label.setWidth("100px");
  //label.setStyleName("demo-label");
  panel.addInPosition(label, 50, 50);
  ui.RootPanel.get("testId").add(panel);
}

// DateLabel and NumberLabel
void main_13() {
  // Create a panel to layout the widgets
  ui.VerticalPanel vpanel1 = new ui.VerticalPanel();
  vpanel1.spacing = 5;

  ui.DateLabel dLabel = new ui.DateLabel();
  dLabel.setValue(new DateTime.now());
  vpanel1.add(dLabel);

  ui.NumberLabel nLabel = new ui.NumberLabel();
  nLabel.setValue(123.12);
  vpanel1.add(nLabel);

  ui.RootPanel.get("testId").add(vpanel1);
}

// Create Html
void main_12() {
  ui.Html html = new ui.Html("<div id='fred' style='background-color: yellow; border: 1px dotted red; width: 200px; text-align: center;'> This is an HTML Widget </div>");
  _addAllHandlers(html);
  ui.RootPanel.get("testId").add(html);

  ui.InlineHtml inlineHtml = new ui.InlineHtml("<div id='fred' style='background-color: red; border: 1px dotted green; width: 200px; text-align: center;'> This is an INLINE HTML Widget </div>");
  _addAllHandlers(inlineHtml);
  ui.RootPanel.get("testId").add(inlineHtml);

  ui.InlineLabel inlineLabel = new ui.InlineLabel("This is Inline Label");
  _addAllHandlers(inlineLabel);
  ui.RootPanel.get("testId").add(inlineLabel);
}

// Label
void main_11() {
  ui.Label label = new ui.Label("This is a Label");
  _addAllHandlers(label);
  ui.RootPanel.get("testId").add(label);
}

// Image
void main_10() {
  ui.Image image = new ui.Image("img/test.jpg");
  _addAllHandlers(image);
  ui.RootPanel.get("testId").add(image);
}

// Hyperlink
void main_09() {
  ui.Hyperlink widget = new ui.Hyperlink("Home Page", false, "Home");
  _addAllHandlers(widget);
  ui.SimplePanel panel = new ui.SimplePanel();
  panel.setSize("200px", "30px");
  //panel.addStyleName("demo-panel");
  panel.add(widget);
  ui.RootPanel.get("testId").add(panel);
}

// Frame
void main_08() {
  ui.Frame frame = new ui.Frame("frame_test.html");
  _addAllHandlers(frame);
  frame.setWidth("100%");
  frame.setHeight("450px");
  ui.RootPanel.get("testId").add(frame);
}

// SimpleCheckBox, SimpleRadioButton, TextArea, TextBox, PasswordTextBox,
// DoubleBox, IntegerBox
void main_07() {
  // Create a panel to layout the widgets
  ui.VerticalPanel vpanel1 = new ui.VerticalPanel();
  vpanel1.spacing = 5;

  ui.DoubleBox dBox = new ui.DoubleBox();
  _addAllHandlers(dBox);
  dBox.setMaxLength(10);
  dBox.setVisibleLength(5);
  dBox.setValue(123.4543453);
  vpanel1.add(dBox);

  ui.IntegerBox iBox = new ui.IntegerBox();
  _addAllHandlers(iBox);
  iBox.setMaxLength(10);
  iBox.setVisibleLength(5);
  iBox.setValue(123123);
  vpanel1.add(iBox);

  ui.SimpleCheckBox sCheckBox = new ui.SimpleCheckBox();
  _addAllHandlers(sCheckBox);
  sCheckBox.setValue(true);
  vpanel1.add(sCheckBox);

  ui.SimpleRadioButton rCheckBox1 = new ui.SimpleRadioButton("SimpleRadioButtonGroup");
  _addAllHandlers(rCheckBox1);
  rCheckBox1.setValue(true);
  vpanel1.add(rCheckBox1);

  ui.SimpleRadioButton rCheckBox2 = new ui.SimpleRadioButton("SimpleRadioButtonGroup");
  _addAllHandlers(rCheckBox2);
  vpanel1.add(rCheckBox2);

  ui.RootPanel.get("testId").add(vpanel1);

  // Create a panel to layout the widgets
  ui.VerticalPanel vpanel2 = new ui.VerticalPanel();
  vpanel2.spacing = 5;

  // Add a normal and disabled text box
  ui.TextBox normalText = new ui.TextBox();
  _addAllHandlers(normalText);
  // Set the normal text box to automatically adjust its direction according
  // to the input text. Use the Any-RTL heuristic, which sets an RTL direction
  // iff the text contains at least one RTL character.
  //normalText.setDirectionEstimator(AnyRtlDirectionEstimator.get());
  vpanel2.add(normalText);

  ui.TextBox disabledText = new ui.TextBox();
  disabledText.text = "read only"; //(constants.cwBasicTextReadOnly());
  disabledText.enabled = false;
  vpanel2.add(disabledText);

  // Add a normal and disabled password text box
  ui.PasswordTextBox normalPassword = new ui.PasswordTextBox();
  _addAllHandlers(normalPassword);
  ui.PasswordTextBox disabledPassword = new ui.PasswordTextBox();
  disabledPassword.text = "123456"; //constants.cwBasicTextReadOnly();
  disabledPassword.enabled = false;
  vpanel2.add(normalPassword);
  vpanel2.add(disabledPassword);

  // Add a text area
  ui.TextArea textArea = new ui.TextArea();
  _addAllHandlers(textArea);
  textArea.setVisibleLines(5);
  vpanel2.add(textArea);

  ui.RootPanel.get("testId").add(vpanel2);
}

// ListBox
void main_06() {

  List<String> listTypes = ["Car Type", "Sport", "City"];

  // Create a panel to align the Widgets
  ui.HorizontalPanel hPanel = new ui.HorizontalPanel();
  hPanel.spacing = 20;

  // Add a drop box with the list types
  ui.ListBox dropBox = new ui.ListBox();
  //List<String> listTypes = constants.cwListBoxCategories();
  for (int i = 0; i < listTypes.length; i++) {
    dropBox.addItem(listTypes[i]);
  }
  ui.VerticalPanel dropBoxPanel = new ui.VerticalPanel();
  dropBoxPanel.spacing = 4;
  //dropBoxPanel.add(new HTML(constants.cwListBoxSelectCategory()));
  dropBoxPanel.add(dropBox);
  hPanel.add(dropBoxPanel);

  // Add a list box with multiple selection enabled
  ui.ListBox multiBox = new ui.ListBox(true);
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
  dropBox.addChangeHandler(new event.ChangeHandlerAdapter((event.ChangeEvent event){
    showCategory(multiBox, dropBox.getSelectedIndex());
  }));

  // Show default category
  showCategory(multiBox, 0);

  ui.RootPanel.get("testId").add(hPanel);
}

/**
 * Display the options for a given category in the list box.
*
 * @param listBox the ListBox to add the options to
 * @param category the category index
 */
void showCategory(ui.ListBox listBox, int category) {
  listBox.clear();
  List<String> listData = null;
  switch (category) {
    case 0:
      listData = ["compact", "sedan", "coupe", "convertable", "SUV", "truck"];
      break;
    case 1:
      listData = ["Baseball", "Basketball", "Footbal"];
      break;
    case 2:
      listData = ["Paris", "London"];
      break;
  }
  for (int i = 0; i < listData.length; i++) {
    listBox.addItem(listData[i]);
  }
}

// PushButton and ToggleButtons
void main_05() {
  ui.VerticalPanel vpanel = new ui.VerticalPanel();

  ui.HorizontalPanel pushPanel = new ui.HorizontalPanel();
  pushPanel.spacing = 10;

  ui.HorizontalPanel togglePanel = new ui.HorizontalPanel();
  togglePanel.spacing = 10;

  // Combine all the panels
  vpanel.add(new ui.Html("Custom Button"));
  vpanel.add(pushPanel);
  vpanel.add(new ui.Html("<br><br>PushButtons and ToggleButtons allow you to customize the look of your buttons"));
  vpanel.add(togglePanel);

  ui.PushButton normalPushButton = new ui.PushButton.fromImage(new ui.Image("img/test.jpg"));
  _addAllHandlers(normalPushButton);
  pushPanel.add(normalPushButton);

  // Add a disabled PushButton
  ui.PushButton disabledPushButton = new ui.PushButton.fromImage(new ui.Image("img/test.jpg"));
  disabledPushButton.enabled = false;
  pushPanel.add(disabledPushButton);

// Add a normal ToggleButton
  ui.ToggleButton normalToggleButton = new ui.ToggleButton.fromImage(new ui.Image("img/test.jpg"));
  _addAllHandlers(normalToggleButton);
  togglePanel.add(normalToggleButton);

  // Add a disabled ToggleButton
  ui.ToggleButton disabledToggleButton = new ui.ToggleButton.fromImage(new ui.Image("img/test.jpg"));
  disabledToggleButton.enabled = false;
  togglePanel.add(disabledToggleButton);

  ui.RootPanel.get("testId").add(vpanel);
}

// RadioButton
void main_04() {
  ui.RadioButton radioButton = new ui.RadioButton("radio_test", "<b>Hi RadioButton 1</b>", true);
  radioButton.getElement().id = "One";
  _addAllHandlers(radioButton);
  ui.RootPanel.get("testId").add(radioButton);

  radioButton = new ui.RadioButton("radio_test", "<b>Hi RadioButton 2</b>", true);
  radioButton.getElement().id = "Two";
  _addAllHandlers(radioButton);
  ui.RootPanel.get("testId").add(radioButton);

  radioButton = new ui.RadioButton("radio_test", "<b>Hi RadioButton 3</b>", true);
  radioButton.getElement().id = "Three";
  _addAllHandlers(radioButton);
  ui.RootPanel.get("testId").add(radioButton);
}

// CheckBox
void main_03() {
  ui.CheckBox checkBox = new ui.CheckBox("<b>Hi CheckBox</b>", true);

  _addAllHandlers(checkBox);

  ui.RootPanel.get("testId").add(checkBox);
}

// Button
void main_02() {
  ui.Button button = new ui.Button("<b>Hi Button</b>");

  _addAllHandlers(button);

  ui.RootPanel.get("testId").add(button);
}

// Anchor
void main_01() {
  ui.Anchor anchor = new ui.Anchor(true);
  anchor.html = "<b>Hi Anchor</b>";

  _addAllHandlers(anchor);

  ui.RootPanel.get("testId").add(anchor);

}

void _addAllHandlers(ui.Widget widget) {
  if (widget is event.HasClickHandlers) {
    widget.addClickHandler(new event.ClickHandlerAdapter(_print));
  }
  if (widget is event.HasDoubleClickHandlers) {
    widget.addDoubleClickHandler(new event.DoubleClickHandlerAdapter(_print));
  }
  if (widget is event.HasAllFocusHandlers) {
    widget.addFocusHandler(new event.FocusHandlerAdapter(_print));
    widget.addBlurHandler(new event.BlurHandlerAdapter(_print));
  }
  if (widget is event.HasAllMouseHandlers) {
    widget.addMouseDownHandler(new event.MouseDownHandlerAdapter(_print));
    widget.addMouseUpHandler(new event.MouseUpHandlerAdapter(_print));
    widget.addMouseOutHandler(new event.MouseOutHandlerAdapter(_print));
    widget.addMouseOverHandler(new event.MouseOverHandlerAdapter(_print));
    widget.addMouseMoveHandler(new event.MouseMoveHandlerAdapter(_print));
    widget.addMouseWheelHandler(new event.MouseWheelHandlerAdapter(_print));
  }
  if (widget is event.HasAllKeyHandlers) {
    widget.addKeyUpHandler(new event.KeyUpHandlerAdapter(_print));
    widget.addKeyDownHandler(new event.KeyDownHandlerAdapter(_print));
    widget.addKeyPressHandler(new event.KeyPressHandlerAdapter(_print));
  }
  // HasAllDragAndDropHandlers, HasAllGestureHandlers, HasAllTouchHandlers
  if (widget is event.HasValueChangeHandlers) {
    widget.addValueChangeHandler(new event.ValueChangeHandlerAdapter(_print));
  }
  //
  if (widget is event.HasLoadHandlers) {
    widget.addLoadHandler(new event.LoadHandlerAdapter(_print));
  }
}

void _print(event.DwtEvent evt) {
  if (evt is event.DomEvent) {
    print("Source: ${evt.getRelativeElement().toString()} Event: ${evt.getNativeEvent().type} ID: ${evt.getRelativeElement().id != null ? evt.getRelativeElement().id : ''}");
  } else {
    if (evt.getSource() is dart_html.Element && (evt.getSource() as dart_html.Element).id != null) {
      print("Source: ${evt.getSource()} Event: ${evt.toString()} ID: ${(evt.getSource() as dart_html.Element).id}");
    } else {
      print("Source: ${evt.getSource()} Event: ${evt.toString()}");
    }
  }
}