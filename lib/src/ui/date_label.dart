//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * Extends {@link ValueLabel} for convenience when dealing with dates and
 * {@link DateTimeFormat}, especially in
 * {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates. (Note
 * that this class does not accept renderers. To do so use {@link ValueLabel}
 * directly.)
 * 
 * <h3>Use in UiBinder Templates</h3>
 * In {@link com.google.gwt.uibinder.client.UiBinder UiBinder} templates, both the format and time zone can be configured.
 * <p>
 * The format can be given with one of these attributes:
 * <dl>
 * <dt>format</dt><dd>a reference to a {@link DateTimeFormat} instance.</dd>
 * <dt>predefinedFormat</dt><dd>a {@link com.google.gwt.i18n.shared.DateTimeFormat.PredefinedFormat DateTimeFormat.PredefinedFormat}.</dd>
 * <dt>customFormat</dt><dd>a date time pattern that can be passed to {@link DateTimeFormat#getFormat(String)}.</dd>
 * </dl>
 * <p>
 * The time zone can be specified with either of these attributes:
 * <dl>
 * <dt>timezone</dt><dd>a reference to a {@link TimeZone} instance.</dd>
 * <dt>timezoneOffset</dt><dd>the time zone offset in minutes.</dd>
 * </dl>
 */
class DateLabel extends ValueLabel<Date> {
  
  DateLabel([DateTimeFormat format = null, TimeZone timeZone = null]) : super(new DateTimeFormatRenderer(format, timeZone));
}
