import 'package:flutter/material.dart';

class BetterUtil {
  static bool shouldUseHairlineBorder(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio >= 2.0; // 高DPI设备用0.5
  }
}
