import 'package:flutter/material.dart';

class BetterMarquee extends StatefulWidget {
  final List<String> textList;
  final TextStyle? style;
  final double speed;
  const BetterMarquee({
    super.key,
    required this.textList,
    this.style,
    this.speed = 60,
  });

  @override
  State<BetterMarquee> createState() => _BetterMarqueeState();
}

class _BetterMarqueeState extends State<BetterMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _textWidth = 0;
  double _parentWidth = 0;
  bool _isAnimation = false;
  double duration = 0;

  double _offset = 0;

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  String _getText() {
    return widget.textList.join('-');
  }

  double _getTextWidth(BuildContext context) {
    final span = TextSpan(text: _getText(), style: widget.style);

    final constraints = BoxConstraints(maxWidth: double.infinity);

    final richTextWidget = Text.rich(span).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);

    final boxes = renderObject.getBoxesForSelection(
      TextSelection(
        baseOffset: 0,
        extentOffset: TextSpan(text: _getText()).toPlainText().length,
      ),
    );
    return boxes.last.right;
  }

  void _startAnimation() {
    if (_isAnimation) return;
    _isAnimation = true;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (duration * 1000).toInt()),
    );
    _animation =
        Tween<double>(
          begin: _parentWidth, // 从右侧开始（父容器右侧外）
          end: -_textWidth, // 到左侧结束（文字完全离开左侧）
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.linear, // 匀速滚动
          ),
        );
    _animation.addListener(() {
      if (mounted) {
        setState(() {
          _offset = _animation.value;
        });
      }
    });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    _textWidth = _getTextWidth(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final parentWidth = constraints.maxWidth;
        if (parentWidth != _parentWidth) {
          _parentWidth = parentWidth;
          _offset = _parentWidth;
          duration = _textWidth / (widget.speed);
          _startAnimation();
        }

        return Container(
          color: Colors.blue,
          child: Stack(
            children: [
              Positioned(
                left: _offset,
                top: 0,
                bottom: 0,
                child: Text(_getText(), style: widget.style),
              ),
            ],
          ),
        );
      },
    );
  }
}
