import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

class BetterSlideActionController {
  VoidCallback? _reset;

  void reset() {
    _reset?.call();
  }

  void _attach(VoidCallback reset) {
    _reset = reset;
  }

  void _detach() {
    _reset = null;
  }
}

class BetterSlideAction extends StatefulWidget {
  final BetterSlideActionController? controller;
  final VoidCallback? onCompleted;
  final double? width;
  final double? height;
  final double? knobSize;
  final double? borderRadius;
  final bool resetAfterCompleted;
  final Widget? knobChild;
  final Widget? children;
  final bool enabled;
  final bool reverse;
  final Color? color;
  final BoxDecoration? boxDecoration;

  const BetterSlideAction({
    super.key,
    this.controller,
    this.onCompleted,
    this.width,
    this.height,
    this.knobSize,
    this.borderRadius,
    this.resetAfterCompleted = false,
    this.knobChild,
    this.children,
    this.enabled = true,
    this.reverse = false,
    this.boxDecoration,
    this.color,
  });

  @override
  State<BetterSlideAction> createState() => _BetterSlideActionState();
}

class _BetterSlideActionState extends State<BetterSlideAction> {
  final GlobalKey _buttonKey = GlobalKey();
  final ValueNotifier<double> _dragOffsetNotifier = ValueNotifier<double>(0);

  bool _completed = false;

  double get _height => widget.height ?? 50.bw;
  double get _knobSize => widget.knobSize ?? 34.bw;
  double get _radius => widget.borderRadius ?? _height / 2;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(reset);
  }

  @override
  void didUpdateWidget(covariant BetterSlideAction oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(reset);
    }
  }

  double _getMaxOffset(double horizontalPadding) {
    final box = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final width = box?.size.width ?? 0;

    return (width - _knobSize - horizontalPadding * 2).clamp(
      0.0,
      double.infinity,
    );
  }

  void reset() {
    _completed = false;
    _dragOffsetNotifier.value = 0;
  }

  void _updateDrag(double delta, double maxOffset) {
    if (!widget.enabled || _completed) return;

    final dragDelta = widget.reverse ? -delta : delta;

    _dragOffsetNotifier.value = (_dragOffsetNotifier.value + dragDelta).clamp(
      0,
      maxOffset,
    );
  }

  void _handleDragEnd(double maxOffset) {
    if (!widget.enabled || _completed) return;

    final isCompleted = _dragOffsetNotifier.value >= maxOffset * 0.82;

    _completed = isCompleted;
    _dragOffsetNotifier.value = isCompleted ? maxOffset : 0;

    if (isCompleted) {
      widget.onCompleted?.call();

      if (widget.resetAfterCompleted) {
        Future.delayed(const Duration(milliseconds: 450), () {
          if (!mounted) return;
          _completed = false;
          _dragOffsetNotifier.value = 0;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _dragOffsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? double.infinity;
    final horizontalPadding = 6.bw;
    final innerHeight = _height - horizontalPadding * 2;
    final knobTop = ((innerHeight - _knobSize) / 2).clamp(0.0, double.infinity);

    return SizedBox(
      key: _buttonKey,
      width: width,
      height: _height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: (details) {
          _updateDrag(details.delta.dx, _getMaxOffset(horizontalPadding));
        },
        onHorizontalDragEnd: (_) {
          _handleDragEnd(_getMaxOffset(horizontalPadding));
        },
        child: Container(
          padding: EdgeInsets.all(horizontalPadding),
          decoration:
              widget.boxDecoration ??
              BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(_radius),
              ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: widget.reverse
                    ? EdgeInsets.only(right: _knobSize / 2)
                    : EdgeInsets.only(left: _knobSize / 2),
                child: widget.children,
              ),
              Positioned(
                left: widget.reverse ? null : 0,
                right: widget.reverse ? 0 : null,
                top: knobTop,
                child: ValueListenableBuilder<double>(
                  valueListenable: _dragOffsetNotifier,
                  builder: (context, dragOffset, child) {
                    return Transform.translate(
                      offset: Offset(
                        widget.reverse ? -dragOffset : dragOffset,
                        0,
                      ),
                      child: child,
                    );
                  },
                  child: _SlideKnob(
                    size: _knobSize,
                    enabled: widget.enabled,
                    child: widget.knobChild,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlideKnob extends StatelessWidget {
  final double size;
  final bool enabled;
  final Widget? child;

  const _SlideKnob({required this.size, required this.enabled, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
