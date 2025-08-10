import 'package:flutter_better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

/// A configurable list cell commonly used in settings or forms.
class BetterCell extends StatelessWidget {
  /// Fixed height of the cell
  final double? height;

  /// Border radius of the cell
  final BorderRadiusGeometry? borderRadius;

  /// Background color of the cell
  final Color? backgroundColor;

  /// Padding of the cell
  final EdgeInsetsGeometry? padding;

  /// Title text of the cell
  final String? titleText;

  /// Value text of the cell
  final String? valueText;

  /// Title text style of the cell
  final TextStyle? titleTextStyle;

  /// Value text style of the cell
  final TextStyle? valueTextStyle;

  /// Border of the cell
  final BoxBorder? border;

  /// Whether to show border
  final bool? isShowBorder;

  /// Whether to show arrow right
  final bool? isShowArrowRight;

  /// Margin left of the arrow right
  final double? arrowRightMarginLeft;

  /// Size of the arrow right
  final double? arrowRightSize;

  /// Color of the arrow right
  final Color? arrowRightColor;

  final Widget? titleWidget;

  /// Value widget of the cell
  final Widget? valueWidget;

  /// On click callback
  final VoidCallback? onClick;

  /// Whether to disable the cell
  final bool? disabled;

  /// Whether to disable splash
  final bool? disableSplash;

  /// Overlay color of the cell
  final Color? overlayColor;

  /// Creates a [BetterCell].
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
    BetterCellTheme cellTheme = BetterUtil.getThemeExtension(
      context,
    )!.cellTheme;
    TextStyle? finalTitleTextStyle = titleTextStyle ?? cellTheme.titleTextStyle;
    TextStyle? finalValueTextStyle = valueTextStyle ?? cellTheme.valueTextStyle;

    Color finalBackgroundColor =
        backgroundColor ?? cellTheme.backgroundColor ?? Colors.white;

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
            disabled == true ||
                disableSplash == true ||
                isShowArrowRight == false
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
        decoration: BoxDecoration(
          border: isShowBorder == true ? border ?? cellTheme.border : null,
          borderRadius: borderRadius ?? cellTheme.borderRadius,
        ),
        child: Ink(
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
