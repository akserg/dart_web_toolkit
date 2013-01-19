//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * A POJO for currency data.
 */
class CurrencyDataImpl extends DefaultCurrencyData {

  /**
   * Public so CurrencyListGenerator can get to them. As usual with an impl
   * package, external code should not rely on these values.
   */
  static final int DEPRECATED_FLAG = 128;
  static final int POS_FIXED_FLAG = 16;
  static final int POS_SUFFIX_FLAG = 8;
  static final int PRECISION_MASK = 7;
  static final int SPACE_FORCED_FLAG = 32;
  static final int SPACING_FIXED_FLAG = 64;

  static int testDefaultFractionDigits(int flagsAndPrecision) {
    return flagsAndPrecision & PRECISION_MASK;
  }

  static bool testDeprecated(int flagsAndPrecision) {
    return (flagsAndPrecision & DEPRECATED_FLAG) != 0;
  }

  static bool testSpaceForced(int flagsAndPrecision) {
    return (flagsAndPrecision & SPACE_FORCED_FLAG) != 0;
  }

  static bool testSpacingFixed(int flagsAndPrecision) {
    return (flagsAndPrecision & SPACING_FIXED_FLAG) != 0;
  }

  static bool testSymbolPositionFixed(int flagsAndPrecision) {
    return (flagsAndPrecision & POS_FIXED_FLAG) != 0;
  }

  static bool testSymbolPrefix(int flagsAndPrecision) {
    return (flagsAndPrecision & POS_SUFFIX_FLAG) != 0;
  }

  /**
   * Flags and # of decimal digits.
   *
   * <pre>
   *       d0-d2: # of decimal digits for this currency, 0-7
   *       d3:    currency symbol goes after number, 0=before
   *       d4:    currency symbol position is based on d3
   *       d5:    space is forced, 0=no space present
   *       d6:    spacing around currency symbol is based on d5
   * </pre>
   */
  int flagsAndPrecision;

  /**
   * Portable currency symbol, may be the same as {@link #getCurrencySymbol()}.
   */
  String portableCurrencySymbol;

  /**
   * Simple currency symbol, may be the same as {@link #getCurrencySymbol()}.
   */
  String simpleCurrencySymbol;

  /**
   * Create a new CurrencyData whose portable symbol is the same as its local
   * symbol.
   */
  CurrencyDataImpl(String currencyCode, String currencySymbol, int flagsAndPrecision, [String portableCurrencySymbol = null, String simpleCurrencySymbol = null]) : super(currencyCode, currencySymbol, testDefaultFractionDigits(flagsAndPrecision)) {
    this.flagsAndPrecision = flagsAndPrecision;
    this.portableCurrencySymbol = portableCurrencySymbol == null ? currencySymbol : portableCurrencySymbol;
    this.simpleCurrencySymbol = simpleCurrencySymbol == null ? currencySymbol : simpleCurrencySymbol;
  }

  int getDefaultFractionDigits() {
    return testDefaultFractionDigits(flagsAndPrecision);
  }

  String getPortableCurrencySymbol() {
    return portableCurrencySymbol;
  }

  String getSimpleCurrencySymbol() {
    return simpleCurrencySymbol;
  }

  bool isDeprecated() {
    return testDeprecated(flagsAndPrecision);
  }

  bool isSpaceForced() {
    return testSpaceForced(flagsAndPrecision);
  }

  bool isSpacingFixed() {
    return testSpacingFixed(flagsAndPrecision);
  }

  bool isSymbolPositionFixed() {
    return testSymbolPositionFixed(flagsAndPrecision);
  }

  bool isSymbolPrefix() {
    return testSymbolPrefix(flagsAndPrecision);
  }
}
