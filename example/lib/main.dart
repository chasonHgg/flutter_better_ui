import 'package:flutter_better_ui/theme/themes/better_dark_theme.dart';
import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:example/i18n/translations.dart';
import 'package:example/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool? isFirst = true;

void main() async {
  runApp(BetterUi(designWidth: 375, designHeight: 812, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    if (isFirst == true) {
      isFirst = false;
      Get.changeThemeMode(ThemeMode.system);
    }
    return GetMaterialApp(
      navigatorKey: BetterUi.navigatorKey,
      translations: I18nTranslations(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      darkTheme: betterDarkTheme.copyWith(
        appBarTheme: betterDarkTheme.appBarTheme.copyWith(
          scrolledUnderElevation: 0,
        ),
      ),
      theme: betterLightTheme.copyWith(
        appBarTheme: betterLightTheme.appBarTheme.copyWith(
          scrolledUnderElevation: 0,
        ),
      ),
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
