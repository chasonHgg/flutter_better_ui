import 'package:flutter_better_ui/animation/spinner/spinner.dart';
import 'package:flutter_better_ui/theme/child_themes/better_button_theme.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';
import 'package:flutter/material.dart';

/// Loading indicator type used by `BetterButton`.
enum BetterButtonLoadingType { circular, spinner }

/// Preset visual styles for `BetterButton`.
enum BetterButtonType { defaultType, primary, success, warning, danger, info }

/// A highly configurable button widget that supports theme colors, loading
/// indicators, custom prefix/suffix, gradients and more.
class BetterButton extends StatelessWidget {
  /// The preset visual style to use. When null, falls back to theme defaults.
  final BetterButtonType? type;

  /// Callback when the button is tapped.
  final VoidCallback? onClick;

  /// Background color of the button. If null, a color is derived from [type].
  final Color? color;

  /// Border color of the button.
  final Color? borderColor;

  /// Overlay/splash color when pressed.
  final Color? overlayColor;

  /// Corner radius of the button.
  final double? borderRadius;

  /// Whether to show loading state.
  final bool loading;

  /// Size of the loading indicator.
  final double? loadingSize;

  /// Stroke width of the circular loading indicator.
  final double? loadingStrokeWidth;

  /// Custom loading widget. If provided it replaces the built-in indicator.
  final Widget? loadingWidget;

  /// Color of the loading indicator.
  final Color? loadingColor;

  /// Spacing to the right of the loading indicator.
  final double? loadingMarginRight;

  /// Widget displayed before the text/child.
  final Widget? prefix;

  /// Widget displayed after the text/child.
  final Widget? suffix;

  /// Fixed width of the button.
  final double? width;

  /// Fixed height of the button.
  final double? height;

  /// Loading indicator type.
  final BetterButtonLoadingType loadingType;

  /// Text content when [child] is not provided.
  final String? text;

  /// Text style for [text].
  final TextStyle? textStyle;

  /// Inner padding of the button.
  final EdgeInsetsGeometry? padding;

  /// Background gradient of the button. Takes precedence over [color].
  final Gradient? gradient;

  /// Whether to render a plain (outlined) style button.
  final bool? plain;

  /// MainAxisAlignment of the internal row.
  final MainAxisAlignment? mainAxisAlignment;

  /// Whether to disable splash effect.
  final bool? disableSplash;

  /// Whether the button is disabled.
  final bool? disabled;

  /// Whether to hide the content when loading.
  final bool? hideContentWhenLoading;

  /// Text displayed while loading when [hideContentWhenLoading] is false.
  final String? loadingText;

  /// Custom child widget. If provided, [text] is ignored.
  final Widget? child;

  /// Border width of the button.
  final double? borderWidth;

  /// Creates a [BetterButton].
  BetterButton({
    super.key,
    this.type = BetterButtonType.defaultType,
    this.onClick,
    this.color,
    this.borderColor,
    this.overlayColor,
    this.borderRadius,
    this.loading = false,
    this.loadingSize,
    this.loadingStrokeWidth = 1,
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
    // Compute responsive sizes
    final double computedLoadingSize = loadingSize?.bw ?? 20.bw;
    final double computedHeight = height?.bw ?? 44.bw;
    final double computedLoadingMarginRight = loadingMarginRight?.bw ?? 8.bw;
    BetterButtonTheme buttonTheme = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.buttonTheme;
    Color? defaultColor = buttonTheme.defaultColor;
    Color? finalBackgroundColor = color ?? defaultColor;
    Color finalBorderColor = borderColor ?? buttonTheme.borderColor;
    Color? finalTextColor = buttonTheme.defaultTextColor;
    double finalBorderRadius = borderRadius ?? buttonTheme.borderRadius ?? 6.bw;

    Color finalLoadingColor = loadingColor ?? buttonTheme.loadingColor;

    TextStyle? finalTextStyle = textStyle ?? TextStyle();

    double finalBorderWidth = borderWidth ?? 1;
    if (borderWidth == null && BetterUtil.shouldUseHairlineBorder(context)) {
      finalBorderWidth = 1.bw;
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
              width: loadingSize,
              height: loadingSize,
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
          loading == true
              ? Colors.transparent
              : overlayColor ?? buttonTheme.overlayColor,
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
        height: computedHeight,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              mainAxisAlignment ??
              Theme.of(context)
                  .extension<BetterThemeExtension>()!
                  .buttonTheme
                  .mainAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
