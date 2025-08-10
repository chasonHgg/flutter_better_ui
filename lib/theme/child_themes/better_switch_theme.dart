import 'dart:ui';

import 'package:flutter/material.dart';

class BetterSwitchTheme {
  final double? width;
  final double? height;
  final Color? ballBackgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? activeBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? loadingSize;
  final double? loadingStrokeWidth;
  final Color? loadingColor;

  BetterSwitchTheme({
    this.width,
    this.height,
    this.ballBackgroundColor,
    this.inactiveBackgroundColor,
    this.activeBackgroundColor,
    this.padding,
    this.loadingSize,
    this.loadingStrokeWidth,
    this.loadingColor,
  });

  BetterSwitchTheme copyWith({
    double? width,
    double? height,
    Color? ballBackgroundColor,
    double? ballWidth,
    double? ballHeight,
    Color? inactiveBackgroundColor,
    Color? activeBackgroundColor,
    EdgeInsetsGeometry? padding,
    double? loadingSize,
    double? loadingStrokeWidth,
    Color? loadingColor,
  }) {
    return BetterSwitchTheme(
      width: width ?? this.width,
      height: height ?? this.height,
      ballBackgroundColor: ballBackgroundColor ?? this.ballBackgroundColor,
      inactiveBackgroundColor:
          inactiveBackgroundColor ?? this.inactiveBackgroundColor,
      activeBackgroundColor:
          activeBackgroundColor ?? this.activeBackgroundColor,
      padding: padding ?? this.padding,
      loadingSize: loadingSize ?? this.loadingSize,
      loadingStrokeWidth: loadingStrokeWidth ?? this.loadingStrokeWidth,
      loadingColor: loadingColor ?? this.loadingColor,
    );
  }

  static BetterSwitchTheme lerp(
    BetterSwitchTheme a,
    BetterSwitchTheme b,
    double t,
  ) {
    return BetterSwitchTheme(
      width: lerpDouble(a.width, b.width, t) ?? a.width,
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      ballBackgroundColor:
          Color.lerp(a.ballBackgroundColor, b.ballBackgroundColor, t) ??
          a.ballBackgroundColor,
      inactiveBackgroundColor:
          Color.lerp(a.inactiveBackgroundColor, b.inactiveBackgroundColor, t) ??
          a.inactiveBackgroundColor,
      activeBackgroundColor:
          Color.lerp(a.activeBackgroundColor, b.activeBackgroundColor, t) ??
          a.activeBackgroundColor,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
      loadingSize: lerpDouble(a.loadingSize, b.loadingSize, t) ?? a.loadingSize,
      loadingStrokeWidth:
          lerpDouble(a.loadingStrokeWidth, b.loadingStrokeWidth, t) ??
          a.loadingStrokeWidth,
      loadingColor:
          Color.lerp(a.loadingColor, b.loadingColor, t) ?? a.loadingColor,
    );
  }
}
