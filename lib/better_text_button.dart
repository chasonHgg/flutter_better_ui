import 'package:flutter/material.dart';

/// A lightweight text-only button with subtle pressed color feedback.
class BetterTextButton extends StatefulWidget {
  /// Text of the button
  final String text;

  /// Default text color.
  final Color? color;

  /// Text color when pressed.
  final Color? activeColor;
  final VoidCallback onPressed;

  /// Text style of the button
  final TextStyle? textStyle;

  /// Creates a [BetterTextButton].
  const BetterTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.activeColor,
    this.textStyle,
  });

  @override
  State<BetterTextButton> createState() => _BetterTextButtonState();
}

class _BetterTextButtonState extends State<BetterTextButton> {
  bool _isPressed = false; // 跟踪按下状态

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: Colors.transparent,
          overlayColor: Colors.transparent,
          // 根据按下状态切换颜色
          foregroundColor: _isPressed ? widget.activeColor : widget.color,
          // 添加动画使颜色过渡更平滑
          animationDuration: const Duration(milliseconds: 100),
        ),
        child: Text(widget.text, style: widget.textStyle),
      ),
    );
  }
}
