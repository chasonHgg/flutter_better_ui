import 'package:flutter_better_ui/animation/spinner/spinner.dart';
import 'package:flutter_better_ui/theme/child_themes/better_button_theme.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';
import 'package:flutter/material.dart';

/// BetterButton 使用的加载指示器类型
enum BetterButtonLoadingType { circular, spinner }

/// BetterButton 的预设视觉样式
enum BetterButtonType { defaultType, primary, success, warning, danger, info }

/// 一个高度可配置的按钮组件，支持主题颜色、加载指示器、自定义前缀/后缀、渐变等
// ignore: must_be_immutable
class BetterButton extends StatelessWidget {
  /// 要使用的预设视觉样式。当为 null 时，回退到主题默认值
  final BetterButtonType? type;

  /// 按钮被点击时的回调函数
  final VoidCallback? onClick;

  /// 按钮的背景颜色。如果为 null，则从 [type] 派生颜色
  final Color? backgroundColor;

  /// 按钮的边框颜色
  final Color? borderColor;

  /// 按下时的覆盖/水波纹颜色
  final Color? overlayColor;

  /// 按钮的圆角半径
  final BorderRadiusGeometry? borderRadius;

  /// 是否显示加载状态
  final bool loading;

  /// 加载指示器的大小
  double? loadingSize;

  /// 圆形加载指示器的描边宽度
  final double? loadingStrokeWidth;

  /// 自定义加载组件。如果提供，将替换内置指示器
  final Widget? loadingWidget;

  /// 加载指示器的颜色
  final Color? loadingColor;

  /// 加载指示器右侧的间距
  double? loadingMarginRight;

  /// 显示在文本/子组件之前的组件
  final Widget? prefix;

  /// 显示在文本/子组件之后的组件
  final Widget? suffix;

  /// 按钮的固定宽度
  final double? width;

  /// 按钮的固定高度
  double? height;

  /// 加载指示器类型
  final BetterButtonLoadingType loadingType;

  /// 当未提供 [child] 时的文本内容
  final String? text;

  /// [text] 的文本样式
  final TextStyle? textStyle;

  /// 按钮的内边距
  final EdgeInsetsGeometry? padding;

  /// 按钮的背景渐变。优先于 [color]
  final Gradient? gradient;

  /// 是否渲染朴素（轮廓）样式的按钮
  final bool? plain;

  /// 是否禁用水波纹效果
  final bool? disableSplash;

  /// 按钮是否被禁用
  final bool? disabled;

  /// 加载时是否隐藏内容
  final bool? hideContentWhenLoading;

  /// 当 [hideContentWhenLoading] 为 false 时，加载期间显示的文本
  final String? loadingText;

  /// 自定义子组件。如果提供，[text] 将被忽略
  final Widget? child;

  /// 按钮的边框宽度
  final double? borderWidth;

  /// 是否显示边框
  final bool? isShowBorder;

  /// 创建一个 [BetterButton]。
  BetterButton({
    super.key,
    this.type = BetterButtonType.defaultType,
    this.onClick,
    this.backgroundColor,
    this.borderColor,
    this.overlayColor,
    this.borderRadius,
    this.loading = false,
    this.loadingSize,
    this.loadingStrokeWidth,
    this.loadingWidget,
    this.loadingColor,
    this.loadingMarginRight,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
    this.loadingType = BetterButtonLoadingType.circular,
    this.text,
    this.textStyle,
    this.padding,
    this.plain = false,
    this.gradient,
    this.disableSplash = false,
    this.disabled = false,
    this.hideContentWhenLoading = true,
    this.loadingText,
    this.child,
    this.borderWidth,
    this.isShowBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    loadingSize ??= 20.bw;
    loadingMarginRight ??= 8.bw;

    BetterThemeExtension themeExtension = BetterUtil.getThemeExtension(
      context,
    )!;
    BetterButtonTheme buttonTheme = themeExtension.buttonTheme;

    Color? defaultColor = buttonTheme.defaultBackgroundColor;
    Color? finalBackgroundColor = backgroundColor ?? defaultColor;
    Color finalBorderColor = borderColor ?? buttonTheme.borderColor;
    Color? finalTextColor = buttonTheme.defaultTextColor;
    BorderRadiusGeometry finalBorderRadius =
        borderRadius ??
        buttonTheme.borderRadius ??
        BorderRadius.all(Radius.circular(6.bw));

    Color finalLoadingColor = buttonTheme.loadingColor;

    TextStyle? finalTextStyle = textStyle ?? TextStyle();

    double finalBorderWidth = borderWidth ?? 1;
    if (borderWidth == null && BetterUtil.shouldUseHairlineBorder(context)) {
      finalBorderWidth = 1.bw;
    }

    // 获取主题色
    Color primaryColor = themeExtension.primaryColor;
    Color successColor = themeExtension.successColor;
    Color warningColor = themeExtension.warningColor;
    Color dangerColor = themeExtension.dangerColor;
    Color infoColor = themeExtension.infoColor;

    // 获取按钮类型
    if (backgroundColor == null) {
      if (plain == null || plain == false) {
        if (type == BetterButtonType.defaultType) {
          finalBackgroundColor = defaultColor;
        } else if (type == BetterButtonType.primary) {
          finalBackgroundColor = primaryColor;
        } else if (type == BetterButtonType.success) {
          finalBackgroundColor = successColor;
        } else if (type == BetterButtonType.warning) {
          finalBackgroundColor = warningColor;
        } else if (type == BetterButtonType.danger) {
          finalBackgroundColor = dangerColor;
        } else if (type == BetterButtonType.info) {
          finalBackgroundColor = infoColor;
        }
      }
    }

    // 获取边框颜色
    if (borderColor == null) {
      if (plain != null && plain == true) {
        if (type == BetterButtonType.primary) {
          finalBorderColor = primaryColor;
        } else if (type == BetterButtonType.success) {
          finalBorderColor = successColor;
        } else if (type == BetterButtonType.warning) {
          finalBorderColor = warningColor;
        } else if (type == BetterButtonType.danger) {
          finalBorderColor = dangerColor;
        } else if (type == BetterButtonType.info) {
          finalBorderColor = infoColor;
        }
      }
      if (plain == null || plain == false) {
        if (type == BetterButtonType.defaultType) {
          finalBorderColor = finalBorderColor;
        } else {
          finalBorderColor = Colors.transparent;
        }
      }
    }

    if (plain != null && plain == true) {
      if (type == BetterButtonType.primary) {
        finalTextColor = primaryColor;
        finalLoadingColor = primaryColor;
      } else if (type == BetterButtonType.success) {
        finalTextColor = successColor;
        finalLoadingColor = successColor;
      } else if (type == BetterButtonType.warning) {
        finalTextColor = warningColor;
        finalLoadingColor = warningColor;
      } else if (type == BetterButtonType.danger) {
        finalTextColor = dangerColor;
        finalLoadingColor = dangerColor;
      } else if (type == BetterButtonType.info) {
        finalTextColor = infoColor;
        finalLoadingColor = infoColor;
      }
    } else {
      if (type == BetterButtonType.primary) {
        finalTextColor = buttonTheme.primaryTextColor;
        finalLoadingColor = buttonTheme.primaryTextColor;
      } else if (type == BetterButtonType.success) {
        finalTextColor = buttonTheme.successTextColor;
        finalLoadingColor = Colors.white;
      } else if (type == BetterButtonType.warning) {
        finalTextColor = buttonTheme.warningTextColor;
        finalLoadingColor = Colors.white;
      } else if (type == BetterButtonType.danger) {
        finalTextColor = buttonTheme.dangerTextColor;
        finalLoadingColor = Colors.white;
      } else if (type == BetterButtonType.info) {
        finalTextColor = buttonTheme.infoTextColor;
        finalLoadingColor = Colors.white;
      }
    }

    if (loadingColor != null) {
      finalLoadingColor = loadingColor!;
    }

    // 获取按钮内容
    final children = <Widget>[];
    if (loading) {
      if (loadingWidget != null) {
        children.add(loadingWidget!);
      } else {
        if (loadingType == BetterButtonLoadingType.circular) {
          children.add(
            SizedBox(
              width: loadingSize,
              height: loadingSize,
              child: CircularProgressIndicator(
                strokeWidth:
                    loadingStrokeWidth ?? buttonTheme.loadingStrokeWidth ?? 1,
                valueColor: AlwaysStoppedAnimation(finalLoadingColor),
              ),
            ),
          );
        }
        if (loadingType == BetterButtonLoadingType.spinner) {
          children.add(Spinner(size: loadingSize, color: finalLoadingColor));
        }
        // 获取loading间距
        if ((loadingMarginRight != null && loadingMarginRight! > 0) &&
            ((loading == false || hideContentWhenLoading == false) ||
                (loading == true && loadingText != null))) {
          children.add(SizedBox(width: loadingMarginRight));
        }
      }
    }
    //获取前缀
    if (prefix != null &&
        (loading == false || hideContentWhenLoading == false)) {
      children.add(prefix!);
    }

    //获取文本样式
    if (finalTextStyle.color == null) {
      finalTextStyle = finalTextStyle.copyWith(color: finalTextColor);
    }
    if (finalTextStyle.fontSize == null) {
      finalTextStyle = finalTextStyle.copyWith(fontSize: buttonTheme.fontSize);
    }

    //获取文本
    if (text != null &&
        child == null &&
        (loading == false ||
            (loading == true && hideContentWhenLoading == false))) {
      children.add(Text(text!, style: finalTextStyle));
    }
    //获取自定义内容
    if (child != null) {
      children.add(child!);
    }

    //获取loading文本
    if (loading == true && loadingText != null) {
      children.add(
        Text(
          loadingText!,
          style: finalTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    //获取后缀
    if (suffix != null &&
        (loading == false || hideContentWhenLoading == false)) {
      children.add(suffix!);
    }

    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(
          loading == true
              ? Colors.transparent
              : overlayColor ?? buttonTheme.overlayColor,
        ),
        splashFactory:
            disabled == true || disableSplash == true || loading == true
            ? NoSplash.splashFactory
            : InkSparkle.splashFactory,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: finalBorderRadius),
        ),
        side: isShowBorder == true
            ? WidgetStateProperty.all(
                BorderSide(color: finalBorderColor, width: finalBorderWidth),
              )
            : WidgetStateProperty.all(BorderSide.none),
      ),
      onPressed: disabled == true ? null : onClick ?? () {},
      child: Ink(
        width: width,
        height: height,
        padding: padding ?? buttonTheme.padding,
        decoration: BoxDecoration(
          color: disabled == true
              ? finalBackgroundColor.withAlpha(128)
              : finalBackgroundColor,
          gradient: gradient,
          borderRadius: finalBorderRadius,
        ),
        child: Wrap(runAlignment: WrapAlignment.center, children: children),
      ),
    );
  }
}
