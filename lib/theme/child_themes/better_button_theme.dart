import 'dart:ui';
import 'package:flutter/material.dart';

class BetterButtonTheme {
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final Color defaultTextColor;
  final Color defaultColor;
  final Color borderColor;
  final Color primaryTextColor;
  final Color infoTextColor;
  final Color successTextColor;
  final Color warningTextColor;
  final Color dangerTextColor;
  final Color loadingColor;

  const BetterButtonTheme({
    required this.fontSize,
    required this.padding,
    this.borderRadius = 6,
    this.mainAxisAlignment = MainAxisAlignment.center,
    required this.defaultTextColor,
    required this.defaultColor,
    required this.borderColor,
    required this.primaryTextColor,
    required this.infoTextColor,
    required this.successTextColor,
    required this.warningTextColor,
    required this.dangerTextColor,
    required this.loadingColor,
  });

  BetterButtonTheme copyWith({
    double? fontSize,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    MainAxisAlignment? mainAxisAlignment,
    Color? defaultTextColor,
    Color? defaultColor,
    Color? borderColor,
    Color? primaryTextColor,
    Color? infoTextColor,
    Color? successTextColor,
    Color? warningTextColor,
    Color? dangerTextColor,
    Color? loadingColor,
  }) {
    return BetterButtonTheme(
      fontSize: fontSize ?? this.fontSize,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      defaultColor: defaultColor ?? this.defaultColor,
      borderColor: borderColor ?? this.borderColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      infoTextColor: infoTextColor ?? this.infoTextColor,
      successTextColor: successTextColor ?? this.successTextColor,
      warningTextColor: warningTextColor ?? this.warningTextColor,
      dangerTextColor: dangerTextColor ?? this.dangerTextColor,
      loadingColor: loadingColor ?? this.loadingColor,
    );
  }

  static BetterButtonTheme lerp(
    BetterButtonTheme buttonTheme,
    BetterButtonTheme otherButtonTheme,
    double t,
  ) {
    return BetterButtonTheme(
      fontSize:
          lerpDouble(buttonTheme.fontSize, otherButtonTheme.fontSize, t) ??
          buttonTheme.fontSize,
      padding:
          EdgeInsetsGeometry.lerp(
            buttonTheme.padding,
            otherButtonTheme.padding,
            t,
          ) ??
          buttonTheme.padding,
      borderRadius:
          lerpDouble(
            buttonTheme.borderRadius,
            otherButtonTheme.borderRadius,
            t,
          ) ??
          buttonTheme.borderRadius,
      defaultTextColor:
          Color.lerp(
            buttonTheme.defaultTextColor,
            otherButtonTheme.defaultTextColor,
            t,
          ) ??
          buttonTheme.defaultTextColor,
      defaultColor:
          Color.lerp(
            buttonTheme.defaultColor,
            otherButtonTheme.defaultColor,
            t,
          ) ??
          buttonTheme.defaultColor,
      borderColor:
          Color.lerp(
            buttonTheme.borderColor,
            otherButtonTheme.borderColor,
            t,
          ) ??
          buttonTheme.borderColor,
      primaryTextColor:
          Color.lerp(
            buttonTheme.primaryTextColor,
            otherButtonTheme.primaryTextColor,
            t,
          ) ??
          buttonTheme.primaryTextColor,
      infoTextColor:
          Color.lerp(
            buttonTheme.infoTextColor,
            otherButtonTheme.infoTextColor,
            t,
          ) ??
          buttonTheme.infoTextColor,
      successTextColor:
          Color.lerp(
            buttonTheme.successTextColor,
            otherButtonTheme.successTextColor,
            t,
          ) ??
          buttonTheme.successTextColor,
      warningTextColor:
          Color.lerp(
            buttonTheme.warningTextColor,
            otherButtonTheme.warningTextColor,
            t,
          ) ??
          buttonTheme.warningTextColor,
      dangerTextColor:
          Color.lerp(
            buttonTheme.dangerTextColor,
            otherButtonTheme.dangerTextColor,
            t,
          ) ??
          buttonTheme.dangerTextColor,
      loadingColor:
          Color.lerp(
            buttonTheme.loadingColor,
            otherButtonTheme.loadingColor,
            t,
          ) ??
          buttonTheme.loadingColor,
    );
  }
}
