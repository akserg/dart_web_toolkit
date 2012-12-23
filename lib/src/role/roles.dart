//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_role;

/**
 * <p>Class containing the ARIA roles as defined by <a href="http://www.w3.org/TR/wai-aria/">
 * W3C ARIA specification</a>. A WAI-ARIA role is set on an element using a <i>role</i> attribute.
 * An element role is constant and is not supposed to change.</p>
 *
 * <p>This is the central class in this ARIA API because it contains all defined roles which
 * can be set to HTML elements. Each role in this class is a {@link Role} instance.
 * The {@link Role} class contains methods for getting and setting states and properties.</p>
 *
 * <p>Lets say we have an image button widget and we want to make it visible to a reader as a
 * button, accompanied with some help text for the button usage. For the purpose we need to add a
 * 'button' role to the image and set label that the reader can interpret. We set the 'button' role
 * for an image (img) with the call: Roles.getButtonRole.set(img.getElement()) and set the
 * 'aria-label' property by calling: Roles.getButtonRole().setAriaLabelProperty(img.getElement,
 * "test")</p>
 *
 * <p>ARIA states are used similarly to ARIA properties by using the
 * Roles.getButtonRole().setAriaEnabledState(img.getElement(), isEnabled) method.
 * Although States and Properties are structurally the same, they are
 * separated in 2 classes in this API because they are semantically different and have different
 * usage. There exist the concept of extra properties and for now the only
 * example is tabindex. If we want to set the tabindex to 0 for the button,
 * we need to call Roles.getButtonRole().setTabindexExtraAttribute(img.getElement(), 0).</p>
 *
 * <p>There are 4 groups of roles:
 * <ol>
 * <li>Abstract roles -- used as base types for applied roles. They are not used by Web Authors
 * and would not be exposed as role definitions for incorporation into a Web page. Base classes are
 * referenced within the taxonomy and are used to build a picture of the role taxonomy class
 * hierarchy within the taxonomy.</li>
 * <li>Widget roles -- act as standalone user interface widgets or as part of larger,
 *  composite widgets</li>
 * <li>Widget container roles -- act as composite user interface widgets. These roles typically act
 *  as containers that manage other, contained widgets</li>
 * <li>Document structure roles -- describe structures that organize content in a page. Document
 * structures are not usually interactive</li>
 * <li>Landmark Roles -- regions of the page intended as navigational landmarks</li>
 * </ol>
 * </p>
 *
 * <p>For more details about ARIA roles check <a href="http://www.w3.org/TR/wai-aria/roles"></p>
 */
class Roles {
  static final ButtonRole BUTTON = new ButtonRoleImpl("button");
}
