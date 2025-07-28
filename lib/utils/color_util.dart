import 'package:flutter/material.dart';

class ColorUtil {
  /// 将十六进制颜色字符串转换为Color对象
  /// 支持格式: #RGB, #ARGB, #RRGGBB, #AARRGGBB
  /// [alpha] 可选参数，范围0.0-1.0，用于覆盖原始透明度（默认不覆盖）
  static Color hexToColor(String hexString, {double? alpha}) {
    // 验证alpha参数
    if (alpha != null && (alpha < 0.0 || alpha > 1.0)) {
      throw ArgumentError('Alpha must be between 0.0 and 1.0');
    }

    // 去除可能包含的空格和#号
    String hex = hexString.replaceFirst('#', '').trim();

    // 补全3位或4位颜色值
    if (hex.length == 3 || hex.length == 4) {
      final chars = hex.split('');
      hex = chars.map((c) => c * 2).join();
    }

    // 补全6位颜色值（添加默认不透明度FF）
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    // 确保长度是8位（AARRGGBB）
    if (hex.length != 8) {
      throw FormatException('Invalid color format: $hexString');
    }

    // 将字符串转换为整数
    final colorValue = int.tryParse(hex, radix: 16);
    if (colorValue == null) {
      throw FormatException('Invalid color format: $hexString');
    }

    // 处理透明度
    if (alpha != null) {
      // 保留RGB通道，替换Alpha通道
      final rgb = colorValue & 0x00FFFFFF;
      final newAlpha = (alpha * 255).round().clamp(0, 255);
      return Color(rgb | (newAlpha << 24));
    }

    return Color(colorValue);
  }
}
