import 'dart:math';

import 'package:flutter/material.dart';

/// Painter that draws multiple fading line segments in a circular layout.
class SpinnerPainter extends CustomPainter {
  /// Progress (0~1)
  final double progress;

  /// Number of segments
  final int segmentCount;

  /// Line color
  final Color color;

  /// Line length (ratio of radius, 0~1)
  final double lineLength;

  /// Line width (pixels)
  final double lineWidth;

  SpinnerPainter({
    required this.progress,
    this.segmentCount = 10,
    this.color = Colors.white,
    //default length = 40% of radius
    this.lineLength = 0.4,
    //default width = 2 pixels
    this.lineWidth = 2,
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
        center.dx + radius * (1 - lineLength) * cos(angle),
        center.dy + radius * (1 - lineLength) * sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
