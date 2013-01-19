//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_editor;

/**
 * Describes an editor whose behavior is not altered by the value being
 * displayed.
 * <p>
 * Editors, which may be classes or interfaces, may expose their sub-editors in
 * one or more of the following ways:
 * <ul>
 * <li>An instance field with at least package visibility whose name exactly is
 * the property that will be edited or <code><em>propertyName</em>Editor</code>.
 * </li>
 * <li>A no-arg method with at least package visibility whose name exactly is
 * the property that will be edited or <code><em>propertyName</em>Editor</code>.
 * </li>
 * <li>The {@link Path} annotation may be used on the field or accessor method
 * to specify a dotted path or to bypass the implicit naming convention.</li>
 * <li>Sub-Editors may be null. In this case, the Editor framework will ignore
 * these sub-editors.</li>
 * </ul>
 * Any exposed field or method whose type is Editor may also use the
 * {@link IsEditor} interface to provide an Editor instance. This allows view
 * objects to be written that can be attached to an Editor hierarchy without the
 * view directly implementing an Editor interface.
 *
 * @param <T> the type of object the editor displays.
 */
abstract class Editor<T> {

}
