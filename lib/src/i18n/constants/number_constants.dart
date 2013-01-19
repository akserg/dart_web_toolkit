//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_i18n;

/**
 * NumberConstants class encapsulate a collection of Number formatting
 * symbols for use with Number format and parse services. This class extends
 * GWT's Constants class. The actual symbol collections are defined in a set
 * of property files named like "NumberConstants_xx.properties". GWT will
 * will perform late binding to the property file that specific to user's
 * locale.
 *
 * If you previously were using GWT.create on this interface, you should
 * use LocaleInfo.getCurrentLocale().getNumberConstants() instead.
 */
abstract class NumberConstants {
  String notANumber();
  String currencyPattern();
  String decimalPattern();
  String decimalSeparator();
  String defCurrencyCode();
  String exponentialSymbol();
  String globalCurrencyPattern();
  String groupingSeparator();
  String infinity();
  String minusSign();
  String monetaryGroupingSeparator();
  String monetarySeparator();
  String percent();
  String percentPattern();
  String perMill();
  String plusSign();
  String scientificPattern();
  String simpleCurrencyPattern();
  String zeroDigit();
}

/**
 * NumberConstantsImpl class encapsulate a collection of Number formatting
 * symbols for use with Number format and parse services. This class extends
 * GWT's Constants class. The actual symbol collections are defined in a set
 * of property files named like "NumberConstants_xx.properties". GWT will
 * will perform late binding to the property file that specific to user's
 * locale.
 */
class NumberConstantsImpl implements Constants, NumberConstants {

  String notANumber() { return "NaN"; }

  String currencyPattern() { return "\$#,##0.00;(\$#,##0.00)"; }

  String decimalPattern() { return "#,##0.###"; }

  String decimalSeparator() { return "."; }

  String defCurrencyCode() { return "USD"; }

  String exponentialSymbol() { return "E"; }

  String globalCurrencyPattern() { return "\$\$\$\$#,##0.00 \$\$;(\$\$\$\$#,##0.00 \$\$)"; }

  String groupingSeparator() { return ","; }

  String infinity() { return new String.fromCharCodes([0x221E]); }

  String minusSign() { return "-"; }

  String monetaryGroupingSeparator() { return ","; }

  String monetarySeparator() { return "."; }

  String percent() { return "%"; }

  String percentPattern() { return "#,##0%"; }

  String perMill() { return new String.fromCharCodes([0x2030]); }

  String plusSign() { return "+"; }

  String scientificPattern() { return "#E0"; }

  String simpleCurrencyPattern() { return "\$\$\$\$#,##0.00;(\$\$\$\$#,##0.00)"; }

  String zeroDigit() { return "0"; }

}
