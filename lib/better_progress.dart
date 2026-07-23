import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

/// Controls the value displayed by a [BetterProgress].
///
/// Values are always clamped to the range from 0 to 100.
class BetterProgressController extends ValueNotifier<double> {
  BetterProgressController({double initialValue = 0})
    : super(initialValue.clamp(0, 100).toDouble());

  /// Sets the progress to [value].
  void setValue(double value) {
    final nextValue = value.clamp(0, 100).toDouble();
    if (nextValue == this.value) return;
    this.value = nextValue;
  }

  /// Increases the progress by [amount].
  void increase([double amount = 10]) => setValue(value + amount);

  /// Decreases the progress by [amount].
  void decrease([double amount = 10]) => setValue(value - amount);
}

class BetterProgress extends StatelessWidget {
  const BetterProgress({
    super.key,
    this.percentage = 0,
    this.controller,
    this.strokeWidth,
    this.color,
    this.trackColor,
    this.showPivot = true,
    this.pivotText,
    this.pivotColor,
    this.pivotTextColor = Colors.white,
    this.pivotTextStyle,
    this.borderRadius,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOut,
  });

  /// Initial and externally controlled progress when no [controller] is used.
  final double percentage;

  /// Controller used to change progress programmatically.
  final BetterProgressController? controller;

  final double? strokeWidth;
  final Color? color;
  final Color? trackColor;
  final bool showPivot;
  final String? pivotText;
  final Color? pivotColor;
  final Color pivotTextColor;
  final TextStyle? pivotTextStyle;
  final BorderRadiusGeometry? borderRadius;
  final bool animated;
  final Duration animationDuration;
  final Curve animationCurve;

  String _label(double percentage) {
    if (pivotText != null) return pivotText!;
    final value = percentage % 1 == 0
        ? percentage.toInt().toString()
        : percentage.toStringAsFixed(1);
    return '$value%';
  }

  @override
  Widget build(BuildContext context) {
    if (controller case final progressController?) {
      return ValueListenableBuilder<double>(
        valueListenable: progressController,
        builder: (context, value, child) => _buildProgress(context, value),
      );
    }
    return _buildProgress(context, percentage);
  }

  Widget _buildProgress(BuildContext context, double value) {
    final normalizedValue = value.clamp(0, 100).toDouble();
    final finalStrokeWidth = strokeWidth ?? 4.bw;
    assert(finalStrokeWidth > 0, 'strokeWidth must be greater than zero');
    final theme = Theme.of(context);
    final activeColor = color ?? theme.colorScheme.primary;
    final radius = borderRadius ?? BorderRadius.circular(finalStrokeWidth);
    final duration = animated ? animationDuration : Duration.zero;
    final fraction = normalizedValue / 100;
    final label = _label(normalizedValue);

    return Semantics(
      label: 'Progress',
      value: label,
      child: SizedBox(
        height: showPivot
            ? finalStrokeWidth.clamp(20.bw, double.infinity)
            : finalStrokeWidth,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: finalStrokeWidth,
              decoration: BoxDecoration(
                color: trackColor ?? theme.colorScheme.surfaceContainerHighest,
                borderRadius: radius,
              ),
            ),
            AnimatedFractionallySizedBox(
              duration: duration,
              curve: animationCurve,
              widthFactor: fraction,
              child: Container(
                height: finalStrokeWidth,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: radius,
                ),
              ),
            ),
            if (showPivot)
              AnimatedAlign(
                duration: duration,
                curve: animationCurve,
                alignment: Alignment(fraction * 2 - 1, 0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: pivotColor ?? activeColor,
                    borderRadius: BorderRadius.circular(999.bw),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.bw,
                      vertical: 2.bw,
                    ),
                    child: Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10.bsp, height: 1.2)
                          .merge(pivotTextStyle)
                          .copyWith(
                            color: pivotTextStyle?.color ?? pivotTextColor,
                          ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
