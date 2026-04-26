import 'package:flutter/material.dart';

class BetterCollapseTheme {
  final Color? backgroundColor;
  final Color? collapsedBackground;
  final Color? iconColor;
  final Color? collapsedIconColor;
  final Color? splashColor;

  const BetterCollapseTheme({
    this.backgroundColor,
    this.collapsedBackground,
    this.iconColor,
    this.collapsedIconColor,
    this.splashColor,
  });

  BetterCollapseTheme copyWith({
    Color? backgroundColor,
    Color? collapsedBackground,
    Color? iconColor,
    Color? collapsedIconColor,
    Color? splashColor,
  }) {
    return BetterCollapseTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      collapsedBackground: collapsedBackground ?? this.collapsedBackground,
      iconColor: iconColor ?? this.iconColor,
      collapsedIconColor: collapsedIconColor ?? this.collapsedIconColor,
      splashColor: splashColor ?? this.splashColor,
    );
  }

  static BetterCollapseTheme lerp(
    BetterCollapseTheme collapseTheme,
    BetterCollapseTheme otherCollapseTheme,
    double t,
  ) {
    return BetterCollapseTheme(
      backgroundColor: Color.lerp(
        collapseTheme.backgroundColor,
        otherCollapseTheme.backgroundColor,
        t,
      ),
      collapsedBackground: Color.lerp(
        collapseTheme.collapsedBackground,
        otherCollapseTheme.collapsedBackground,
        t,
      ),
      iconColor: Color.lerp(
        collapseTheme.iconColor,
        otherCollapseTheme.iconColor,
        t,
      ),
      collapsedIconColor: Color.lerp(
        collapseTheme.collapsedIconColor,
        otherCollapseTheme.collapsedIconColor,
        t,
      ),
      splashColor: Color.lerp(
        collapseTheme.splashColor,
        otherCollapseTheme.splashColor,
        t,
      ),
    );
  }
}
