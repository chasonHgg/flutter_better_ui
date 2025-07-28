import 'dart:math';

import 'package:flutter/material.dart';

class SpinnerPainter extends CustomPainter {
  final double progress;
  final int segmentCount;
  final Color color;
  final double lineLength; // 线条长度（占半径的比例，0~1）
  final double lineWidth; // 线条宽度（像素）

  SpinnerPainter({
    required this.progress,
    this.segmentCount = 10,
    this.color = Colors.white,
    this.lineLength = 0.4, // 默认长度=半径的40%
    this.lineWidth = 2, // 默认宽度=2像素
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < segmentCount; i++) {
      final angle = 2 * pi * (i / segmentCount + progress);
      final alpha = (100 + 155 * (1 - i / segmentCount)).toInt();

      final paint = Paint()
        ..color = color.withAlpha(alpha)
        ..strokeWidth = lineWidth
        ..strokeCap = StrokeCap.round;

      // 动态计算线条起点和终点
      final start = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      final end = Offset(
        center.dx + radius * (1 - lineLength) * cos(angle), // 终点向内缩短
        center.dy + radius * (1 - lineLength) * sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
