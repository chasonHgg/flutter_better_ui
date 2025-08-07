import 'dart:async';

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

  /// 防抖函数封装
  /// [func]: 要执行的函数
  /// [delay]: 防抖时间（毫秒）
  static Function debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 500),
  ]) {
    Timer? _timer;
    return () {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(delay, () {
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
    DateTime? _lastTime;
    Timer? _timer;
    return () {
      final now = DateTime.now();
      if (_lastTime == null || now.difference(_lastTime!) > delay) {
        _lastTime = now;
        func.call();
      } else {
        _timer?.cancel();
        _timer = Timer(delay - now.difference(_lastTime!), () {
          func.call();
          _lastTime = DateTime.now();
        });
      }
    };
  }
}
