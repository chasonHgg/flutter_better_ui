import 'package:flutter_better_ui/theme/child_themes/better_cell_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

/// 一个可配置的列表单元格，常用于设置或表单中
class BetterCell extends StatelessWidget {
  /// 单元格的固定高度
  final double? height;

  /// 单元格的圆角半径
  final BorderRadiusGeometry? borderRadius;

  /// 单元格的背景颜色
  final Color? backgroundColor;

  /// 单元格的内边距
  final EdgeInsetsGeometry? padding;

  /// 单元格的标题文本
  final String? titleText;

  /// 单元格的值文本
  final String? valueText;

  /// 单元格的标题文本样式
  final TextStyle? titleTextStyle;

  /// 单元格的值文本样式
  final TextStyle? valueTextStyle;

  /// 单元格的边框
  final BoxBorder? border;

  /// 是否显示边框
  final bool? isShowBorder;

  /// 是否显示右箭头
  final bool? isShowArrowRight;

  /// 右箭头的左边距
  final double? arrowRightMarginLeft;

  /// 右箭头的大小
  final double? arrowRightSize;

  /// 右箭头的颜色
  final Color? arrowRightColor;

  final Widget? titleWidget;

  /// 单元格的值组件
  final Widget? valueWidget;

  /// 点击回调函数
  final VoidCallback? onClick;

  /// 是否禁用单元格
  final bool? disabled;

  /// 是否禁用水波纹效果
  final bool? disableSplash;

  /// 单元格的覆盖颜色
  final Color? overlayColor;

  /// 创建一个 [BetterCell]。
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
        height: height,
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
