//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

typedef void OnDwtEventHandler(DwtEvent event);

class DwtEventHandler implements EventHandler {

  OnDwtEventHandler onDwtEventHandler;

  DwtEventHandler(this.onDwtEventHandler);
}
