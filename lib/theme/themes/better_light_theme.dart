import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/utils/color_util.dart';
import 'package:flutter/material.dart';

ThemeData betterLightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
    backgroundColor: ColorUtil.hexToColor('#ffffff'),
  ),
  scaffoldBackgroundColor: ColorUtil.hexToColor('#ffffff'),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: ColorUtil.hexToColor('#323233')),
    bodyMedium: TextStyle(color: ColorUtil.hexToColor('#323233')),
    bodySmall: TextStyle(color: ColorUtil.hexToColor('#323233')),
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
        defaultTextColor: ColorUtil.hexToColor('#323233'),
        defaultColor: Colors.white,
        borderColor: ColorUtil.hexToColor('#dcdee0'),
        primaryTextColor: ColorUtil.hexToColor('#ffffff'),
        infoTextColor: ColorUtil.hexToColor('#ffffff'),
        successTextColor: ColorUtil.hexToColor('#ffffff'),
        warningTextColor: ColorUtil.hexToColor('#ffffff'),
        dangerTextColor: ColorUtil.hexToColor('#ffffff'),
        loadingColor: ColorUtil.hexToColor('#323233'),
      ),
    ),
  ],
);
