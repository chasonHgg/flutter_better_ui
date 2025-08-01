import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BetterScreenUtil {
  static void init({
    required BuildContext context,
    required double designWidth,
    required double designHeight,
  }) {
    ScreenUtilInit(
      designSize: Size(designWidth, designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    ScreenUtil.init(context);
  }

  // 宽度适配
  static double setWidth(double width) {
    return width.w;
  }

  // 高度适配
  static double setHeight(double height) {
    return height.h;
  }

  // 字体适配（基于宽度或最小值）
  static double setSp(double fontSize) {
    return fontSize.sp;
  }
}

/// 扩展方法，支持 `11.bw`、`11.bh`、`11.bsp`
extension DoubleExtension on num {
  /// 宽度适配（BetterScreenUtil.setWidth）
  double get bw => BetterScreenUtil.setWidth(toDouble());

  /// 高度适配（BetterScreenUtil.setHeight）
  double get bh => BetterScreenUtil.setHeight(toDouble());

  /// 字体适配（BetterScreenUtil.setSp）
  double get bsp => BetterScreenUtil.setSp(toDouble());
}
