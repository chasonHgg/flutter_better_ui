import 'dart:async';

import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
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

  static BetterThemeExtension? getThemeExtension(BuildContext context) {
    BetterThemeExtension? themeExtension = Theme.of(
      context,
    ).extension<BetterThemeExtension>();
    return themeExtension ?? betterLightTheme.extension<BetterThemeExtension>();
  }

  static bool shouldUseHairlineBorder(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio >= 2.0; // 高DPI设备用0.5
  }

  /// 防抖函数封装
  /// [func]: 要执行的函数
  /// [delay]: 防抖时间（毫秒）
  static Function debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 500),
  ]) {
    Timer? timer;
    return () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func.call();
      });
    };
  }

  /// 节流函数封装
  /// [func]: 要执行的函数
  /// [delay]: 节流时间（毫秒）
  static Function throttle(
    Function func, [
    Duration delay = const Duration(milliseconds: 200),
  ]) {
    DateTime? lastTime;
    Timer? timer;
    return () {
      final now = DateTime.now();
      if (lastTime == null || now.difference(lastTime!) > delay) {
        lastTime = now;
        func.call();
      } else {
        timer?.cancel();
        timer = Timer(delay - now.difference(lastTime!), () {
          func.call();
          lastTime = DateTime.now();
        });
      }
    };
  }
}
