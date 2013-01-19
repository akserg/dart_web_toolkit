//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * A default {@link CurrencyData} implementation, so new methods can be added
 * to the interface without breaking implementors if a reasonable default is
 * available.
 */
class DefaultCurrencyData implements CurrencyData {

  final String currencyCode;
  final String currencySymbol;
  final int fractionDigits;

  /**
   * Create a default default {@link CurrencyData} instance, returning {@code
   * false} for all {@code isFoo} methods and using the standard symbol for the
   * portable symbol.
   *
   * @param currencyCode ISO 4217 currency code
   * @param currencySymbol symbol to use for this currency
   * @param fractionDigits default number of fraction digits
   */
  DefaultCurrencyData(this.currencyCode, this.currencySymbol, [this.fractionDigits = 2]);

  String getCurrencyCode() {
    return currencyCode;
  }

  String getCurrencySymbol() {
    return currencySymbol;
  }

  int getDefaultFractionDigits() {
    return fractionDigits;
  }

  String getPortableCurrencySymbol() {
    return getCurrencySymbol();
  }

  String getSimpleCurrencySymbol() {
    return getCurrencySymbol();
  }

  bool isDeprecated() {
    return false;
  }

  bool isSpaceForced() {
    return false;
  }

  bool isSpacingFixed() {
    return false;
  }

  bool isSymbolPositionFixed() {
    return false;
  }

  bool isSymbolPrefix() {
    return false;
  }
}
