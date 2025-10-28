import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

class BetterSwipeCellAction {
  /// 操作按钮的子组件
  final Widget child;

  /// 操作按钮的宽度
  double? width;

  /// 操作按钮的值
  final String? value;

  /// 操作按钮的点击回调
  final Future<bool> Function(String? value)? onClick;

  BetterSwipeCellAction({
    required this.child,
    this.width,
    this.value,
    this.onClick,
  }) {
    width ??= 80.bw;
  }
}

class BetterSwipeCell extends StatefulWidget {
  /// 可滑动内容的子组件
  final Widget child;

  /// 滑动动画的持续时间
  final Duration? duration;

  /// 左侧操作按钮
  final List<BetterSwipeCellAction> leftActions;

  /// 右侧操作按钮
  final List<BetterSwipeCellAction> rightActions;

  /// 是否在滑动时拉伸操作按钮宽度
  final bool isStretch;

  const BetterSwipeCell({
    super.key,
    required this.child,
    this.duration,
    this.leftActions = const [],
    this.rightActions = const [],
    this.isStretch = false,
  });

  @override
  State<BetterSwipeCell> createState() => _BetterSwipeCellState();
}

class _BetterSwipeCellState extends State<BetterSwipeCell>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _dragOffset = ValueNotifier<double>(0);
  double _maxLeftOffset = 0;
  double _maxRightOffset = 0;
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;

  bool _isExpand = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(milliseconds: 400),
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );
    _maxLeftOffset = widget.leftActions.isNotEmpty
        ? _calculateActionsWidth(widget.leftActions)
        : 0;
    _maxRightOffset = widget.rightActions.isNotEmpty
        ? _calculateActionsWidth(widget.rightActions)
        : 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    _dragOffset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // 左侧操作按钮的最终正确实现
          if (widget.leftActions.isNotEmpty)
            ValueListenableBuilder(
              valueListenable: _dragOffset,
              builder: (context, value, child) {
                final progress = value / _maxLeftOffset;
                return Positioned(
                  left: widget.isStretch
                      ? 1 - progress.clamp(0, 1)
                      : -_maxLeftOffset + value,
                  top: 0,
                  bottom: 0,
                  width: _maxLeftOffset,
                  child: Row(
                    children: widget.leftActions.map((e) {
                      return GestureDetector(
                        onTap: () async {
                          final result = await e.onClick?.call(e.value);
                          if (result == true) {
                            _animateTo(0);
                            _isExpand = false;
                          }
                        },
                        child: SizedBox(
                          width: widget.isStretch
                              ? e.width! * progress.clamp(0, 1)
                              : e.width,
                          child: OverflowBox(
                            maxWidth: e.width,
                            alignment: Alignment.centerLeft,
                            child: e.child,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

          // 右侧操作按钮
          if (widget.rightActions.isNotEmpty)
            ValueListenableBuilder(
              valueListenable: _dragOffset,
              builder: (context, value, child) {
                final progress = (-value) / _maxRightOffset;
                return Positioned(
                  right: widget.isStretch
                      ? -_maxRightOffset * (1 - progress.clamp(0, 1))
                      : -_maxRightOffset - value,
                  top: 0,
                  bottom: 0,
                  width: _maxRightOffset,
                  child: Row(
                    children: widget.rightActions.map((e) {
                      return GestureDetector(
                        onTap: () async {
                          final result = await e.onClick?.call(e.value);
                          if (result == true) {
                            _animateTo(0);
                            _isExpand = false;
                          }
                        },
                        child: SizedBox(
                          width: widget.isStretch
                              ? e.width! * progress.clamp(0, 1)
                              : e.width,
                          child: OverflowBox(
                            maxWidth: e.width,
                            alignment: Alignment.centerLeft,
                            child: e.child,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

          // 可滑动内容
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              _dragOffset.value += details.delta.dx;
              // 限制滑动范围
              if (_dragOffset.value > 0) {
                _dragOffset.value = _dragOffset.value.clamp(0, _maxLeftOffset);
              } else {
                _dragOffset.value = _dragOffset.value.clamp(
                  -_maxRightOffset,
                  0,
                );
              }
            },
            onHorizontalDragEnd: (details) {
              // 根据滑动速度和位置决定是否完全展开或收起
              final isLeft = _dragOffset.value > 0;
              if (!_isExpand &&
                  _dragOffset.value.abs() >
                      (isLeft ? _maxLeftOffset : _maxRightOffset) * 0.2) {
                _animateTo(isLeft ? _maxLeftOffset : -_maxRightOffset);
                _isExpand = true;
              } else {
                _animateTo(0);
                _isExpand = false;
              }
            },
            child: ValueListenableBuilder(
              valueListenable: _dragOffset,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: widget.child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 计算操作按钮的总宽度
  double _calculateActionsWidth(List<BetterSwipeCellAction> actions) {
    return actions.fold(0, (sum, action) => sum + action.width!);
  }

  void _animateTo(double target) {
    final animation = Tween<double>(
      begin: _dragOffset.value,
      end: target,
    ).animate(_curvedAnimation);

    animation.addListener(() {
      _dragOffset.value = animation.value;
    });

    _controller.reset();
    _controller.forward();
  }
}
