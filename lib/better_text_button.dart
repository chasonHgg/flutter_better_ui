import 'package:flutter/material.dart';

/// 一个轻量级的纯文本按钮，带有轻微的按下颜色反馈。
class BetterTextButton extends StatefulWidget {
  /// 按钮的文本
  final String text;

  /// 默认文本颜色。
  final Color? color;

  /// 按下时的文本颜色。
  final Color? activeColor;

  /// 按钮的文本样式
  final TextStyle? textStyle;

  /// 按钮的点击回调
  final VoidCallback? onPressed;

  /// 创建一个 [BetterTextButton]。
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
