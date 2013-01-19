//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_editor;

/**
 * Extended by view objects that wish to participate in an Editor hierarchy, but
 * that do not implement the {@link Editor} contract directly. The primary
 * advantage of the IsEditor interface is that is allows composition of behavior
 * without the need to implement delegate methods for every interface
 * implemented by the common editor logic.
 * <p>
 * For example, an editor Widget that supports adding and removing elements from
 * a list might wish to re-use the provided
 * {@link com.google.gwt.editor.client.adapters.ListEditor ListEditor}
 * controller. It might be roughly built as:
 *
 * <pre>
 * class MyListEditor extends Composite implements IsEditor&lt;ListEditor&lt;Foo, FooEditor>> {
 *   private ListEditor&lt;Foo, FooEditor> controller = ListEditor.of(new FooEditorSource());
 *   public ListEditor&lt;Foo, FooEditor> asEditor() {return controller;}
 *   void onAddButtonClicked() { controller.getList().add(new Foo()); }
 *   void onClearButtonClicked() { controller.getList().clear(); }
 * }
 * </pre>
 * By implementing only the one <code>asEditor()</code> method, the
 * <code>MyListEditor</code> type is able to incorporate the
 * <code>ListEditor</code> behavior without needing to write delegate methods
 * for every method in <code>ListEditor</code>.
 * <p>
 * It is legal for a type to implement both Editor and IsEditor. In this case,
 * the Editor returned from {@link #asEditor()} will be a co-Editor of the
 * IsEditor instance.
 *
 * @param <E> the type of Editor the view object will provide
 * @see CompositeEditor
 */
abstract class IsEditor<E> {

}
