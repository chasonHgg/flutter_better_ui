import 'package:better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';

class BetterUtil {
  static void init(
    BuildContext context, {
    double designWidth = 375,
    double designHeight = 1334,
  }) {
    BetterScreenUtil.init(
      context: context,
      designWidth: designWidth,
      designHeight: designHeight,
    );
  }

  static bool shouldUseHairlineBorder(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio >= 2.0; // 高DPI设备用0.5
  }
}
