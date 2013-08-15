//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of test_uibinder;

class LoginView extends ui.Composite {
  
  UiBinder<ui.FlowPanel, LoginView> binder = new UiBinder<ui.FlowPanel, LoginView>();
  
  @UiField
  ui.Label userLabel;
  
  @UiField
  ui.TextBox userInput;
  
  @UiField
  ui.Label passwordLabel;
  
  @UiField
  ui.TextBox passwordInput;
  
  @UiField
  ui.Button logonButton;
  
  LoginView(String template) {
    // load the template e.g. from service ...
    binder.template = template;

    // known from GWT UiBinder - initialize
    initWidget(binder.createAndBindUi(this));
    
    // Add validation to userInpput
    
    // Add Validation to passwordInput
    
    // Event handler for logonButton
    logonButton.addClickHandler(new event.ClickHandlerAdapter((event.ClickEvent evt){
      // Disable component until finish login process
      enableComponents(false);
    }));
  }
  
  void enableComponents(bool value) {
    userInput.enabled = value;
    passwordInput.enabled = value;
    logonButton.enabled = value;
  }
}