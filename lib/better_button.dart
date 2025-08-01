import 'package:better_ui/animation/spinner/spinner.dart';
import 'package:better_ui/theme/child_themes/better_button_theme.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/utils/better_util.dart';
import 'package:flutter/material.dart';

enum BetterButtonLoadingType { circular, spinner }

enum BetterButtonType { defaultType, primary, success, warning, danger, info }

class BetterButton extends StatelessWidget {
  final BetterButtonType? type;
  final VoidCallback? onClick;
  final Color? color;
  final Color? borderColor;
  final Color? overlayColor;
  final double? borderRadius;
  final bool loading;
  final double? loadingSize;
  final double? loadingStrokeWidth;
  final Widget? loadingWidget;
  final Color? loadingColor;
  final double? loadingMarginRight;
  final Widget? prefix;
  final Widget? suffix;
  final double? width;
  final double? height;
  final BetterButtonLoadingType? loadingType;
  final String? text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  //是否为朴素按钮
  final bool? plain;
  final MainAxisAlignment? mainAxisAlignment;
  //是否关闭水波纹效果
  final bool? disableSplash;
  //是否禁用按钮
  final bool? disabled;
  //loading的时候是否隐藏内容
  final bool? hideContentWhenLoading;
  //loading的时候显示的文本
  final String? loadingText;
  final Widget? child;
  final double? borderWidth;

  const BetterButton({
    super.key,
    this.type = BetterButtonType.defaultType,
    this.onClick,
    this.color,
    this.borderColor,
    this.overlayColor,
    this.borderRadius,
    this.loading = false,
    this.loadingSize = 20,
    this.loadingStrokeWidth = 1,
    this.loadingWidget,
    this.loadingColor,
    this.loadingMarginRight = 8,
    this.prefix,
    this.suffix,
    this.width,
    this.height = 44,
    this.loadingType = BetterButtonLoadingType.circular,
    this.text,
    this.textStyle,
    this.padding,
    this.plain = false,
    this.gradient,
    this.mainAxisAlignment,
    this.disableSplash = false,
    this.disabled = false,
    this.hideContentWhenLoading = true,
    this.loadingText,
    this.child,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    BetterButtonTheme buttonTheme = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.buttonTheme;
    Color? defaultColor = buttonTheme.defaultColor;
    Color? finalBackgroundColor = color ?? defaultColor;
    Color finalBorderColor = borderColor ?? buttonTheme.borderColor;
    Color? finalTextColor = buttonTheme.defaultTextColor;
    double finalBorderRadius = borderRadius ?? buttonTheme.borderRadius;

    Color finalLoadingColor = loadingColor ?? buttonTheme.loadingColor;

    TextStyle? finalTextStyle = textStyle ?? TextStyle();

    double finalBorderWidth = borderWidth ?? 1;
    if (borderWidth == null && BetterUtil.shouldUseHairlineBorder(context)) {
      finalBorderWidth = 0.5;
    }

    //获取主题色
    Color primaryColor = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.primaryColor;
    Color successColor = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.successColor;
    Color warningColor = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.warningColor;
    Color dangerColor = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.dangerColor;
    Color infoColor = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.infoColor;

    //获取按钮类型
    if (color == null) {
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

    //获取边框颜色
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

    //获取按钮内容
    final children = <Widget>[];
    if (loading) {
      if (loadingWidget != null) {
        children.add(loadingWidget!);
      } else {
        if (loadingType == BetterButtonLoadingType.circular) {
          children.add(
            SizedBox(
              width: loadingSize ?? 20,
              height: loadingSize ?? 20,
              child: CircularProgressIndicator(
                strokeWidth: loadingStrokeWidth,
                valueColor: AlwaysStoppedAnimation(finalLoadingColor),
              ),
            ),
          );
        }
        if (loadingType == BetterButtonLoadingType.spinner) {
          children.add(Spinner(size: loadingSize, color: finalLoadingColor));
        }
        //获取loading间距
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
      finalTextStyle = finalTextStyle.copyWith(
        fontSize: Theme.of(
          context,
        ).extension<BetterThemeExtension>()!.buttonTheme.fontSize,
      );
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
      children.add(Text(loadingText!, style: finalTextStyle));
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
          overlayColor ?? Colors.black.withAlpha(20),
        ),
        splashFactory:
            disabled == true || disableSplash == true || loading == true
            ? NoSplash.splashFactory
            : InkSparkle.splashFactory,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(finalBorderRadius),
          ),
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: finalBorderColor, width: finalBorderWidth),
        ),
      ),
      onPressed: disabled == true ? null : onClick ?? () {},
      child: Ink(
        width: width,
        height: height,
        padding:
            padding ??
            Theme.of(
              context,
            ).extension<BetterThemeExtension>()!.buttonTheme.padding,
        decoration: BoxDecoration(
          color: disabled == true
              ? finalBackgroundColor.withAlpha(128)
              : finalBackgroundColor,
          gradient: gradient,
          borderRadius: BorderRadius.circular(finalBorderRadius),
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment:
                mainAxisAlignment ??
                Theme.of(context)
                    .extension<BetterThemeExtension>()!
                    .buttonTheme
                    .mainAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
