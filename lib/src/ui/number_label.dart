//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Extends {@link ValueLabel} for convenience when dealing with numbers and
 * {@link NumberFormat}, especially in
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates. (Note
 * that this class does not accept renderers. To do so use {@link ValueLabel}
 * directly.)
 *
 * <h3>Use in UiBinder Templates</h3> In
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates, the
 * {@link NumberFormat} can be specified with one of these attributes:
 * <dl>
 * <dt>format</dt>
 * <dd>a reference to a {@link NumberFormat} instance.</dd>
 * <dt>predefinedFormat</dt>
 * <dd>a predefined format (see below for the list of acceptable values).</dd>
 * <dt>customFormat</dt>
 * <dd>a number format pattern that can be passed to
 * {@link NumberFormat#getFormat(String)}. See below for a way of specifying a
 * currency code.</dd>
 * </dl>
 * The valid values for the {@code predefinedFormat} attributes are:
 * <dl>
 * <dt>DECIMAL</dt>
 * <dd>the standard decimal format for the current locale, as given by
 * {@link NumberFormat#getDecimalFormat()}.</dd>
 * <dt>CURRENCY</dt>
 * <dd>the standard currency format for the current locale, as given by
 * {@link NumberFormat#getCurrencyFormat()}. See below for a way of specifying a
 * currency code.</dd>
 * <dt>PERCENT</dt>
 * <dd>the standard percent format for the current locale, as given by
 * {@link NumberFormat#getPercentFormat()}.</dd>
 * <dt>SCIENTIFIC</dt>
 * <dd>the standard scientific format for the current locale, as given by
 * {@link NumberFormat#getScientificFormat()}.</dd>
 * </dl>
 * When using {@code predefinedFormat="CURRENCY"} or a {@code customFormat}, you
 * can specify a currency code using either of the following attributes:
 * <dl>
 * <dt>currencyData</dt>
 * <dd>a reference to a {@link com.google.gwt.i18n.client.CurrencyData
 * CurrencyData} instance.</dd>
 * <dt>currencyCode</dt>
 * <dd>an ISO4217 currency code.</dd>
 * </dl>
 *
 * @param <T> The exact type of number
 */
class NumberLabel<T> extends ValueLabel<T> {

  NumberLabel([NumberFormat format = null]) : super(new NumberFormatRenderer(format));
}
