import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/theme/child_themes/better_popup_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';

enum BetterPopupPosition { top, bottom, left, right, center }

class BetterPopup {
  static void show(
    BuildContext context, {
    BetterPopupPosition position = BetterPopupPosition.bottom,
    Color? backgroundColor,
    double? width,
    double? height,
    Widget? child,
    BorderRadiusGeometry? borderRadius,
    bool isShowCloseIcon = false,
    double? closeIconSize,
    Color? closeIconColor,
    bool isDismissible = true,
    Widget? closeIcon,
    EdgeInsets? padding,
    final List<BoxShadow>? boxShadow,
    VoidCallback? onClose,
    bool? enableDrag,
  }) {
    if (position == BetterPopupPosition.bottom) {
      _showBottomPopup(
        context,
        backgroundColor: backgroundColor,
        height: height,
        width: width,
        child: child,
        borderRadius: borderRadius,
        isShowCloseIcon: isShowCloseIcon,
        closeIconSize: closeIconSize,
        closeIconColor: closeIconColor,
        isDismissible: isDismissible,
        closeIcon: closeIcon,
        padding: padding,
        boxShadow: boxShadow,
        onClose: onClose,
        enableDrag: enableDrag,
      );
      return;
    }
    _showPopup(
      context,
      position: position,
      backgroundColor: backgroundColor,
      height: height,
      width: width,
      child: child,
      borderRadius: borderRadius,
      isShowCloseIcon: isShowCloseIcon,
      closeIconSize: closeIconSize,
      closeIconColor: closeIconColor,
      isDismissible: isDismissible,
      closeIcon: closeIcon,
      padding: padding,
      boxShadow: boxShadow,
      onClose: onClose,
    );
  }

  static _showBottomPopup(
    BuildContext context, {
    Color? backgroundColor,
    double? height,
    double? width,
    Widget? child,
    BorderRadiusGeometry? borderRadius,
    required bool isShowCloseIcon,
    double? closeIconSize,
    Color? closeIconColor,
    required bool isDismissible,
    Widget? closeIcon,
    EdgeInsets? padding,
    final List<BoxShadow>? boxShadow,
    VoidCallback? onClose,
    bool? enableDrag,
  }) {
    BetterPopupTheme popupTheme = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.popupTheme;
    borderRadius ??= BorderRadius.only(
      topLeft: Radius.circular(16.bw),
      topRight: Radius.circular(16.bw),
    );

    width ??= BetterScreenUtil.screenWidth;

    List<Widget> children = [];
    if (child != null) {
      children.add(child);
    }

    if (closeIcon == null) {
      if (isShowCloseIcon == true) {
        children.add(
          Positioned(
            right: 16.bw,
            top: 16.bw,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                size: closeIconSize ?? popupTheme.closeIconSize,
                color: closeIconColor ?? popupTheme.closeIconColor,
              ),
            ),
          ),
        );
      }
    } else {
      children.add(closeIcon);
    }

    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag ?? true,
      builder: (context) => PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            onClose?.call();
          }
        },
        child: Container(
          width: width,
          height: height,
          padding: padding ?? popupTheme.padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            color: backgroundColor ?? popupTheme.backgroundColor,
          ),
          //关闭图标
          child: Stack(children: children),
        ),
      ),
    );
  }

  static _showPopup(
    BuildContext context, {
    required BetterPopupPosition position,
    Color? backgroundColor,
    double? height,
    double? width,
    Widget? child,
    BorderRadiusGeometry? borderRadius,
    required bool isShowCloseIcon,
    double? closeIconSize,
    Color? closeIconColor,
    required bool isDismissible,
    Widget? closeIcon,
    EdgeInsets? padding,
    final List<BoxShadow>? boxShadow,
    VoidCallback? onClose,
  }) {
    // 计算默认尺寸
    width ??= position == BetterPopupPosition.top
        ? BetterScreenUtil.screenWidth
        : BetterScreenUtil.screenWidth * 0.8;

    if (height == null) {
      if (position != BetterPopupPosition.center) {
        height = position == BetterPopupPosition.top
            ? 150.bw
            : BetterScreenUtil.screenHeight;
      } else {
        height = 150.bw;
      }
    }

    if (position == BetterPopupPosition.center) {
      borderRadius ??= BorderRadius.circular(16.bw);
    }

    final popupTheme = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.popupTheme;

    // 计算动画起始位置
    final Offset beginOffset = switch (position) {
      BetterPopupPosition.top => const Offset(0, -1),
      BetterPopupPosition.left => const Offset(-1, 0),
      BetterPopupPosition.right => const Offset(1, 0),
      BetterPopupPosition.center => const Offset(0, 0),
      _ => Offset.zero,
    };

    // 构建内容
    final content = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? popupTheme.backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Stack(
        children: [
          if (child != null) child,
          if (isShowCloseIcon && closeIcon == null)
            Positioned(
              right: 16.bw,
              top: BetterScreenUtil.safeAreaTopHeight > 0
                  ? BetterScreenUtil.safeAreaTopHeight
                  : 16.bw,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  size: closeIconSize ?? popupTheme.closeIconSize,
                  color: closeIconColor ?? popupTheme.closeIconColor,
                ),
              ),
            ),
          if (closeIcon != null) closeIcon,
        ],
      ),
    );

    Widget slideContent({required Animation<double> animation}) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(animation),
        child: Material(color: Colors.transparent, child: content),
      );
    }

    showGeneralDialog(
      context: context,
      barrierLabel: "better_popup",
      barrierDismissible: isDismissible,
      barrierColor: Colors.black.withAlpha(128),
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, animation, _, child) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              onClose?.call();
            }
          },
          child: Stack(
            children: [
              // 半透明背景层
              Positioned.fill(
                child: GestureDetector(
                  onTap: isDismissible ? () => Navigator.pop(context) : null,
                  child: Container(color: Colors.transparent),
                ),
              ),

              // 弹窗内容定位
              if (position != BetterPopupPosition.center)
                Positioned(
                  top: position == BetterPopupPosition.top ? 0 : null,
                  bottom: position == BetterPopupPosition.bottom ? 0 : null,
                  left: position == BetterPopupPosition.left ? 0 : null,
                  right: position == BetterPopupPosition.right ? 0 : null,
                  child: slideContent(animation: animation),
                ),
              if (position == BetterPopupPosition.center)
                Align(child: slideContent(animation: animation)),
            ],
          ),
        );
      },
    );
  }
}
