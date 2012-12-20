//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_util;

/**
 * Emulation of Java Enum class.
 *  
 * Example:
 * 
 * class Meter<int> extends Enum<int> {
 * 
 *  const Meter(int val) : super (val);
 *  
 *  static const Meter HIGH = const Meter(100);
 *  static const Meter MIDDLE = const Meter(50);
 *  static const Meter LOW = const Meter(10);
 * }
 * 
 * and usage:
 * 
 * assert (Meter.HIGH, 100);
 * assert (Meter.HIGH is Meter);
 */
abstract class Enum<T> {
  
  final T _type;
  
  const Enum(this._type);
  
  T get type => _type;
}
