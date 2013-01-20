//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html' as dart_html;

import 'package:dart_web_toolkit/event.dart' as event;
import 'package:dart_web_toolkit/ui.dart' as ui;
import 'package:dart_web_toolkit/util.dart' as util;
import 'package:dart_web_toolkit/i18n.dart' as i18n;

dart_html.Element _dragSourceEl;

void main30() {

  //*********************************************************************************
  // Port of DnD Basic example from [https://github.com/dart-lang/dart-html5-samples]
  //*********************************************************************************

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


void main29() {

  ui.Button btn = new ui.Button("Test");
  // Click
  event.HandlerRegistration handlerRegistration;
  handlerRegistration = btn.addClickHandler(new event.ClickHandlerAdapter((event.ClickEvent evt){
    print("Clicked");
    handlerRegistration.removeHandler();
  }));
  // Double click
  btn.addDoubleClickHandler(new event.DoubleClickHandlerAdapter((event.DoubleClickEvent evt){
    print("Double Clicked");
  }));
  // Focus
  btn.addFocusHandler(new event.FocusHandlerAdapter((event.FocusEvent evt){
    print("Focus");
  }));
  // Blur
  btn.addBlurHandler(new event.BlurHandlerAdapter((event.BlurEvent evt){
    print("Blur");
  }));
  ui.RootPanel.get("testId").add(btn);

  ui.TextBox normalText = new ui.TextBox();
  // Key down
  normalText.addKeyDownHandler(new event.KeyDownHandlerAdapter((event.KeyDownEvent evt){
    print("Key down: ${evt.getNativeKeyCode()}");
  }));
  // Key up
  normalText.addKeyUpHandler(new event.KeyUpHandlerAdapter((event.KeyUpEvent evt){
    print("Key up: ${evt.getNativeKeyCode()}");
  }));
  // Key press
  normalText.addKeyPressHandler(new event.KeyPressHandlerAdapter((event.KeyPressEvent evt){
    print("Key press: ${evt.getUnicodeCharCode()}");
  }));
  // Mouse down
  normalText.addMouseDownHandler(new event.MouseDownHandlerAdapter((event.MouseDownEvent evt){
    print("Mouse down: ${evt.getClientX()} x ${evt.getClientY()}");
  }));
  // Mouse up
  normalText.addMouseUpHandler(new event.MouseUpHandlerAdapter((event.MouseUpEvent evt){
    print("Mouse up: ${evt.getClientX()} x ${evt.getClientY()}");
  }));
  // Mouse move
  normalText.addMouseMoveHandler(new event.MouseMoveHandlerAdapter((event.MouseMoveEvent evt){
    print("Mouse move: ${evt.getClientX()} x ${evt.getClientY()}");
  }));
  // Mouse out
  normalText.addMouseOutHandler(new event.MouseOutHandlerAdapter((event.MouseOutEvent evt){
    print("Mouse out");
  }));
  // Mouse over
  normalText.addMouseOverHandler(new event.MouseOverHandlerAdapter((event.MouseOverEvent evt){
    print("Mouse over");
  }));
  // Mouse move
  normalText.addMouseWheelHandler(new event.MouseWheelHandlerAdapter((event.MouseWheelEvent evt){
    print("Mouse wheel: ${evt.getClientX()} x ${evt.getClientY()} x ${evt.getDeltaY()}");
  }));
  ui.RootPanel.get("testId").add(normalText);
}

void main28() {
  ui.Frame frame = new ui.Frame("frame_test.html");
  frame.setWidth("100%");
  frame.setHeight("450px");
  ui.RootPanel.get("testId").add(frame);
}

void main27() {
  // Create the dialog box
  ui.DialogBox dialogBox = createDialogBox();
  dialogBox.setGlassEnabled(true);
  dialogBox.setAnimationEnabled(true);

  dialogBox.center();
  dialogBox.show();

}

/**
 * Create the dialog box for this example.
*
 * @return the new dialog box
 */
ui.DialogBox createDialogBox() {
  // Create a dialog box and set the caption text
  ui.DialogBox dialogBox = new ui.DialogBox();
  //dialogBox.ensureDebugId("cwDialogBox");
  dialogBox.text = "Sample DialogBox"; //(constants.cwDialogBoxCaption());

  // Create a table to layout the content
  ui.VerticalPanel dialogContents = new ui.VerticalPanel();
  dialogContents.spacing = 4;
  dialogBox.setWidget(dialogContents);

  // Add some text to the top of the dialog
  ui.Html details = new ui.Html("This is an example of a standard dialog box component."); //constants.cwDialogBoxDetails());
  dialogContents.add(details);
  dialogContents.setWidgetCellHorizontalAlignment(details, i18n.HasHorizontalAlignment.ALIGN_CENTER);

  // Add an image to the dialog
  ui.Image image = new ui.Image("img/lights.png"); //Showcase.images.jimmy());
  dialogContents.add(image);
  dialogContents.setWidgetCellHorizontalAlignment(image, i18n.HasHorizontalAlignment.ALIGN_CENTER);

  // Add a close button at the bottom of the dialog
  ui.Button closeButton = new ui.Button("Close");
//      constants.cwDialogBoxClose(), new ClickHandler() {
//        public void onClick(ClickEvent event) {
//          dialogBox.hide();
//        }
//      });
  dialogContents.add(closeButton);
  if (i18n.LocaleInfo.getCurrentLocale().isRTL()) {
    dialogContents.setWidgetCellHorizontalAlignment(closeButton, i18n.HasHorizontalAlignment.ALIGN_LEFT);

  } else {
    dialogContents.setWidgetCellHorizontalAlignment(closeButton, i18n.HasHorizontalAlignment.ALIGN_RIGHT);
  }

  // Return the dialog box
  return dialogBox;
}

void main26() {
  ui.DecoratedPopupPanel simplePopup = new ui.DecoratedPopupPanel(true);
  simplePopup.setWidth("150px");
  simplePopup.setWidget(new ui.Html("Click anywhere outside this popup to make it disappear."));

  // Create a button to show the popup
  simplePopup.setPopupPosition(20, 30);
  // Show the popup
  simplePopup.show();
}

void main25() {

  ui.TabPanel panel = new ui.TabPanel();
  panel.setSize("500px", "250px");

  // Add a home tab
  ui.Html homeText = new ui.Html("Click one of the tabs to see more content.");
  panel.addTabText(homeText, "Home");

  // Add a tab with an image
  ui.SimplePanel imageContainer = new ui.SimplePanel();
  imageContainer.setWidget(new ui.Image("img/test.jpg"));
  panel.addTabText(imageContainer, "DWT Logo");

  // Add a tab
  ui.Html moreInfo = new ui.Html("Tabs are highly customizable using CSS.");
  panel.addTabText(moreInfo, "More Info");

  panel.selectTab(0);

  ui.RootPanel.get("testId").add(panel);
}

void main24() {

  ui.PopupPanel imagePopup = new ui.PopupPanel(true);
  //imagePopup.setAnimationEnabled(true);
  imagePopup.setWidget(new ui.Html("this is test"));

  imagePopup.center();
}

void main22() {

  String lorem = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi sit amet massa ornare mauris lobortis laoreet. Pellentesque vel est at massa condimentum porta. Aliquam tincidunt scelerisque orci. Donec sit amet elit nec leo egestas vestibulum. Mauris et nibh quis ipsum volutpat congue. Ut tellus nibh, convallis sed, consectetuer sit amet, facilisis eget, lectus. Morbi hendrerit, dolor eget tincidunt tristique, velit enim laoreet erat, nec condimentum eros mi quis tellus. Fusce pharetra nibh vestibulum lacus. Integer vulputate eros at nisi. Phasellus elit quam, dignissim quis, volutpat vitae, egestas nec, nisi. Nullam sodales sagittis quam. Aliquam iaculis neque ut magna. Donec convallis interdum sem. Sed suscipit.";

  ui.ScrollPanel panel = new ui.ScrollPanel(new ui.Html(lorem));
  panel.setSize("200px", "120px");

  ui.RootPanel.get("testId").add(panel);
}

void main21() {

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

void main20() {
  // Create a Flex Table
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
  ui.Button addRowButton = new ui.Button("Add");
  addRowButton.addStyleName("sc-FixedWidthButton");

  ui.Button removeRowButton = new ui.Button("Remove");
  removeRowButton.addStyleName("sc-FixedWidthButton");

  ui.VerticalPanel buttonPanel = new ui.VerticalPanel();
  buttonPanel.clearAndSetStyleName("cw-FlexTable-buttonPanel");
  buttonPanel.add(addRowButton);
  buttonPanel.add(removeRowButton);
  flexTable.setWidget(0, 1, buttonPanel);
  cellFormatter.setVerticalAlignment(0, 1, i18n.HasVerticalAlignment.ALIGN_TOP);

  // Add two rows to start
  addRow(flexTable);
  addRow(flexTable);

  ui.RootPanel.get("testId").add(flexTable);
}

/**
 * Add a row to the flex table.
 */
void addRow(ui.FlexTable flexTable) {
  int numRows = flexTable.getRowCount();
  flexTable.setWidget(numRows, 0, new ui.Html("Cell ${numRows}.0"));
  flexTable.setWidget(numRows, 1, new ui.Html("Cell ${numRows}.1"));
  flexTable.getFlexCellFormatter().setRowSpan(0, 1, numRows + 1);
}

/**
 * Remove a row from the flex table.
 */
void removeRow(ui.FlexTable flexTable) {
  int numRows = flexTable.getRowCount();
  if (numRows > 1) {
    flexTable.removeRow(numRows - 1);
    flexTable.getFlexCellFormatter().setRowSpan(0, 1, numRows - 1);
  }
}

void main19() {

  ui.DeckPanel dPanel = new ui.DeckPanel();
  dPanel.setSize("300px", "120px");

  dPanel.add(new ui.Html("Panel 1"));
  dPanel.add(new ui.Html("Panel 2"));
  dPanel.showWidgetAt(1);

  ui.RootPanel.get("testId").add(dPanel);
}

void main18() {

  // Create a three-item tab panel, with the tab area 1.5em tall.
  ui.TabLayoutPanel p = new ui.TabLayoutPanel(1.5, util.Unit.EM);
  p.add(new ui.Html("this"), "[this]");
  p.add(new ui.Html("that"), "[that]");
  p.add(new ui.Html("the other"), "[the other]");

  // Attach the LayoutPanel to the RootLayoutPanel. The latter will listen for
  // resize events on the window to ensure that its children are informed of
  // possible size changes.
  ui.RootLayoutPanel.get().add(p);
}

void main17() {

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

void main16() {

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
  event.Dom.setStyleAttribute(label.getElement(), "border", "1px solid #00f");
  event.Dom.setStyleAttribute(label.getElement(), "backgroundColor", "blue");
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
  ui.Widget mailHeader = createHeaderWidget("Mail");
  //stackPanel.addWidget(createMailItem(), mailHeader, 4);
  stackPanel.addWidget(createMailItem(), "Mail", false, 4.0);

  // Add a list of filters.
  //ui.Widget filtersHeader = createHeaderWidget("<b>Filters</b>");
//  //stackPanel.addWidget(createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), filtersHeader, 4);
  stackPanel.addWidget(createFiltersItem(["All", "Starred", "Read", "Unread", "Recent", "Sent by me"]), "<b>Filters</b>", true, 4.0);

  // Add a list of contacts.
  ui.Widget contactsHeader = createHeaderWidget("Contacts");
//  //stackPanel.add(createContactsItem(), contactsHeader, 4);
  stackPanel.addWidget(createContactsItem(), "Contacts", false, 4.0);

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
  hPanel.setVerticalAlignment(i18n.HasVerticalAlignment.ALIGN_MIDDLE);
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
  event.HandlerRegistration handlerRegistration;
  handlerRegistration = anchor.addClickHandler(new event.ClickHandlerAdapter((event.ClickEvent evt){
    dart_html.UIEvent uiEvent = evt.getNativeEvent();
    print("Event: ${uiEvent.type}");
    //
    handlerRegistration.removeHandler();
  }));

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
  ui.CheckBox check = new ui.CheckBox("Active Footer");
  check.addValueChangeHandler(new event.ValueChangeHandlerAdapter<bool>((event.ValueChangeEvent evt){
    print("CheckBox value: ${evt.value}");
  }));
  headerPanel.setFooterWidget(check);
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

//*******************************
//*******************************
//*******************************

// CustomButton
void main() {
  ui.CustomButton customButton = new ui.CustomButton.fromText("Button", handler:new event.ClickHandlerAdapter((event.ClickEvent evt){
    print("$evt");
  }));
  
  ui.RootPanel.get("testId").add(customButton);
}

// RadioButton
void main04() {
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
void main03() {
  ui.CheckBox checkBox = new ui.CheckBox("<b>Hi CheckBox</b>", true);

  _addAllHandlers(checkBox);

  ui.RootPanel.get("testId").add(checkBox);
}

// Button
void main02() {
  ui.Button button = new ui.Button("<b>Hi Button</b>");

  _addAllHandlers(button);

  ui.RootPanel.get("testId").add(button);
}

// Anchor
void main01() {
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