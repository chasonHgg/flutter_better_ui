import 'package:flutter_better_ui/theme/child_themes/better_button_theme.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:flutter_better_ui/theme/child_themes/better_picker_theme.dart';
import 'package:flutter_better_ui/theme/child_themes/better_popup_theme.dart';
import 'package:flutter_better_ui/theme/child_themes/better_switch_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';
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
        fontSize: 13.bsp,
        padding: EdgeInsets.symmetric(horizontal: 10.bw, vertical: 10.bw),
        borderRadius: BorderRadius.all(Radius.circular(6.bw)),
        mainAxisAlignment: MainAxisAlignment.center,
        defaultTextColor: Colors.white,
        defaultBackgroundColor: ColorUtil.hexToColor('#1c1c1c'),
        borderColor: ColorUtil.hexToColor('#ffffff'),
        primaryTextColor: ColorUtil.hexToColor('#ffffff'),
        infoTextColor: ColorUtil.hexToColor('#ffffff'),
        successTextColor: ColorUtil.hexToColor('#ffffff'),
        warningTextColor: ColorUtil.hexToColor('#ffffff'),
        dangerTextColor: ColorUtil.hexToColor('#ffffff'),
        loadingColor: ColorUtil.hexToColor('#ffffff'),
        overlayColor: Colors.black.withAlpha(40),
        loadingStrokeWidth: 1,
      ),
      cellTheme: BetterCellTheme(
        backgroundColor: ColorUtil.hexToColor('#1c1c1e'),
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
      pickerTheme: BetterPickerTheme(
        headerBackgroundColor: ColorUtil.hexToColor('#3a3a3c'),
        cancelTextColor: ColorUtil.hexToColor('#ffffff'),
        itemHeight: 44.bw,
        backgroundColor: ColorUtil.hexToColor('#1c1c1e'),
        overlayStartColor: ColorUtil.hexToColor('#1c1c1e'),
        overlayEndColor: ColorUtil.hexToColor('#3a3a3c'),
      ),
      switchTheme: BetterSwitchTheme(
        width: 50.bw,
        height: 30.bw,
        ballBackgroundColor: ColorUtil.hexToColor('#ffffff'),
        inactiveBackgroundColor: ColorUtil.hexToColor('#787880').withAlpha(82),
        activeBackgroundColor: ColorUtil.hexToColor('#1989fa'),
        loadingSize: 14.bw,
        loadingStrokeWidth: 1,
        loadingColor: ColorUtil.hexToColor('#c8c9cc'),
      ),
    ),
  ],
);
