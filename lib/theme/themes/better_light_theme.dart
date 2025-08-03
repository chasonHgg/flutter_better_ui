import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:better_ui/theme/child_themes/better_popup_theme.dart';
import 'package:better_ui/utils/better_screen_util.dart';
import 'package:better_ui/utils/color_util.dart';
import 'package:flutter/material.dart';

ThemeData betterLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ColorUtil.hexToColor('#323233'),
  dividerColor: ColorUtil.hexToColor('#ebedf0'),
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
    backgroundColor: ColorUtil.hexToColor('#ffffff'),
    titleTextStyle: TextStyle(
      color: ColorUtil.hexToColor('#323233'),
      fontSize: 18.bsp,
    ),
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
        fontSize: 14.bsp,
        padding: EdgeInsets.symmetric(horizontal: 16.bw),
        borderRadius: 6.bw,
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
        overlayColor: Colors.black.withAlpha(20),
      ),
      cellTheme: BetterCellTheme(
        height: 44.bw,
        backgroundColor: ColorUtil.hexToColor('#ffffff'),
        padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
        titleTextStyle: TextStyle(
          color: ColorUtil.hexToColor('#323233'),
          fontSize: 14.bsp,
        ),
        valueTextStyle: TextStyle(
          fontSize: 14.bsp,
          color: ColorUtil.hexToColor('#969799'),
        ),
        border: Border(
          bottom: BorderSide(
            color: ColorUtil.hexToColor('#ebedf0'),
            width: 0.5,
          ),
        ),
        arrowRightSize: 14.bw,
        arrowRightColor: ColorUtil.hexToColor('#969799'),
        overlayColor: ColorUtil.hexToColor('#f2f3f5'),
      ),
      popupTheme: BetterPopupTheme(
        backgroundColor: ColorUtil.hexToColor('#ffffff'),
        closeIconColor: ColorUtil.hexToColor('#323233'),
        closeIconSize: 22.bw,
      ),
    ),
  ],
);
