import 'package:flutter_better_ui/theme/themes/better_dark_theme.dart';
import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter_better_ui/utils/better_util.dart';
import 'package:example/i18n/translations.dart';
import 'package:example/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool? isFirst = true;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //init Better UI,mast be first line
    if (isFirst == true) {
      isFirst = false;
      BetterUtil.init(context, designWidth: 375, designHeight: 812);
      Get.changeTheme(
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? betterDarkTheme
            : betterLightTheme,
      );
    }
    return GetMaterialApp(
      translations: I18nTranslations(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      darkTheme: betterDarkTheme,
      theme: betterLightTheme,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
