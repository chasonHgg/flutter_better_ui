import 'package:better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter/material.dart';

class BetterThemeController with ChangeNotifier {
  ThemeData _currentTheme = betterLightTheme;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}
