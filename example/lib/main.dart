import 'package:better_ui/theme/better_theme_controller.dart';
import 'package:better_ui/utils/better_util.dart';
import 'package:example/i18n/translations.dart';
import 'package:example/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //init Better UI,mast be first line
    BetterUtil.init(context, designWidth: 375, designHeight: 812);
    ThemeData currentTheme = Get.put(BetterThemeController()).currentTheme;
    return GetMaterialApp(
      translations: I18nTranslations(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      theme: currentTheme,
      getPages: routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
