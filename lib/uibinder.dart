//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Dart Web Toolkit UiBinder library.
 */
library uibinder;

import 'dart:html';
import 'dart:mirrors';
import 'ui.dart';

part 'src/uibinder/ui_binder.dart';

///**
// * Mark a method as the appropriate way to add a child widget to the parent
// * class.
// * 
// * <p>
// * The limit attribute specifies the number of times the function can be safely
// * called. If no limit is specified, it is assumed to be unlimited. Only one
// * child is permitted under each custom tag specified so the limit represents
// * the number of times the tag can be present in any object.
// * 
// * <p>
// * The tagname attribute indicates the name of the tag this method will handle
// * in the {@link UiBinder} template. If none is specified, the method name must
// * begin with "add", and the tag is assumed to be the remaining characters
// * (after the "add" prefix") entirely in lowercase.
// * 
// * <p>
// * For example, <code>
// * 
// * &#064;UiChild MyWidget#addCustomChild(Widget w) </code> and
// * 
// * <pre>
// *   &lt;p:MyWidget>
// *     &lt;p:customchild>
// *       &lt;g:SomeWidget />
// *     &lt;/p:customchild>
// *   &lt;/p:MyWidget>
// * </pre> 
// * would invoke the <code>addCustomChild</code> function to add an instance of
// * SomeWidget.
// */
//class UiChild {
//
//  final int limit;
//
//  final String tagname;
//  
//  const UiChild([this.tagname = "", this.limit = -1]);
//}
//
//
///**
// * Marks a constructor that may be used as an alternative to a widget's
// * zero args construtor in a [UiBinder] template. The parameter names
// * of the constructor may be filled as xml element attribute values.
// */
//class UiConstructor {}
//
///**
// * Marks a method that may be called as an alternative to a GWT.create call in a
// * [UiBinder] template. The parameter names of the method are treated
// * as required xml element attribute values.
// * <p>
// * It is an error to apply this annotation to more than one method of a given
// * return type.
// */
//class UiFactory {
//  const UiFactory();
//}

const UiField = const _UiField();

/**
 * Marks fields in a UiBinder client that must be filled by the binder's
 * [UiBinder#createAndBindUi] method. If provided is true the field
 * creation is delegated to the client (owner).
 */
class _UiField {
//  /**
//   * If true, the field must be filled before {@link UiBinder#createAndBindUi} is called.
//   * If false, {@link UiBinder#createAndBindUi} will fill the field, usually
//   * by calling {@link com.google.gwt.core.client.GWT#create}.
//   */
//  final bool provided;
//  
//  const _UiField([this.provided = false]);
  const _UiField();
}

///**
// * Marks a method to be automatically bound as an event handler. See examples
// * in {@code com.google.gwt.uibinder.test.client.HandlerDemo}.
// *
// * <p>The annotation values must be declared in the "ui:field"
// * template attribute.
// */
//class UiHandler {
//  final List<String> value;
//  
//  const UiHandler([this.value = null]);
//}
//
///**
// * Marker interface for classes whose implementation is to be provided via UiBinder code
// * generation for SafeHtml rendering.
// * <p>
// * <span style='color: red'>This is experimental code in active
// * developement. It is unsupported, and its api is subject to
// * change.</span>
// */
//class UiRenderer {
//  /**
//   * Checks whether {@code parent} is a valid element to use as an argument for field getters.
//   * 
//   * @return {@code true} if parent contains or directly points to a previously rendered element.
//   *         In DevMode it also checks whether the parent is attached to the DOM
//   */
//  bool isParentOrRenderer(Element parent) { return false; }
//}
//
///**
// * Indicates the template from which to generate a [UiBinder].
// */
//class UiTemplate {
//  /**
//   * Returns the template name.
//   */
//  final String value;
//  
//  const UiTemplate([this.value = null]);
//}