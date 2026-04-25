import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

class BetterUi extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final Widget child;
  final double designWidth;
  final double designHeight;

  static BuildContext? get currentContext =>
      navigatorKey.currentContext;

  static OverlayState? get overlay {
    final navigatorOverlay = navigatorKey.currentState?.overlay;
    if (navigatorOverlay != null) {
      return navigatorOverlay;
    }
    return currentContext == null ? null : Overlay.maybeOf(currentContext!, rootOverlay: true);
  }

  const BetterUi({
    super.key,
    required this.child,
    this.designWidth = 375,
    this.designHeight = 812,
  });

  @override
  State<BetterUi> createState() => _BetterUiState();
}

class _BetterUiState extends State<BetterUi> {
  @override
  Widget build(BuildContext context) {
    BetterScreenUtil.init(
      context: context,
      designWidth: widget.designWidth,
      designHeight: widget.designHeight,
    );
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              BetterUtil.init(
                context,
                designWidth: widget.designWidth,
                designHeight: widget.designHeight,
              );
              return widget.child;
            },
          ),
        ],
      ),
    );
  }
}
