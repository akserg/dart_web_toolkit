//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

typedef void OnDomEventHandler(UiEvent event);

class DomEventHandler implements EventHandler {

  OnDomEventHandler onDomEventHandler;

  DomEventHandler(this.onDomEventHandler);
}
