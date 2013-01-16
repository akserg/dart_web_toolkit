//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_event;

/**
 * This is a convenience interface that includes all drag and drop handlers
 * defined by the core GWT system.
 *
 * <p>
 * <span style="color:red">Experimental API: This API is still under development
 * and is subject to change.
 * </span>
 * </p>
 */
abstract class HasAllDragAndDropHandlers implements HasDragEndHandlers,
  HasDragEnterHandlers, HasDragLeaveHandlers, HasDragHandlers,
  HasDragOverHandlers, HasDragStartHandlers, HasDropHandlers {

}
