import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 骨架屏上下文配置。
///
/// 子组件可以通过 [BetterSkeletonConfig.maybeOf] 读取当前骨架状态和视觉配置。
@immutable
class BetterSkeletonConfig {
  final bool enabled;
  final Color baseColor;
  final BorderRadius textBorderRadius;
  final BorderRadius defaultBorderRadius;
  final int repaintTick;

  const BetterSkeletonConfig({
    required this.enabled,
    required this.baseColor,
    required this.textBorderRadius,
    required this.defaultBorderRadius,
    required this.repaintTick,
  });

  static BetterSkeletonConfig? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_BetterSkeletonScope>()
        ?.config;
  }

  static BetterSkeletonConfig of(BuildContext context) {
    final config = maybeOf(context);
    assert(config != null, 'No BetterSkeletonizer found in context.');
    return config!;
  }
}

/// 像 skeletonizer 一样包裹页面或列表区域，开启后自动以灰色骨架替代原绘制。
///
/// 组件仍使用 Flutter 原生布局、ListView/Sliver 懒构建与懒绘制机制；未构建或未进入绘制
/// 流程的列表项不会额外生成骨架。
class BetterSkeletonizer extends StatefulWidget {
  final bool enabled;
  final Widget child;

  /// 自定义骨架颜色。为空时会根据当前主题亮暗模式自动选择颜色。
  final Color? baseColor;

  /// 浅色模式下的默认骨架颜色。
  final Color lightBaseColor;

  /// 深色模式下的默认骨架颜色。
  final Color darkBaseColor;

  final Duration fadeDuration;
  final double minOpacity;
  final double maxOpacity;
  final BorderRadius textBorderRadius;
  final BorderRadius defaultBorderRadius;

  /// enabled 时是否忽略子树手势。
  ///
  /// 默认保留手势命中，避免 ListView、GridView 等滚动容器在骨架状态下无法滚动。
  final bool ignorePointers;

  const BetterSkeletonizer({
    super.key,
    required this.enabled,
    required this.child,
    this.baseColor,
    this.lightBaseColor = const Color(0xFFD9DDE3),
    this.darkBaseColor = const Color(0xFF4B5563),
    this.fadeDuration = const Duration(milliseconds: 900),
    this.minOpacity = 0.65,
    this.maxOpacity = 1,
    this.textBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.defaultBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.ignorePointers = false,
  }) : assert(minOpacity >= 0 && minOpacity <= 1),
       assert(maxOpacity >= 0 && maxOpacity <= 1),
       assert(minOpacity <= maxOpacity);

  @override
  State<BetterSkeletonizer> createState() => _BetterSkeletonizerState();
}

class _BetterSkeletonizerState extends State<BetterSkeletonizer>
    with SingleTickerProviderStateMixin {
  int _repaintTick = 0;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.fadeDuration,
  );

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant BetterSkeletonizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fadeDuration != widget.fadeDuration) {
      _controller.duration = widget.fadeDuration;
    }
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = BetterSkeletonConfig(
      enabled: widget.enabled,
      baseColor: widget.baseColor ?? _resolveBaseColor(context),
      textBorderRadius: widget.textBorderRadius,
      defaultBorderRadius: widget.defaultBorderRadius,
      repaintTick: _repaintTick,
    );

    Widget current = _BetterSkeletonScope(
      config: config,
      child: widget.enabled ? _buildPulseSkeleton(config) : widget.child,
    );

    if (widget.enabled && widget.ignorePointers) {
      current = IgnorePointer(child: current);
    }
    return current;
  }

  Color _resolveBaseColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      return widget.darkBaseColor;
    }
    return widget.lightBaseColor;
  }

  Widget _buildPulseSkeleton(BetterSkeletonConfig config) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.depth == 0) {
          setState(() {
            _repaintTick++;
          });
        }
        return false;
      },
      child: AnimatedBuilder(
        animation: _controller,
        child: _BetterSkeletonRender(config: config, child: widget.child),
        builder: (context, child) {
          final progress = Curves.easeInOut.transform(_controller.value);
          final opacity =
              widget.minOpacity +
              (widget.maxOpacity - widget.minOpacity) * progress;
          return Opacity(opacity: opacity, child: child);
        },
      ),
    );
  }
}

class _BetterSkeletonScope extends InheritedWidget {
  final BetterSkeletonConfig config;

  const _BetterSkeletonScope({required this.config, required super.child});

  @override
  bool updateShouldNotify(covariant _BetterSkeletonScope oldWidget) {
    return config.enabled != oldWidget.config.enabled ||
        config.baseColor != oldWidget.config.baseColor ||
        config.textBorderRadius != oldWidget.config.textBorderRadius ||
        config.defaultBorderRadius != oldWidget.config.defaultBorderRadius ||
        config.repaintTick != oldWidget.config.repaintTick;
  }
}

class _BetterSkeletonRender extends SingleChildRenderObjectWidget {
  final BetterSkeletonConfig config;

  const _BetterSkeletonRender({required this.config, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBetterSkeleton(config);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderBetterSkeleton renderObject,
  ) {
    renderObject.config = config;
  }
}

class _RenderBetterSkeleton extends RenderProxyBox {
  BetterSkeletonConfig _config;

  _RenderBetterSkeleton(this._config);

  set config(BetterSkeletonConfig value) {
    if (_config == value) {
      return;
    }
    _config = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (!_config.enabled || child == null) {
      super.paint(context, offset);
      return;
    }

    final bones = <_SkeletonBone>[];
    _collectBones(child!, bones);
    bones.sort((a, b) => b.area.compareTo(a.area));

    final canvas = context.canvas;
    final clipRect = offset & size;
    canvas.save();
    canvas.clipRect(clipRect);
    final paint = Paint()..color = _config.baseColor;
    for (final bone in bones) {
      paint.color = _config.baseColor.withValues(alpha: bone.opacity);
      canvas.drawRRect(bone.rrect.shift(offset), paint);
    }
    canvas.restore();
  }

  void _collectBones(RenderObject node, List<_SkeletonBone> bones) {
    if (node is RenderBox &&
        node != this &&
        node.hasSize &&
        !node.size.isEmpty) {
      final visual = _visualFor(node);
      if (visual != null) {
        bones.addAll(visual);
      }
    }

    node.visitChildren((child) {
      _collectBones(child, bones);
    });
  }

  List<_SkeletonBone>? _visualFor(RenderBox box) {
    final rect = _rectInSelf(box);
    if (rect == null || rect.isEmpty || !_isUsefulRect(rect)) {
      return null;
    }

    if (box is RenderParagraph || box is RenderEditable) {
      return _textBones(rect, box);
    }

    if (box is RenderImage) {
      return [_SkeletonBone(_rrect(rect, _imageRadius(box)), 1)];
    }

    if (box is RenderClipOval) {
      return [
        _SkeletonBone(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.shortestSide / 2)),
          1,
        ),
      ];
    }

    final radius = _radiusFor(box);
    if (radius != null) {
      return [_SkeletonBone(_rrect(rect, radius), 0.72)];
    }

    if (_looksLikeLeaf(box, rect)) {
      return [_SkeletonBone(_rrect(rect, _config.defaultBorderRadius), 1)];
    }

    return null;
  }

  Rect? _rectInSelf(RenderBox box) {
    try {
      final transform = box.getTransformTo(this);
      final rect = MatrixUtils.transformRect(transform, Offset.zero & box.size);
      if (!rect.left.isFinite ||
          !rect.top.isFinite ||
          !rect.right.isFinite ||
          !rect.bottom.isFinite) {
        return null;
      }
      return rect;
    } on FlutterError {
      return null;
    }
  }

  bool _isUsefulRect(Rect rect) {
    final rootRect = Offset.zero & size;
    if (!rect.overlaps(rootRect.inflate(16))) {
      return false;
    }
    if (rect.width < 2 || rect.height < 2) {
      return false;
    }
    final coversRoot =
        rect.width >= size.width * 0.92 && rect.height >= size.height * 0.92;
    return !coversRoot;
  }

  List<_SkeletonBone> _textBones(Rect rect, RenderBox box) {
    final lineHeight = _estimateTextLineHeight(box, rect.height);
    final lineCount = math.max(1, (rect.height / lineHeight).round());
    final effectiveLineHeight = rect.height / lineCount;
    final boneHeight = math.min(effectiveLineHeight * 0.68, 18).toDouble();
    final bones = <_SkeletonBone>[];

    for (var i = 0; i < lineCount; i++) {
      final top = rect.top + i * effectiveLineHeight;
      var width = rect.width;
      if (lineCount > 1 && i == lineCount - 1) {
        width = rect.width * 0.68;
      }
      final lineRect = Rect.fromLTWH(
        rect.left,
        top + (effectiveLineHeight - boneHeight) / 2,
        width.toDouble(),
        boneHeight,
      );
      bones.add(_SkeletonBone(_rrect(lineRect, _config.textBorderRadius), 1));
    }
    return bones;
  }

  double _estimateTextLineHeight(RenderBox box, double fallbackHeight) {
    return math.max(12, math.min(fallbackHeight, 20));
  }

  BorderRadius? _radiusFor(RenderBox box) {
    if (box is RenderDecoratedBox) {
      final decoration = box.decoration;
      if (decoration is BoxDecoration) {
        if (decoration.shape == BoxShape.circle) {
          return _circleRadius(box.size);
        }
        final borderRadius = decoration.borderRadius;
        if (borderRadius != null) {
          return borderRadius.resolve(TextDirection.ltr);
        }
        if (decoration.color != null ||
            decoration.gradient != null ||
            decoration.border != null) {
          return _config.defaultBorderRadius;
        }
      }
    }

    if (box is RenderPhysicalModel) {
      if (box.shape == BoxShape.circle) {
        return _circleRadius(box.size);
      }
      return box.borderRadius ?? _config.defaultBorderRadius;
    }

    if (box is RenderClipRRect) {
      return box.borderRadius.resolve(TextDirection.ltr);
    }

    return null;
  }

  BorderRadius _imageRadius(RenderImage box) {
    final size = box.size;
    if ((size.width - size.height).abs() < 0.5 && size.shortestSide <= 72) {
      return _circleRadius(size);
    }
    return _config.defaultBorderRadius;
  }

  BorderRadius _circleRadius(Size size) {
    return BorderRadius.circular(size.shortestSide / 2);
  }

  RRect _rrect(Rect rect, BorderRadius borderRadius) {
    return borderRadius.toRRect(rect);
  }

  bool _looksLikeLeaf(RenderBox box, Rect rect) {
    if (box.debugNeedsLayout || box is RenderProxyBox) {
      return false;
    }
    final isCompact = rect.width <= size.width * 0.65 && rect.height <= 80;
    final isIconSized = rect.shortestSide <= 40 && rect.longestSide <= 64;
    return isCompact || isIconSized;
  }
}

class _SkeletonBone {
  final RRect rrect;
  final double opacity;

  const _SkeletonBone(this.rrect, this.opacity);

  double get area => rrect.width * rrect.height;
}
