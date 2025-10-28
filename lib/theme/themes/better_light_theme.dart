import 'package:flutter_better_ui/theme/child_themes/better_button_theme.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:flutter_better_ui/theme/child_themes/better_picker_theme.dart';
import 'package:flutter_better_ui/theme/child_themes/better_popup_theme.dart';
import 'package:flutter_better_ui/theme/child_themes/better_switch_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';
import 'package:flutter/material.dart';

ThemeData betterLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ColorUtil.hexToColor('#1989fa'),
  dividerColor: ColorUtil.hexToColor('#ebedf0'),
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
    backgroundColor: ColorUtil.hexToColor('#ffffff'),
    centerTitle: true,
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
      borderColor: ColorUtil.hexToColor('#ebedf0'),
      buttonTheme: BetterButtonTheme(
        fontSize: 13.bsp,
        padding: EdgeInsets.symmetric(horizontal: 10.bw, vertical: 10.bw),
        borderRadius: BorderRadius.all(Radius.circular(6.bw)),
        mainAxisAlignment: MainAxisAlignment.center,
        defaultTextColor: ColorUtil.hexToColor('#323233'),
        defaultBackgroundColor: Colors.white,
        borderColor: ColorUtil.hexToColor('#dcdee0'),
        primaryTextColor: ColorUtil.hexToColor('#ffffff'),
        infoTextColor: ColorUtil.hexToColor('#ffffff'),
        successTextColor: ColorUtil.hexToColor('#ffffff'),
        warningTextColor: ColorUtil.hexToColor('#ffffff'),
        dangerTextColor: ColorUtil.hexToColor('#ffffff'),
        loadingColor: ColorUtil.hexToColor('#323233'),
        overlayColor: Colors.black.withAlpha(20),
        loadingStrokeWidth: 1,
      ),
      cellTheme: BetterCellTheme(
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
            width: 1.bw,
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
      pickerTheme: BetterPickerTheme(
        headerBackgroundColor: ColorUtil.hexToColor('#ffffff'),
        cancelTextColor: ColorUtil.hexToColor('#969799'),
        itemHeight: 44.bw,
        backgroundColor: ColorUtil.hexToColor('#ffffff'),
        overlayStartColor: ColorUtil.hexToColor('#ffffff'),
        overlayEndColor: ColorUtil.hexToColor('#ffffff'),
      ),
      switchTheme: BetterSwitchTheme(
        width: 50.bw,
        height: 30.bw,
        ballBackgroundColor: ColorUtil.hexToColor('#ffffff'),
        inactiveBackgroundColor: ColorUtil.hexToColor('#787880').withAlpha(40),
        activeBackgroundColor: ColorUtil.hexToColor('#1989fa'),
        loadingSize: 14.bw,
        loadingStrokeWidth: 1,
        loadingColor: ColorUtil.hexToColor('#c8c9cc'),
      ),
    ),
  ],
);
