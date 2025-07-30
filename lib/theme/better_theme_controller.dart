import 'package:better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterThemeController extends GetxController {
  ThemeData _currentTheme = betterLightTheme;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    update();
  }
}
