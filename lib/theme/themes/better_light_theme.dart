import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:better_ui/utils/color_util.dart';
import 'package:flutter/material.dart';

ThemeData betterLightTheme = ThemeData(
  brightness: Brightness.light,
  dividerColor: ColorUtil.hexToColor('#ebedf0'),
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
    backgroundColor: ColorUtil.hexToColor('#ffffff'),
  ),
  scaffoldBackgroundColor: ColorUtil.hexToColor('#f7f8fa'),
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
      cellTheme: BetterCellTheme(
        height: 44,
        backgroundColor: ColorUtil.hexToColor('#ffffff'),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        titleTextStyle: TextStyle(
          color: ColorUtil.hexToColor('#323233'),
          fontSize: 14,
        ),
        valueTextStyle: TextStyle(
          fontSize: 14,
          color: ColorUtil.hexToColor('#969799'),
        ),
        border: Border(
          bottom: BorderSide(
            color: ColorUtil.hexToColor('#ebedf0'),
            width: 0.5,
          ),
        ),
        arrowRightSize: 14,
        arrowRightColor: ColorUtil.hexToColor('#969799'),
        overlayColor: ColorUtil.hexToColor('#f2f3f5'),
      ),
    ),
  ],
);
