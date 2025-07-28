import 'package:better_ui/theme/better_theme_controller.dart';
import 'package:example/router/go_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => BetterThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<BetterThemeController>(context);

    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp.router(
          routerConfig: goRoutes,
          theme: themeController.currentTheme,
        );
      },
    );
  }
}
