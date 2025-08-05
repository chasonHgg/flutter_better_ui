import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:better_ui/theme/child_themes/better_popup_theme.dart';
import 'package:better_ui/utils/better_screen_util.dart';
import 'package:better_ui/utils/color_util.dart';
import 'package:flutter/material.dart';

ThemeData betterDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: ColorUtil.hexToColor('#1989fa'),
  dividerColor: ColorUtil.hexToColor('#3a3a3c'),
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
    backgroundColor: ColorUtil.hexToColor('#141218'),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: ColorUtil.hexToColor('#ffffff'),
      fontSize: 18.bsp,
    ),
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
      borderColor: ColorUtil.hexToColor('#3a3a3c'),
      buttonTheme: BetterButtonTheme(
        fontSize: 14.bsp,
        padding: EdgeInsets.symmetric(horizontal: 16.bw),
        borderRadius: 6.bw,
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
        overlayColor: Colors.black.withAlpha(40),
      ),
      cellTheme: BetterCellTheme(
        height: 44.bw,
        backgroundColor: ColorUtil.hexToColor('#141218'),
        padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
        titleTextStyle: TextStyle(
          fontSize: 14.bsp,
          color: ColorUtil.hexToColor('#ffffff'),
        ),
        valueTextStyle: TextStyle(
          fontSize: 14.bsp,
          color: ColorUtil.hexToColor('#969799'),
        ),
        border: Border(
          bottom: BorderSide(
            color: ColorUtil.hexToColor('#3a3a3c'),
            width: 1.bw,
          ),
        ),
        arrowRightSize: 14.bw,
        arrowRightColor: ColorUtil.hexToColor('#969799'),
        overlayColor: ColorUtil.hexToColor('#3a3a3c'),
      ),
      popupTheme: BetterPopupTheme(
        backgroundColor: ColorUtil.hexToColor('#1c1c1e'),
        closeIconColor: ColorUtil.hexToColor('#ffffff'),
        closeIconSize: 22.bw,
      ),
    ),
  ],
);
