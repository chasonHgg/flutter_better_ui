import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:better_ui/theme/child_themes/better_picker_theme.dart';
import 'package:better_ui/theme/child_themes/better_popup_theme.dart';
import 'package:flutter/material.dart';

// UI主题扩展
class BetterThemeExtension extends ThemeExtension<BetterThemeExtension> {
  final Color primaryColor;
  final Color infoColor;
  final Color successColor;
  final Color warningColor;
  final Color dangerColor;
  final Color borderColor;

  //按钮主题
  final BetterButtonTheme buttonTheme;
  //单元格主题
  final BetterCellTheme cellTheme;
  //弹出窗主题
  final BetterPopupTheme popupTheme;
  // 选择器主题
  final BetterPickerTheme pickerTheme;

  const BetterThemeExtension({
    required this.primaryColor,
    required this.infoColor,
    required this.successColor,
    required this.warningColor,
    required this.dangerColor,
    required this.borderColor,
    required this.buttonTheme,
    required this.cellTheme,
    required this.popupTheme,
    required this.pickerTheme,
  });

  @override
  BetterThemeExtension copyWith({
    Color? primaryColor,
    Color? infoColor,
    Color? successColor,
    Color? warningColor,
    Color? dangerColor,
    Color? borderColor,
    BetterButtonTheme? buttonTheme,
    BetterCellTheme? cellTheme,
    BetterPopupTheme? popupTheme,
    BetterPickerTheme? pickerTheme,
  }) {
    return BetterThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      infoColor: infoColor ?? this.infoColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      dangerColor: dangerColor ?? this.dangerColor,
      borderColor: borderColor ?? this.borderColor,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      cellTheme: cellTheme ?? this.cellTheme,
      popupTheme: popupTheme ?? this.popupTheme,
      pickerTheme: pickerTheme ?? this.pickerTheme,
    );
  }

  @override
  BetterThemeExtension lerp(
    ThemeExtension<BetterThemeExtension>? other,
    double t,
  ) {
    if (other is! BetterThemeExtension) {
      return this;
    }
    return BetterThemeExtension(
      primaryColor:
          Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      infoColor: Color.lerp(infoColor, other.infoColor, t) ?? infoColor,
      successColor:
          Color.lerp(successColor, other.successColor, t) ?? successColor,
      warningColor:
          Color.lerp(warningColor, other.warningColor, t) ?? warningColor,
      dangerColor: Color.lerp(dangerColor, other.dangerColor, t) ?? dangerColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      buttonTheme: BetterButtonTheme.lerp(buttonTheme, other.buttonTheme, t),
      cellTheme: BetterCellTheme.lerp(cellTheme, other.cellTheme, t),
      popupTheme: BetterPopupTheme.lerp(popupTheme, other.popupTheme, t),
      pickerTheme: BetterPickerTheme.lerp(pickerTheme, other.pickerTheme, t),
    );
  }
}
