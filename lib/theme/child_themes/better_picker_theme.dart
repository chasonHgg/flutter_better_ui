import 'dart:ui';

import 'package:flutter/material.dart';

class BetterPickerTheme {
  final Color? headerBackgroundColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final String? cancelText;
  final String? confirmText;
  final Color? cancelTextColor;
  final double? itemHeight;
  final Color? overlayStartColor;
  final Color? overlayEndColor;

  BetterPickerTheme({
    this.headerBackgroundColor,
    this.backgroundColor,
    this.borderRadius,
    this.cancelText,
    this.confirmText,
    this.cancelTextColor,
    this.itemHeight,
    this.overlayStartColor,
    this.overlayEndColor,
  });

  BetterPickerTheme copyWith({
    Color? headerBackgroundColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    String? cancelText,
    String? confirmText,
    Color? cancelTextColor,
    double? itemHeight,
    Color? overlayStartColor,
    Color? overlayEndColor,
  }) {
    return BetterPickerTheme(
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      cancelText: cancelText ?? this.cancelText,
      confirmText: confirmText ?? this.confirmText,
      cancelTextColor: cancelTextColor ?? this.cancelTextColor,
      itemHeight: itemHeight ?? this.itemHeight,
      overlayStartColor: overlayStartColor ?? this.overlayStartColor,
      overlayEndColor: overlayEndColor ?? this.overlayEndColor,
    );
  }

  static BetterPickerTheme lerp(
    BetterPickerTheme pickerTheme,
    BetterPickerTheme otherPickerTheme,
    double t,
  ) {
    return BetterPickerTheme(
      headerBackgroundColor: Color.lerp(
        pickerTheme.headerBackgroundColor,
        otherPickerTheme.headerBackgroundColor,
        t,
      ),
      backgroundColor: Color.lerp(
        pickerTheme.backgroundColor,
        otherPickerTheme.backgroundColor,
        t,
      ),
      borderRadius: BorderRadiusGeometry.lerp(
        pickerTheme.borderRadius,
        otherPickerTheme.borderRadius,
        t,
      ),
      cancelText: pickerTheme.cancelText,
      confirmText: pickerTheme.confirmText,
      cancelTextColor: Color.lerp(
        pickerTheme.cancelTextColor,
        otherPickerTheme.cancelTextColor,
        t,
      ),
      itemHeight: lerpDouble(
        pickerTheme.itemHeight,
        otherPickerTheme.itemHeight,
        t,
      ),
      overlayStartColor: Color.lerp(
        pickerTheme.overlayStartColor,
        otherPickerTheme.overlayStartColor,
        t,
      ),
      overlayEndColor: Color.lerp(
        pickerTheme.overlayEndColor,
        otherPickerTheme.overlayEndColor,
        t,
      ),
    );
  }
}
