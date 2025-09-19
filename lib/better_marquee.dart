import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';

class BetterMarquee extends StatefulWidget {
  final double? height;
  final Color? backgroundColor;
  const BetterMarquee({super.key, this.height, this.backgroundColor});

  @override
  State<BetterMarquee> createState() => _BetterMarqueeState();
}

class _BetterMarqueeState extends State<BetterMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    final lastHeight = widget.height ?? 40.bw;
    final lastBackgroundColor =
        widget.backgroundColor ?? ColorUtil.hexToColor('#fffbe8');
    return Container(height: lastHeight, color: lastBackgroundColor);
  }
}
