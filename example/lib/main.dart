import 'package:better_ui/theme/better_theme_controller.dart';
import 'package:example/i18n/translations.dart';
import 'package:example/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: I18nTranslations(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      theme: Get.put(BetterThemeController()).currentTheme,
      getPages: routes,
    );
  }
}
