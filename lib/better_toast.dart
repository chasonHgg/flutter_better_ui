import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';

/// Toast 显示位置。
enum BetterToastPosition { top, bottom, center }

/// 一个简单的 Toast 帮助器，支持文本、成功/错误和加载变体。
class BetterToast {
  //加载中
  static OverlayEntry? _currentLoadingEntry;
  static AnimationController? _loadingAnimationController;

  static Alignment _getAlignment(BetterToastPosition position) {
    switch (position) {
      case BetterToastPosition.top:
        return Alignment.topCenter;
      case BetterToastPosition.bottom:
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }

  //文字提示
  static void show(
    BuildContext context, {

    /// Toast 的消息
    String? message,

    /// Toast 的子组件
    Widget? child,

    /// Toast 的图标
    Widget? icon,

    /// 动画持续时间
    Duration? fadeDuration,

    /// Toast 的持续时间
    Duration? duration,

    /// Toast 的字体大小
    double? fontSize,
    Color? textColor,

    /// Toast 的背景颜色
    Color? backgroundColor,

    /// Toast 的内边距
    EdgeInsets? padding,

    /// Toast 的圆角半径
    BorderRadius? borderRadius,

    /// Toast 的位置
    BetterToastPosition position = BetterToastPosition.bottom,

    /// 顶部偏移量
    double? topOffset,

    /// 底部偏移量
    double? bottomOffset,

    /// 文本对齐方式
    TextAlign? textAlign = TextAlign.center,

    /// 是否禁止点击
    bool? forbidClick = false,

    /// Toast 的宽度
    double? width,

    /// Toast 的高度
    double? height,
  }) {
    final overlay = Overlay.of(context);
    final screenHeight = BetterScreenUtil.screenHeight;
    topOffset ??= screenHeight * 0.2;
    bottomOffset ??= screenHeight * 0.2;

    // 动画控制器
    final animationController = AnimationController(
      vsync: overlay,
      duration: fadeDuration ?? const Duration(milliseconds: 250),
    );

    // 遮罩层控制器（仅当 forbidClick=true 时使用）
    final fadeController = AnimationController(
      vsync: overlay,
      duration: const Duration(milliseconds: 150),
    );
    final fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    );

    // 位移动画
    final offsetAnimation =
        Tween<Offset>(
          begin: position == BetterToastPosition.center
              ? Offset.zero
              : Offset(0, position == BetterToastPosition.bottom ? 0.1 : -0.1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOutQuad,
          ),
        );

    // 透明度动画
    final toastOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    // 创建OverlayEntry
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // 禁止点击的遮罩层（条件渲染）
            if (forbidClick == true)
              Positioned.fill(
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(color: Colors.transparent),
                ),
              ),

            // Toast内容
            Align(
              alignment: _getAlignment(position),
              child: SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: toastOpacityAnimation,
                  child: Material(
                    color: Colors.transparent,
                    child:
                        child ??
                        Container(
                          width: width,
                          height: height,
                          margin: EdgeInsets.only(
                            top: position == BetterToastPosition.top
                                ? (topOffset ?? 0)
                                : 0,
                            bottom: position == BetterToastPosition.bottom
                                ? (bottomOffset ?? 0)
                                : 0,
                          ),
                          constraints: BoxConstraints(
                            maxWidth:
                                width ?? BetterScreenUtil.screenWidth * 0.8,
                          ),
                          padding:
                              padding ??
                              EdgeInsets.symmetric(
                                horizontal: 12.bw,
                                vertical: 8.bw,
                              ),
                          decoration: BoxDecoration(
                            color:
                                backgroundColor ?? Colors.black.withAlpha(178),
                            borderRadius:
                                borderRadius ?? BorderRadius.circular(8.bw),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (icon != null) icon,
                              if (icon != null && message != null)
                                SizedBox(height: 8.bw),
                              if (message != null)
                                Text(
                                  message,
                                  textAlign: textAlign,
                                  style: TextStyle(
                                    color: textColor ?? Colors.white,
                                    fontSize: fontSize ?? 14.bsp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // 插入到Overlay
    overlay.insert(overlayEntry);

    // 启动动画（先显示遮罩层）
    void startAnimations() async {
      if (forbidClick == true) {
        await fadeController.forward();
      }
      await animationController.forward();
    }

    // 隐藏动画（先隐藏Toast再隐藏遮罩）
    Future<void> hideAnimations() async {
      await animationController.reverse();
      if (forbidClick == true) {
        await fadeController.reverse();
      }
      overlayEntry.remove();
    }

    // 执行显示
    startAnimations();

    // 延迟隐藏
    Future.delayed(duration ?? const Duration(seconds: 2), hideAnimations);
  }

  //成功提示
  static void showSuccess(
    BuildContext context, {

    /// Message of the toast
    String? message,

    /// Whether to forbid click
    bool forbidClick = false,

    /// Size of the icon
    double? iconSize,

    /// Color of the icon
    Color? iconColor,

    /// Text color of the toast
    Color? textColor,

    /// Font size of the toast
    double? fontSize,
  }) {
    show(
      context,
      message: message,
      position: BetterToastPosition.center,
      forbidClick: forbidClick,
      width: 120.bw,
      height: 120.bw,
      icon: Icon(
        Icons.check,
        color: iconColor ?? Colors.white,
        size: iconSize ?? 40.bw,
      ),
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  //失败提示
  static void showError(
    BuildContext context, {

    /// Message of the toast
    String? message,

    /// Whether to forbid click
    bool forbidClick = false,

    /// Size of the icon
    double? iconSize,

    /// Color of the icon
    Color? iconColor,

    /// Text color of the toast
    Color? textColor,

    /// Font size of the toast
    double? fontSize,
  }) {
    show(
      context,
      message: message,
      position: BetterToastPosition.center,
      forbidClick: forbidClick,
      width: 120.bw,
      height: 120.bw,
      icon: Icon(
        Icons.error,
        color: iconColor ?? Colors.white,
        size: iconSize ?? 40.bw,
      ),
      textColor: textColor,
    );
  }

  static void showLoading(
    BuildContext context, {

    /// Message of the toast
    String? message,

    /// Whether to forbid click
    bool forbidClick = false,

    /// Color of the barrier
    Color? barrierColor,

    /// Size of the progress
    double? progressSize,

    /// Color of the progress
    Color? progressColor = Colors.white,

    /// Stroke width of the progress
    double? progressStrokeWidth = 2,

    /// Border radius of the progress
    double? borderRadius,

    /// Padding of the progress
    EdgeInsetsGeometry? padding,

    /// Fade duration of the progress
    Duration? fadeDuration,

    /// Text style of the progress
    TextStyle? textStyle,
  }) {
    // 已有的loading不重复显示
    if (_currentLoadingEntry != null) {
      return;
    }
    progressSize ??= 25.bw;
    barrierColor ??= Colors.black.withAlpha(178);

    final overlay = Overlay.of(context);
    _loadingAnimationController = AnimationController(
      duration: fadeDuration ?? const Duration(milliseconds: 250),
      vsync: overlay,
    );
    final opacityAnimation = CurvedAnimation(
      parent: _loadingAnimationController!,
      curve: Curves.easeInOut,
    );

    _currentLoadingEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // 半透明遮罩层（拦截点击）
            if (forbidClick)
              Positioned.fill(child: ColoredBox(color: Colors.transparent)),

            // 中心加载内容
            Positioned.fill(
              child: FadeTransition(
                opacity: opacityAnimation,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding:
                          padding ??
                          (message != null
                              ? EdgeInsets.only(
                                  left: 20.bw,
                                  right: 20.bw,
                                  top: 25.bw,
                                  bottom: 16.bw,
                                )
                              : EdgeInsets.all(10.bw)),
                      constraints: BoxConstraints(
                        maxWidth: BetterScreenUtil.screenWidth * 0.7,
                        minWidth: 88.bw,
                        minHeight: 88.bw,
                      ),
                      decoration: BoxDecoration(
                        color: barrierColor,
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? 8.bw,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: progressSize,
                            height: progressSize,
                            child: CircularProgressIndicator(
                              strokeWidth: progressStrokeWidth!,
                              valueColor: AlwaysStoppedAnimation(
                                progressColor!,
                              ),
                            ),
                          ),
                          if (message != null) ...[
                            SizedBox(height: 16.bw),
                            Text(
                              message,
                              style:
                                  textStyle ??
                                  TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.bsp,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // 插入到Overlay
    overlay.insert(_currentLoadingEntry!);
    _loadingAnimationController!.forward();
  }

  static void hideLoading() {
    if (_currentLoadingEntry == null || _loadingAnimationController == null) {
      return;
    }
    // 启动淡出动画
    _loadingAnimationController?.reverse().then((_) {
      // 动画完成后移除
      _currentLoadingEntry?.remove();
      _currentLoadingEntry = null;

      // 释放动画控制器
      _loadingAnimationController?.dispose();
      _loadingAnimationController = null;
    });
  }
}
