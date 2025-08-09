import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter_better_ui/theme/themes/better_dark_theme.dart';
import 'package:flutter_better_ui/theme/theme_mode_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller that manages the current theme and mode (light/dark/system).
class BetterThemeController extends GetxController {
  final Rx<ThemeData> _currentTheme = betterLightTheme.obs;
  final Rx<BetterThemeMode> _themeMode = BetterThemeMode.system.obs;

  ThemeData get currentTheme => _currentTheme.value;
  BetterThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    // 初始化时获取系统主题
    _updateThemeFromSystem();
  }

  // 更新主题模式
  void changeThemeMode(BetterThemeMode mode) {
    _themeMode.value = mode;
    _updateTheme();
  }

  // 根据系统主题更新
  void _updateThemeFromSystem() {
    if (_themeMode.value == BetterThemeMode.system) {
      final brightness = Get.mediaQuery.platformBrightness;
      final isDark = brightness == Brightness.dark;
      _currentTheme.value = isDark ? betterDarkTheme : betterLightTheme;
      Get.changeTheme(_currentTheme.value);
    }
  }

  // 更新主题
  void _updateTheme() {
    switch (_themeMode.value) {
      case BetterThemeMode.light:
        _currentTheme.value = betterLightTheme;
        Get.changeTheme(betterLightTheme);
        break;
      case BetterThemeMode.dark:
        _currentTheme.value = betterDarkTheme;
        Get.changeTheme(betterDarkTheme);
        break;
      case BetterThemeMode.system:
        _updateThemeFromSystem();
        break;
    }
  }

  // 切换主题（在light和dark之间切换）
  void toggleTheme() {
    if (_themeMode.value == BetterThemeMode.light) {
      changeThemeMode(BetterThemeMode.dark);
    } else if (_themeMode.value == BetterThemeMode.dark) {
      changeThemeMode(BetterThemeMode.light);
    } else {
      // 如果当前是系统模式，根据当前主题切换到对应的手动模式
      final isDark = _currentTheme.value == betterDarkTheme;
      changeThemeMode(isDark ? BetterThemeMode.light : BetterThemeMode.dark);
    }
  }

  // 监听系统主题变化
  void onSystemThemeChanged() {
    if (_themeMode.value == BetterThemeMode.system) {
      _updateThemeFromSystem();
    }
  }
}
