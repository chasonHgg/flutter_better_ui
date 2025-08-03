import 'dart:ui';

import 'package:flutter/material.dart';

class BetterPopupTheme {
  final Color backgroundColor;
  final Color closeIconColor;
  final double closeIconSize;
  final EdgeInsets? padding;

  BetterPopupTheme({
    required this.backgroundColor,
    required this.closeIconColor,
    required this.closeIconSize,
    this.padding,
  });

  BetterPopupTheme copyWith({
    Color? backgroundColor,
    Color? closeIconColor,
    double? closeIconSize,
    EdgeInsets? padding,
  }) {
    return BetterPopupTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      closeIconSize: closeIconSize ?? this.closeIconSize,
      padding: padding ?? this.padding,
    );
  }

  static BetterPopupTheme lerp(
    BetterPopupTheme a,
    BetterPopupTheme b,
    double t,
  ) {
    return BetterPopupTheme(
      backgroundColor:
          Color.lerp(a.backgroundColor, b.backgroundColor, t) ??
          a.backgroundColor,
      closeIconColor:
          Color.lerp(a.closeIconColor, b.closeIconColor, t) ?? a.closeIconColor,
      closeIconSize:
          lerpDouble(a.closeIconSize, b.closeIconSize, t) ?? a.closeIconSize,
      padding: EdgeInsets.lerp(a.padding, b.padding, t) ?? a.padding,
    );
  }
}
