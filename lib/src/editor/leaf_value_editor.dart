//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_editor;

/**
 * Used to edit non-object or immutable values. The Editor framework will not
 * descend into a LeafValueEditor.
 *
 * @param <T> The type of primitive value
 * @see com.google.gwt.editor.client.adapters.SimpleEditor
 */
abstract class LeafValueEditor<T> implements Editor<T>, TakesValue<T> {

}
