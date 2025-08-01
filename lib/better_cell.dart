import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';

class BetterCell extends StatelessWidget {
  final double? height;

  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final String? titleText;
  final String? valueText;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  final BoxBorder? border;
  final bool? isShowBorder;
  final bool? isShowArrowRight;
  final double? arrowRightMarginLeft;
  final double? arrowRightSize;
  final Color? arrowRightColor;
  final Widget? titleWidget;
  final Widget? valueWidget;
  final VoidCallback? onClick;
  final bool? disabled;
  final bool? disableSplash;
  final Color? overlayColor;

  const BetterCell({
    super.key,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.titleText,
    this.valueText,
    this.titleTextStyle,
    this.valueTextStyle,
    this.border,
    this.isShowBorder = false,
    this.isShowArrowRight = false,
    this.arrowRightMarginLeft,
    this.arrowRightSize,
    this.arrowRightColor,
    this.titleWidget,
    this.valueWidget,
    this.onClick,
    this.disabled = false,
    this.disableSplash = false,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    BetterCellTheme cellTheme = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!.cellTheme;

    TextStyle? finalTitleTextStyle = titleTextStyle ?? cellTheme.titleTextStyle;
    TextStyle? finalValueTextStyle = valueTextStyle ?? cellTheme.valueTextStyle;

    Color finalBackgroundColor =
        backgroundColor ?? cellTheme.backgroundColor ?? Colors.white;

    double finalHeight = height ?? cellTheme.height ?? 44.bw;

    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(
          isShowArrowRight == false
              ? Colors.transparent
              : (overlayColor ?? cellTheme.overlayColor),
        ),
        splashFactory:
            disabled == true || disableSplash == true || onClick == null
            ? NoSplash.splashFactory
            : InkSparkle.splashFactory,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius:
                borderRadius ??
                cellTheme.borderRadius ??
                BorderRadius.circular(0),
          ),
        ),
      ),
      onPressed: disabled == true ? null : onClick ?? () {},
      child: Container(
        height: finalHeight,
        decoration: BoxDecoration(
          border: isShowBorder == true ? (border ?? cellTheme.border) : null,
          borderRadius: borderRadius ?? cellTheme.borderRadius,
        ),
        child: Ink(
          height: finalHeight,
          padding: padding ?? cellTheme.padding,
          decoration: BoxDecoration(
            color: finalBackgroundColor,
            borderRadius: borderRadius ?? cellTheme.borderRadius,
          ),
          child: Row(
            children: [
              if (titleWidget != null)
                titleWidget!
              else
                Text(titleText ?? '', style: finalTitleTextStyle),
              const Spacer(),
              if (valueWidget != null)
                valueWidget!
              else
                Text(valueText ?? '', style: finalValueTextStyle),
              if (isShowArrowRight == true)
                SizedBox(
                  width:
                      arrowRightMarginLeft ??
                      cellTheme.arrowRightMarginLeft ??
                      4,
                ),
              if (isShowArrowRight == true)
                Icon(
                  Icons.arrow_forward_ios,
                  size: arrowRightSize ?? cellTheme.arrowRightSize,
                  color: arrowRightColor ?? cellTheme.arrowRightColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
