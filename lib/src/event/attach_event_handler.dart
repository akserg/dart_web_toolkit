//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * Implemented by objects that handle {@link AttachEvent}.
 */
abstract class AttachEventHandler extends EventHandler {
  void onAttachOrDetach(AttachEvent event);
}