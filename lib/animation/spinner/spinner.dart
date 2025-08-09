import 'package:flutter_better_ui/animation/spinner/spinner_painter.dart';
import 'package:flutter/material.dart';

/// A custom rotating spinner used by `BetterButton` and other widgets.
class Spinner extends StatefulWidget {
  /// Size of the spinner
  final double? size;

  /// Duration of one full rotation
  final Duration duration;

  /// Color of the spinner
  final Color? color;

  /// Creates a [Spinner].
  const Spinner({
    super.key,
    this.size,
    this.duration = const Duration(milliseconds: 1100),
    this.color,
  });

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(); // 无限循环旋转
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size ?? 20,
          height: widget.size ?? 20,
          child: CustomPaint(
            painter: SpinnerPainter(
              progress: _controller.value,
              color: widget.color ?? Colors.white,
            ),
          ),
        );
      },
    );
  }
}
