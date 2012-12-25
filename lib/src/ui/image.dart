//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that displays the image at a given URL. The image can be in
 * 'unclipped' mode (the default) or 'clipped' mode. In clipped mode, a viewport
 * is overlaid on top of the image so that a subset of the image will be
 * displayed. In unclipped mode, there is no viewport - the entire image will be
 * visible. Whether an image is in clipped or unclipped mode depends on how the
 * image is constructed, and how it is transformed after construction. Methods
 * will operate differently depending on the mode that the image is in. These
 * differences are detailed in the documentation for each method.
 * 
 * <p>
 * If an image transitions between clipped mode and unclipped mode, any
 * {@link Element}-specific attributes added by the user (including style
 * attributes, style names, and style modifiers), except for event listeners,
 * will be lost.
 * </p>
 * 
 * <h3>CSS Style Rules</h3>
 * <dl>
 * <dt>.gwt-Image</dt>
 * </dd>The outer element</dd>
 * </dl>
 * 
 * Tranformations between clipped and unclipped state will result in a loss of
 * any style names that were set/added; the only style names that are preserved
 * are those that are mentioned in the static CSS style rules. Due to
 * browser-specific HTML constructions needed to achieve the clipping effect,
 * certain CSS attributes, such as padding and background, may not work as
 * expected when an image is in clipped mode. These limitations can usually be
 * easily worked around by encapsulating the image in a container widget that
 * can itself be styled.
 * 
 * <p>
 * <h3>Example</h3>
 * {@example com.google.gwt.examples.ImageExample}
 * </p>
 */
class Image extends Widget implements HasLoadHandlers, HasErrorHandlers,
  HasClickHandlers, HasDoubleClickHandlers, HasAllDragAndDropHandlers,
  HasAllGestureHandlers, HasAllMouseHandlers, HasAllTouchHandlers {
  
  //***********************************
  // Implementation of HasClickHandlers
  //***********************************
  
  HandlerRegistration addClickHandler(ClickHandler handler) {
    return addHandler(handler, ClickEvent.TYPE);
  }
}
