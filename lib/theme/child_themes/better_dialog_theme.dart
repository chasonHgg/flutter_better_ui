import 'dart:ui';

import 'package:flutter/material.dart';

class BetterDialogTheme {
  final Color? bgColor;
  final Color? titleColor;
  final Color? contentColor;
  final Color? cancelButtonColor;
  final Color? confirmButtonColor;

  BetterDialogTheme({
    this.bgColor,
    this.titleColor,
    this.contentColor,
    this.cancelButtonColor,
    this.confirmButtonColor,
  });

  BetterDialogTheme copyWith({
    Color? bgColor,
    Color? titleColor,
    Color? contentColor,
    Color? cancelButtonColor,
    Color? confirmButtonColor,
  }) {
    return BetterDialogTheme(
      bgColor: bgColor ?? this.bgColor,
      titleColor: titleColor ?? this.titleColor,
      contentColor: contentColor ?? this.contentColor,
      cancelButtonColor: cancelButtonColor ?? this.cancelButtonColor,
      confirmButtonColor: confirmButtonColor ?? this.confirmButtonColor,
    );
  }

  static BetterDialogTheme lerp(
    BetterDialogTheme cellTheme,
    BetterDialogTheme otherCellTheme,
    double t,
  ) {
    return BetterDialogTheme(
      bgColor: Color.lerp(cellTheme.bgColor, otherCellTheme.bgColor, t),
      titleColor: Color.lerp(
        cellTheme.titleColor,
        otherCellTheme.titleColor,
        t,
      ),
      contentColor: Color.lerp(
        cellTheme.contentColor,
        otherCellTheme.contentColor,
        t,
      ),
      cancelButtonColor: Color.lerp(
        cellTheme.cancelButtonColor,
        otherCellTheme.cancelButtonColor,
        t,
      ),
      confirmButtonColor: Color.lerp(
        cellTheme.confirmButtonColor,
        otherCellTheme.confirmButtonColor,
        t,
      ),
    );
  }
}
