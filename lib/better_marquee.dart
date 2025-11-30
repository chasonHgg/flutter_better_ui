import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_swiper.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';

class BetterMarquee extends StatefulWidget {
  final List<String> textList;
  final TextStyle? style;
  final double speed;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final EdgeInsetsGeometry? padding;
  final String? separtor;
  final bool isVertical;
  final Duration? autoplayDuration;

  const BetterMarquee({
    super.key,
    required this.textList,
    this.style,
    this.speed = 60,
    this.width,
    required this.height,
    this.backgroundColor,
    this.textColor,
    this.leftWidget,
    this.rightWidget,
    this.padding,
    this.separtor = " ",
    this.isVertical = false,
    this.autoplayDuration = const Duration(seconds: 3),
  });

  @override
  State<BetterMarquee> createState() => _BetterMarqueeState();
}

class _BetterMarqueeState extends State<BetterMarquee>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  double _textWidth = 0;
  double _parentWidth = 0;

  ValueNotifier<double> _offset = ValueNotifier<double>(0);

  String _fullText = "";

  // 新增：用于判断是否需要重新计算文本宽度和启动动画
  bool _needsLayout = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isVertical) {
      _fullText = _getText(widget.textList);
    }
  }

  @override
  void dispose() {
    // 确保控制器被正确释放
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BetterMarquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当文本列表改变时
    if (!widget.isVertical && _fullText != _getText(oldWidget.textList)) {
      _fullText = _getText(widget.textList);
      // 标记为需要重新布局和启动动画
      _needsLayout = true;
      // 立即停止当前动画
      _stopAnimation();
    }
  }

  String _getText(List<String> textList) {
    return textList.join(widget.separtor ?? "");
  }

  // 建议将文本宽度计算放在一个单独的方法里，并且只在需要时调用
  void _calculateTextWidth(BuildContext context) {
    final span = TextSpan(text: _fullText, style: widget.style);
    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr, // 或根据你的需求设置为rtl
      maxLines: 1,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    _textWidth = textPainter.width;
  }

  // 整合动画启动逻辑，确保使用最新的参数
  void _startOrRestartAnimation() {
    // 如果父容器宽度或文本宽度为0，则不启动动画
    if (_parentWidth == 0 || _textWidth == 0) {
      return;
    }

    // 停止并释放旧的控制器
    _stopAnimation();

    // 计算动画时长 (距离 / 速度)
    double duration = (_textWidth + _parentWidth) / widget.speed;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (duration * 1000).toInt()),
    );

    _animation = Tween<double>(
      begin: _parentWidth, // 从右侧开始（父容器右侧外）
      end: -_textWidth, // 到左侧结束（文字完全离开左侧）
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    _animation!.addListener(() {
      if (mounted) {
        _offset.value = _animation!.value;
      }
    });

    _controller!.repeat();
  }

  void _stopAnimation() {
    if (_controller?.isAnimating ?? false) {
      _controller!.stop();
    }
    _controller?.dispose();
    _controller = null;
    _animation = null;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = (widget.style ?? TextStyle()).copyWith(
      color: widget.textColor ?? ColorUtil.hexToColor("#ed6a0c"),
    );

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      color: widget.backgroundColor ?? ColorUtil.hexToColor("#fffbe8"),
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 15.bw),
      child: Row(
        children: [
          if (widget.leftWidget != null)
            Padding(
              padding: EdgeInsets.only(right: 8.bw),
              child: widget.leftWidget!,
            ),
          // 使用 Expanded 和 LayoutBuilder 来获取可用宽度
          if (!widget.isVertical)
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // 只有当父容器宽度改变或需要重新布局时，才执行 expensive 操作
                  if (constraints.maxWidth != _parentWidth || _needsLayout) {
                    _parentWidth = constraints.maxWidth;
                    _calculateTextWidth(context); // 在这里计算宽度，确保使用最新的_fullText
                    _needsLayout = false; // 重置标记
                    _startOrRestartAnimation(); // 使用最新的参数启动/重启动画
                  }

                  return Stack(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _offset,
                        builder: (context, value, child) {
                          return Positioned(
                            left: value,
                            top: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_fullText, style: textStyle),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          if (widget.isVertical)
            Expanded(
              child: BetterSwiper(
                controller: PageController(),
                scrollDirection: Axis.vertical,
                showIndicator: false,
                height: widget.height,
                autoplayDuration:
                    widget.autoplayDuration ?? const Duration(seconds: 3),
                children: widget.textList
                    .map(
                      (e) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e,
                          style: textStyle.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          if (widget.rightWidget != null)
            Padding(
              padding: EdgeInsets.only(left: 8.bw),
              child: widget.rightWidget!,
            ),
        ],
      ),
    );
  }
}
