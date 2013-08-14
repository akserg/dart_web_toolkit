//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of test_uibinder;


class NameLookup extends ui.Composite {

  @UiTemplate("template/name_lookup.html")
  UiBinder<ui.HtmlPanel, NameLookup> uiBinder = new UiBinder<ui.HtmlPanel, NameLookup>();

  @UiField ui.ListBox listBox;

  NameLookup(List<String> names) {
    
    initWidget(uiBinder.createAndBindUi(this));
    //
    for (String name in names) {
      listBox.addItem(name);
    }
  }
}