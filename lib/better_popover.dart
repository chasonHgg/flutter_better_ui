import 'package:flutter/material.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/theme/child_themes/better_popover_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

enum BetterPopoverPlacement {
  top,
  topStart,
  topEnd,
  bottom,
  bottomStart,
  bottomEnd,
  left,
  leftStart,
  leftEnd,
  right,
  rightStart,
  rightEnd,
}

@immutable
class BetterPopoverAction {
  const BetterPopoverAction({
    required this.text,
    this.icon,
    this.disabled = false,
    this.textColor,
  });

  final String text;
  final Widget? icon;
  final bool disabled;
  final Color? textColor;
}

class BetterPopover extends StatefulWidget {
  const BetterPopover({
    super.key,
    required this.child,
    this.actions = const [],
    this.content,
    this.placement = BetterPopoverPlacement.bottom,
    this.visible,
    this.onVisibleChanged,
    this.onSelect,
    this.closeOnClickAction = true,
    this.closeOnClickOutside = true,
    this.showArrow = true,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 100),
    this.overlay = false,
    this.width,
    this.offset,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
  });

  final Widget child;
  final List<BetterPopoverAction> actions;
  final Widget? content;
  final BetterPopoverPlacement placement;
  final bool? visible;
  final ValueChanged<bool>? onVisibleChanged;
  final ValueChanged<BetterPopoverAction>? onSelect;
  final bool closeOnClickAction;
  final bool closeOnClickOutside;
  final bool showArrow;
  final bool enableAnimation;
  final Duration animationDuration;
  final bool overlay;
  final double? width;
  final double? offset;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  @override
  State<BetterPopover> createState() => _BetterPopoverState();
}

class _BetterPopoverState extends State<BetterPopover>
    with SingleTickerProviderStateMixin {
  final LayerLink _link = LayerLink();
  final GlobalKey _targetKey = GlobalKey();
  final GlobalKey _panelKey = GlobalKey();
  OverlayEntry? _entry;
  bool _visible = false;
  bool _placementResolved = false;
  bool _isHiding = false;
  Offset _arrowTargetOffset = Offset.zero;
  final Set<String> _rejectedSides = <String>{};
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late BetterPopoverPlacement _effectivePlacement = widget.placement;

  bool get _isVisible => widget.visible ?? _visible;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
        // The controller value runs from 1 to 0 while closing. Using the
        // same curve produces the exact time-reversed opening trajectory.
        reverseCurve: Curves.easeOutCubic,
      ),
    );
    if (widget.visible == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _show();
      });
    }
  }

  @override
  void didUpdateWidget(covariant BetterPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = widget.animationDuration;
    }
    if (widget.visible != oldWidget.visible) {
      widget.visible == true ? _show() : _hide(notify: false);
    } else {
      _entry?.markNeedsBuild();
    }
  }

  @override
  void dispose() {
    _entry?.remove();
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() => _isVisible ? _hide() : _show();

  void _show() {
    if (_entry != null) return;
    final box = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (box == null || overlay == null) return;
    final origin = box.localToGlobal(Offset.zero);
    final target = origin & box.size;
    _effectivePlacement = widget.placement;
    _placementResolved = false;
    _isHiding = false;
    _rejectedSides.clear();
    _animationController.reset();
    if (widget.visible == null) _visible = true;
    _entry = OverlayEntry(builder: (context) => _buildOverlay(context, target));
    overlay.insert(_entry!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _entry != null) _updatePlacement(target);
    });
    widget.onVisibleChanged?.call(true);
  }

  void _updatePlacement(Rect target) {
    final box = _panelKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    final screenSize = mediaQuery.size;
    final gap = widget.offset ?? 8.bw;
    final current = widget.placement;
    final isVertical =
        current.name.startsWith('top') || current.name.startsWith('bottom');
    final arrowExtent = widget.showArrow ? 7.bw : 0.0;
    final panelWidth = box.size.width - (isVertical ? 0 : arrowExtent);
    final panelHeight = box.size.height - (isVertical ? arrowExtent : 0);
    final boundaryMargin = 8.bw;
    final availableTop = target.top - padding.top - boundaryMargin;
    final availableBottom =
        screenSize.height - padding.bottom - boundaryMargin - target.bottom;
    final availableLeft = target.left - padding.left - boundaryMargin;
    final availableRight =
        screenSize.width - padding.right - boundaryMargin - target.right;
    final available = <String, double>{
      'top': availableTop,
      'bottom': availableBottom,
      'left': availableLeft,
      'right': availableRight,
    };
    final required = <String, double>{
      'top': panelHeight + arrowExtent + gap,
      'bottom': panelHeight + arrowExtent + gap,
      'left': panelWidth + arrowExtent + gap,
      'right': panelWidth + arrowExtent + gap,
    };
    final currentSide = _placementSide(current);
    var next = current;
    if (available[currentSide]! < required[currentSide]!) {
      final opposite = _placementSide(_oppositePlacement(current));
      final perpendicular = isVertical
          ? <String>['left', 'right']
          : <String>['top', 'bottom'];
      final candidates = <String>[opposite, ...perpendicular];
      final fitting = candidates
          .where((side) => available[side]! >= required[side]!)
          .toList();
      final selected = (fitting.isNotEmpty ? fitting : candidates).reduce(
        (a, b) => available[a]! / required[a]! >= available[b]! / required[b]!
            ? a
            : b,
      );
      next = _placementForSide(current, selected);
    }
    _effectivePlacement = next;
    _entry?.markNeedsBuild();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _entry != null) _resolveArrowPosition(target);
    });
  }

  void _resolveArrowPosition(Rect target) {
    final box = _panelKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final origin = box.localToGlobal(Offset.zero);
    final popupRect = origin & box.size;
    final gap = widget.offset ?? 8.bw;
    if (popupRect.overlaps(target.inflate(gap * 0.9)) &&
        _rejectedSides.length < 3) {
      final currentSide = _placementSide(_effectivePlacement);
      _rejectedSides.add(currentSide);
      final oppositeSide = _placementSide(
        _oppositePlacement(_effectivePlacement),
      );
      final isVertical = currentSide == 'top' || currentSide == 'bottom';
      final candidates = <String>[
        oppositeSide,
        ...(isVertical ? <String>['left', 'right'] : <String>['top', 'bottom']),
      ];
      final nextSide = candidates.firstWhere(
        (side) => !_rejectedSides.contains(side),
        orElse: () => oppositeSide,
      );
      _effectivePlacement = _placementForSide(_effectivePlacement, nextSide);
      _entry?.markNeedsBuild();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _entry != null) _resolveArrowPosition(target);
      });
      return;
    }
    _arrowTargetOffset = target.center - origin;
    _placementResolved = true;
    _entry?.markNeedsBuild();
    if (widget.enableAnimation) {
      _animationController.forward(from: 0);
    }
  }

  BetterPopoverPlacement _oppositePlacement(BetterPopoverPlacement placement) {
    return switch (placement) {
      BetterPopoverPlacement.top => BetterPopoverPlacement.bottom,
      BetterPopoverPlacement.topStart => BetterPopoverPlacement.bottomStart,
      BetterPopoverPlacement.topEnd => BetterPopoverPlacement.bottomEnd,
      BetterPopoverPlacement.bottom => BetterPopoverPlacement.top,
      BetterPopoverPlacement.bottomStart => BetterPopoverPlacement.topStart,
      BetterPopoverPlacement.bottomEnd => BetterPopoverPlacement.topEnd,
      BetterPopoverPlacement.left => BetterPopoverPlacement.right,
      BetterPopoverPlacement.leftStart => BetterPopoverPlacement.rightStart,
      BetterPopoverPlacement.leftEnd => BetterPopoverPlacement.rightEnd,
      BetterPopoverPlacement.right => BetterPopoverPlacement.left,
      BetterPopoverPlacement.rightStart => BetterPopoverPlacement.leftStart,
      BetterPopoverPlacement.rightEnd => BetterPopoverPlacement.leftEnd,
    };
  }

  String _placementSide(BetterPopoverPlacement placement) {
    final name = placement.name;
    if (name.startsWith('top')) return 'top';
    if (name.startsWith('bottom')) return 'bottom';
    if (name.startsWith('left')) return 'left';
    return 'right';
  }

  BetterPopoverPlacement _placementForSide(
    BetterPopoverPlacement placement,
    String side,
  ) {
    final suffix = placement.name.endsWith('Start')
        ? 'Start'
        : placement.name.endsWith('End')
        ? 'End'
        : '';
    return BetterPopoverPlacement.values.firstWhere(
      (value) => value.name == '$side$suffix',
    );
  }

  void _hide({bool notify = true}) {
    final entry = _entry;
    if (entry == null || _isHiding) return;
    if (widget.enableAnimation &&
        _placementResolved &&
        _animationController.value > 0) {
      _isHiding = true;
      entry.markNeedsBuild();
      if (notify) widget.onVisibleChanged?.call(false);
      _animationController.reverse().whenComplete(() {
        if (mounted && identical(_entry, entry)) {
          _removeOverlay(entry);
        }
      });
      return;
    }
    _removeOverlay(entry, notify: notify);
  }

  void _removeOverlay(OverlayEntry entry, {bool notify = false}) {
    entry.remove();
    _entry = null;
    _isHiding = false;
    if (widget.visible == null && mounted) _visible = false;
    if (notify) widget.onVisibleChanged?.call(false);
  }

  Widget _buildOverlay(BuildContext context, Rect target) {
    final theme = Theme.of(context).extension<BetterThemeExtension>();
    final popoverTheme = theme?.popoverTheme ?? _fallbackTheme(context);
    final color = widget.backgroundColor ?? popoverTheme.backgroundColor;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.closeOnClickOutside ? _hide : null,
            child: ColoredBox(
              color: widget.overlay
                  ? popoverTheme.overlayColor
                  : Colors.transparent,
            ),
          ),
        ),
        CustomSingleChildLayout(
          delegate: _PopoverLayoutDelegate(
            target: target,
            placement: _effectivePlacement,
            gap: widget.offset ?? 8.bw,
            padding: MediaQuery.paddingOf(context),
          ),
          child: IgnorePointer(
            ignoring: !_placementResolved || _isHiding,
            child: Opacity(
              opacity: _placementResolved ? 1 : 0,
              child: ScaleTransition(
                scale: widget.enableAnimation && _placementResolved
                    ? _scaleAnimation
                    : const AlwaysStoppedAnimation<double>(1),
                alignment: _scaleAlignment,
                child: RepaintBoundary(
                  child: Material(
                    key: _panelKey,
                    color: Colors.transparent,
                    child: _PopoverPanel(
                      placement: _effectivePlacement,
                      arrowTargetOffset: _arrowTargetOffset,
                      showArrow: widget.showArrow,
                      color: color,
                      width: widget.width,
                      borderRadius: popoverTheme.borderRadius,
                      shadowColor: popoverTheme.shadowColor,
                      child: Padding(
                        padding: widget.padding,
                        child: widget.content ?? _buildActions(popoverTheme),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Alignment get _scaleAlignment {
    final name = _effectivePlacement.name;
    if (name.startsWith('top')) return Alignment.bottomCenter;
    if (name.startsWith('bottom')) return Alignment.topCenter;
    if (name.startsWith('left')) return Alignment.centerRight;
    return Alignment.centerLeft;
  }

  Widget _buildActions(BetterPopoverTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.actions.length, (index) {
        final action = widget.actions[index];
        final color = action.disabled
            ? theme.disabledTextColor
            : action.textColor ?? theme.textColor;
        return InkWell(
          onTap: action.disabled
              ? null
              : () {
                  widget.onSelect?.call(action);
                  if (widget.closeOnClickAction) _hide();
                },
          child: Container(
            height: theme.actionHeight,
            padding: EdgeInsets.symmetric(horizontal: 12.bw),
            decoration: index == 0
                ? null
                : BoxDecoration(
                    border: Border(top: BorderSide(color: theme.dividerColor)),
                  ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (action.icon != null) ...[
                  IconTheme(
                    data: IconThemeData(color: color, size: theme.iconSize),
                    child: action.icon!,
                  ),
                  SizedBox(width: 8.bw),
                ],
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    action.text,
                    style: TextStyle(color: color, fontSize: theme.fontSize),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  BetterPopoverTheme _fallbackTheme(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BetterPopoverTheme(
      backgroundColor: colors.surface,
      textColor: colors.onSurface,
      disabledTextColor: colors.onSurface.withAlpha(97),
      dividerColor: colors.outlineVariant,
      overlayColor: Colors.black.withAlpha(80),
      shadowColor: Colors.black.withAlpha(50),
      borderRadius: 8.bw,
      actionHeight: 40.bw,
      fontSize: 13.bsp,
      iconSize: 18.bw,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        key: _targetKey,
        behavior: HitTestBehavior.opaque,
        onTap: _toggle,
        child: IgnorePointer(child: widget.child),
      ),
    );
  }
}

class _PopoverPanel extends StatelessWidget {
  const _PopoverPanel({
    required this.placement,
    required this.arrowTargetOffset,
    required this.showArrow,
    required this.color,
    required this.width,
    required this.borderRadius,
    required this.shadowColor,
    required this.child,
  });

  final BetterPopoverPlacement placement;
  final Offset arrowTargetOffset;
  final bool showArrow;
  final Color color;
  final double? width;
  final double borderRadius;
  final Color shadowColor;
  final Widget child;

  bool get _vertical =>
      placement.name.startsWith('top') || placement.name.startsWith('bottom');
  bool get _before =>
      placement.name.startsWith('bottom') || placement.name.startsWith('right');
  Widget _positionVerticalArrow(Widget arrow) {
    return Positioned(
      top: _before ? 1.bw : null,
      bottom: _before ? null : 1.bw,
      left: arrowTargetOffset.dx - 6.bw,
      child: arrow,
    );
  }

  Widget _positionHorizontalArrow(Widget arrow) {
    return Positioned(
      left: _before ? 1.bw : null,
      right: _before ? null : 1.bw,
      top: arrowTargetOffset.dy - 6.bw,
      child: arrow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final panel = Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12.bw,
            offset: Offset(0, 4.bw),
          ),
        ],
      ),
      child: child,
    );
    if (!showArrow) return panel;
    final arrow = CustomPaint(
      size: Size(12.bw, 7.bw),
      painter: _ArrowPainter(color, _before),
    );
    if (_vertical) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _before
                ? [SizedBox(height: 7.bw), panel]
                : [panel, SizedBox(height: 7.bw)],
          ),
          _positionVerticalArrow(arrow),
        ],
      );
    }
    final sideArrow = RotatedBox(quarterTurns: 3, child: arrow);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _before
              ? [SizedBox(width: 7.bw), panel]
              : [panel, SizedBox(width: 7.bw)],
        ),
        _positionHorizontalArrow(sideArrow),
      ],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter(this.color, this.pointsBack);
  final Color color;
  final bool pointsBack;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    if (pointsBack) {
      path
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2, 0)
        ..lineTo(size.width, size.height);
    } else {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.pointsBack != pointsBack;
}

class _PopoverLayoutDelegate extends SingleChildLayoutDelegate {
  const _PopoverLayoutDelegate({
    required this.target,
    required this.placement,
    required this.gap,
    required this.padding,
  });
  final Rect target;
  final BetterPopoverPlacement placement;
  final double gap;
  final EdgeInsets padding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      BoxConstraints(
        maxWidth: constraints.maxWidth - 16.bw,
        maxHeight: constraints.maxHeight - padding.vertical - 16.bw,
      );

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final name = placement.name;
    double x;
    double y;
    if (name.startsWith('top') || name.startsWith('bottom')) {
      x = name.endsWith('Start')
          ? target.right - childSize.width
          : name.endsWith('End')
          ? target.left
          : target.center.dx - childSize.width / 2;
      y = name.startsWith('top')
          ? target.top - childSize.height - gap
          : target.bottom + gap;
    } else {
      x = name.startsWith('left')
          ? target.left - childSize.width - gap
          : target.right + gap;
      y = name.endsWith('Start')
          ? target.top
          : name.endsWith('End')
          ? target.bottom - childSize.height
          : target.center.dy - childSize.height / 2;
    }
    return Offset(
      x.clamp(8.bw, size.width - childSize.width - 8.bw),
      y.clamp(
        padding.top + 8.bw,
        size.height - padding.bottom - childSize.height - 8.bw,
      ),
    );
  }

  @override
  bool shouldRelayout(covariant _PopoverLayoutDelegate oldDelegate) =>
      target != oldDelegate.target ||
      placement != oldDelegate.placement ||
      gap != oldDelegate.gap ||
      padding != oldDelegate.padding;
}
