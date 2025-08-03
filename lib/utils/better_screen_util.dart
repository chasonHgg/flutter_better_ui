import 'package:flutter/material.dart';

class BetterScreenUtil {
  static late MediaQueryData _mediaQuery;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _designWidth;
  static late double _designHeight;
  static late bool _minTextAdapt;
  static late bool _enableScaleWH;
  //顶部安全区域高度
  static late double _safeAreaTopHeight;
  //底部安全区域高度
  static late double _safeAreaBottomHeight;

  /// 初始化（必须在 MaterialApp 之后调用）
  static void init({
    required BuildContext context,
    required double designWidth,
    required double designHeight,
    bool minTextAdapt = true,
    bool enableScaleWH = true,
  }) {
    _mediaQuery = MediaQuery.of(context);
    _screenWidth = _mediaQuery.size.width;
    _screenHeight = _mediaQuery.size.height;
    _designWidth = designWidth;
    _designHeight = designHeight;
    _minTextAdapt = minTextAdapt;
    _enableScaleWH = enableScaleWH;
    _safeAreaTopHeight = _mediaQuery.padding.top;
    _safeAreaBottomHeight = _mediaQuery.padding.bottom;
  }

  /// 基于宽度的比例缩放
  static double scaleWidth(double width) {
    if (!_enableScaleWH) return width;
    return (width * _screenWidth) / _designWidth;
  }

  /// 基于高度的比例缩放
  static double scaleHeight(double height) {
    if (!_enableScaleWH) return height;
    return (height * _screenHeight) / _designHeight;
  }

  /// 基于更小边的比例缩放（避免拉伸）
  static double scaleRadius(double size) {
    if (!_enableScaleWH) return size;
    final scale = (_screenWidth / _designWidth < _screenHeight / _designHeight)
        ? _screenWidth / _designWidth
        : _screenHeight / _designHeight;
    return size * scale;
  }

  /// 字体大小适配（可配置是否基于最小值）
  static double scaleFont(double fontSize) {
    if (_minTextAdapt) {
      return scaleRadius(fontSize);
    }
    return scaleWidth(fontSize);
  }

  //屏幕高度
  static double get screenHeight => _screenHeight;

  //屏幕宽度
  static double get screenWidth => _screenWidth;

  //顶部安全区域高度
  static double get safeAreaTopHeight => _safeAreaTopHeight;

  //底部安全区域高度
  static double get safeAreaBottomHeight => _safeAreaBottomHeight;
}

/// 扩展方法（支持 `11.bw`、`11.bh`、`11.br`、`11.bsp`）
extension BetterScreenUtilExtension on num {
  /// 宽度适配（基于设计图宽度）
  double get bw => BetterScreenUtil.scaleWidth(toDouble());

  /// 高度适配（基于设计图高度）
  double get bh => BetterScreenUtil.scaleHeight(toDouble());

  /// 更小边适配（避免拉伸）
  double get br => BetterScreenUtil.scaleRadius(toDouble());

  /// 字体适配（可配置是否基于最小值）
  double get bsp => BetterScreenUtil.scaleFont(toDouble());
}
