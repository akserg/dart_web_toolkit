//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

typedef void EventHandlerAdapterCallback(DwtEvent event);

class EventHandlerAdapter implements EventHandler {

  EventHandlerAdapterCallback callback;

  EventHandlerAdapter(this.callback);

}
