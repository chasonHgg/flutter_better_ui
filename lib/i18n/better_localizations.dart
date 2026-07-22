import 'package:flutter/widgets.dart';

/// Lightweight runtime translations used by [BetterUi].
class BetterLocalizations {
  BetterLocalizations._();

  static final ValueNotifier<Locale> localeNotifier = ValueNotifier<Locale>(
    const Locale('en', 'US'),
  );

  static Map<String, Map<String, String>> _translations = const {};
  static Locale _fallbackLocale = const Locale('en', 'US');

  static Locale get locale => localeNotifier.value;

  static Locale get fallbackLocale => _fallbackLocale;

  static List<Locale> get supportedLocales {
    final locales = _translations.keys.map(_localeFromKey).toList();
    return locales.isEmpty ? <Locale>[locale] : locales;
  }

  static void configure({
    required Map<String, Map<String, String>> translations,
    required Locale locale,
    required Locale fallbackLocale,
  }) {
    _translations = translations;
    _fallbackLocale = fallbackLocale;
    localeNotifier.value = locale;
  }

  static void updateLocale(Locale locale) {
    localeNotifier.value = locale;
  }

  static String translate(String key) {
    return _translations[_localeKey(locale)]?[key] ??
        _translations[locale.languageCode]?[key] ??
        _translations[_localeKey(_fallbackLocale)]?[key] ??
        _translations[_fallbackLocale.languageCode]?[key] ??
        key;
  }

  static String _localeKey(Locale locale) {
    final countryCode = locale.countryCode;
    return countryCode == null || countryCode.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}_$countryCode';
  }

  static Locale _localeFromKey(String key) {
    final parts = key.split(RegExp('[-_]'));
    return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
  }
}

/// Translates a string using the translations configured on [BetterUi].
extension BetterTranslationExtension on String {
  String get tr => BetterLocalizations.translate(this);

  /// Translates the string and replaces named parameters such as `@days`.
  ///
  /// Values may be strings, numbers, or any object with a useful [toString].
  String trParams(Map<String, Object> params) {
    var value = tr;
    for (final entry in params.entries) {
      value = value.replaceAll('@${entry.key}', entry.value.toString());
    }
    return value;
  }
}
