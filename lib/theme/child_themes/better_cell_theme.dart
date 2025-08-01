import 'dart:ui';

import 'package:flutter/material.dart';

class BetterCellTheme {
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  final BoxBorder border;
  final double? arrowRightSize;
  final Color? arrowRightColor;
  final double? arrowRightMarginLeft;
  final Color? overlayColor;

  BetterCellTheme({
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.titleTextStyle,
    this.valueTextStyle,
    required this.border,
    this.arrowRightSize,
    this.arrowRightColor,
    this.arrowRightMarginLeft,
    this.overlayColor,
  });

  BetterCellTheme copyWith({
    double? height,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    TextStyle? titleTextStyle,
    TextStyle? valueTextStyle,
    BoxBorder? border,
    double? arrowRightSize,
    Color? arrowRightColor,
    double? arrowRightMarginLeft,
    Color? overlayColor,
  }) {
    return BetterCellTheme(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
      border: border ?? this.border,
      arrowRightSize: arrowRightSize ?? this.arrowRightSize,
      arrowRightColor: arrowRightColor ?? this.arrowRightColor,
      arrowRightMarginLeft: arrowRightMarginLeft ?? this.arrowRightMarginLeft,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }

  static BetterCellTheme lerp(
    BetterCellTheme cellTheme,
    BetterCellTheme otherCellTheme,
    double t,
  ) {
    return BetterCellTheme(
      height: lerpDouble(cellTheme.height, otherCellTheme.height, t),
      borderRadius: BorderRadiusGeometry.lerp(
        cellTheme.borderRadius,
        otherCellTheme.borderRadius,
        t,
      ),
      backgroundColor: Color.lerp(
        cellTheme.backgroundColor,
        otherCellTheme.backgroundColor,
        t,
      ),
      padding: EdgeInsetsGeometry.lerp(
        cellTheme.padding,
        otherCellTheme.padding,
        t,
      ),
      titleTextStyle: TextStyle.lerp(
        cellTheme.titleTextStyle,
        otherCellTheme.titleTextStyle,
        t,
      ),
      valueTextStyle: TextStyle.lerp(
        cellTheme.valueTextStyle,
        otherCellTheme.valueTextStyle,
        t,
      ),
      border:
          BoxBorder.lerp(cellTheme.border, otherCellTheme.border, t)
              as BoxBorder,
      arrowRightSize: lerpDouble(
        cellTheme.arrowRightSize,
        otherCellTheme.arrowRightSize,
        t,
      ),
      arrowRightColor: Color.lerp(
        cellTheme.arrowRightColor,
        otherCellTheme.arrowRightColor,
        t,
      ),
      arrowRightMarginLeft: lerpDouble(
        cellTheme.arrowRightMarginLeft,
        otherCellTheme.arrowRightMarginLeft,
        t,
      ),
      overlayColor: Color.lerp(
        cellTheme.overlayColor,
        otherCellTheme.overlayColor,
        t,
      ),
    );
  }
}
