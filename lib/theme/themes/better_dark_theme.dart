import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/utils/color_util.dart';
import 'package:flutter/material.dart';

ThemeData betterDarkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
    backgroundColor: ColorUtil.hexToColor('#141218'),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: ColorUtil.hexToColor('#ffffff')),
    bodyMedium: TextStyle(color: ColorUtil.hexToColor('#ffffff')),
    bodySmall: TextStyle(color: ColorUtil.hexToColor('#ffffff')),
  ),
  extensions: [
    BetterThemeExtension(
      primaryColor: ColorUtil.hexToColor('#1989fa'),
      infoColor: ColorUtil.hexToColor('#2DB7F4'),
      successColor: ColorUtil.hexToColor('#07c160'),
      warningColor: ColorUtil.hexToColor('#f90'),
      dangerColor: ColorUtil.hexToColor('#ee0a24'),
      buttonTheme: BetterButtonTheme(
        fontSize: 14,
        padding: EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 6,
        mainAxisAlignment: MainAxisAlignment.center,
        defaultTextColor: Colors.white,
        defaultColor: ColorUtil.hexToColor('#1c1c1c'),
        borderColor: ColorUtil.hexToColor('#ffffff'),
        primaryTextColor: ColorUtil.hexToColor('#ffffff'),
        infoTextColor: ColorUtil.hexToColor('#ffffff'),
        successTextColor: ColorUtil.hexToColor('#ffffff'),
        warningTextColor: ColorUtil.hexToColor('#ffffff'),
        dangerTextColor: ColorUtil.hexToColor('#ffffff'),
        loadingColor: ColorUtil.hexToColor('#ffffff'),
      ),
    ),
  ],
);
