import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';

class BetterUtil {
  static void init(
    BuildContext context, {
    double designWidth = 375,
    double designHeight = 812,
    bool? minTextAdapt,
    bool? enableScaleWH,
  }) {
    BetterScreenUtil.init(
      context: context,
      designWidth: designWidth,
      designHeight: designHeight,
      minTextAdapt: minTextAdapt ?? true,
      enableScaleWH: enableScaleWH ?? true,
    );
  }

  static bool shouldUseHairlineBorder(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio >= 2.0; // 高DPI设备用0.5
  }
}
