import 'package:example/i18n/translations.dart';
import 'package:example/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/theme/themes/better_dark_theme.dart';
import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  final translations = I18nTranslations();
  runApp(
    BetterUi(
      designWidth: 375,
      designHeight: 812,
      themeBuilder: () => betterLightTheme.copyWith(
        appBarTheme: betterLightTheme.appBarTheme.copyWith(
          scrolledUnderElevation: 0,
        ),
      ),
      darkThemeBuilder: () => betterDarkTheme.copyWith(
        appBarTheme: betterDarkTheme.appBarTheme.copyWith(
          scrolledUnderElevation: 0,
        ),
      ),
      translations: translations.keys,
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      builder: (context, config) {
        return MaterialApp.router(
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          locale: config.locale,
          supportedLocales: config.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          theme: config.theme,
          darkTheme: config.darkTheme,
          themeMode: config.themeMode,
        );
      },
    ),
  );
}
