//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * DockPanel layout constant, used in
 * {@link DockPanel#add(Widget, DockPanel.DockLayoutConstant)}.
 */
class DockLayoutConstant<int> extends Enum<int> {

  const DockLayoutConstant(int type) : super (type);

  /**
   * Specifies that a widget be added at the center of the dock.
   */
  static const DockLayoutConstant CENTER = const DockLayoutConstant(0);
  /**
   * Specifies that a widget be added at the beginning of the line direction
   * for the layout.
   */
  static const DockLayoutConstant LINE_START = const DockLayoutConstant(1);
  /**
   * Specifies that a widget be added at the end of the line direction
   * for the layout.
   */
  static const DockLayoutConstant LINE_END = const DockLayoutConstant(2);
  /**
   * Specifies that a widget be added at the east edge of the dock.
   */
  static const DockLayoutConstant EAST = const DockLayoutConstant(3);
  /**
   * Specifies that a widget be added at the north edge of the dock.
   */
  static const DockLayoutConstant NORTH = const DockLayoutConstant(4);
  /**
   * Specifies that a widget be added at the south edge of the dock.
   */
  static const DockLayoutConstant SOUTH = const DockLayoutConstant(5);
  /**
   * Specifies that a widget be added at the west edge of the dock.
   */
  static const DockLayoutConstant WEST = const DockLayoutConstant(6);
}
