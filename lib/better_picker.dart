import 'package:flutter_better_ui/better_picker_widget.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

/**
 * 
 *  多列
 *  const columns = [
      // 第一列
      [
        { text: '周一', value: 'Monday' },
        { text: '周二', value: 'Tuesday' },
        { text: '周三', value: 'Wednesday' },
        { text: '周四', value: 'Thursday' },
        { text: '周五', value: 'Friday' },
      ],
      // 第二列
      [
        { text: '上午', value: 'Morning' },
        { text: '下午', value: 'Afternoon' },
        { text: '晚上', value: 'Evening' },
      ],
    ];
     级联
     const columns = [
      {
        text: '浙江',
        value: 'Zhejiang',
        children: [
          {
            text: '杭州',
            value: 'Hangzhou',
            children: [
              { text: '西湖区', value: 'Xihu' },
              { text: '余杭区', value: 'Yuhang' },
            ],
          },
          {
            text: '温州',
            value: 'Wenzhou',
            children: [
              { text: '鹿城区', value: 'Lucheng' },
              { text: '瓯海区', value: 'Ouhai' },
            ],
          },
        ],
      },
      {
        text: '福建',
        value: 'Fujian',
        children: [
          {
            text: '福州',
            value: 'Fuzhou',
            children: [
              { text: '鼓楼区', value: 'Gulou' },
              { text: '台江区', value: 'Taijiang' },
            ],
          },
          {
            text: '厦门',
            value: 'Xiamen',
            children: [
              { text: '思明区', value: 'Siming' },
              { text: '海沧区', value: 'Haicang' },
            ],
          },
        ],
      },
    ];

*/

/// 显示一个模态选择器，支持单列、多列和级联数据结构。
class BetterPicker {
  static void show(
    BuildContext context, {

    /// 选择器的列
    required var columns,

    /// 取消按钮的文本
    String? cancelText,

    /// 确认按钮的文本
    String? confirmText,

    /// 选择器的标题
    String? title,

    /// 选择器的标题组件
    Widget? titleWidget,

    /// 头部背景颜色
    Color? headerBackgroundColor,

    /// 选择器的背景颜色
    Color? backgroundColor,

    /// 选择器的圆角半径
    BorderRadiusGeometry? borderRadius,

    /// 取消按钮的文本颜色
    Color? cancelTextColor,

    /// 确认按钮的文本颜色
    Color? confirmTextColor,

    /// 取消回调
    VoidCallback? onCancel,

    /// 确认回调
    Function(List<BetterPickerItem>)? onConfirm,

    /// 改变回调
    Function(List<BetterPickerItem>, Function(dynamic columns))? onChange,

    /// 关闭回调
    VoidCallback? onClose,

    /// 选择器的直径比例
    double? diameterRatio,

    /// 选择器的高度
    double? itemHeight,

    /// 选择器的覆盖组件
    Widget? overlayWidget,
  }) {
    itemHeight ??=
        BetterUtil.getThemeExtension(context)?.pickerTheme.itemHeight ?? 44.bw;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      enableDrag: false,
      builder: (context) => PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          onClose?.call();
        },
        child: BetterPickerWidget(
          columns: columns,
          cancelText: cancelText,
          confirmText: confirmText,
          title: title,
          titleWidget: titleWidget,
          headerBackgroundColor: headerBackgroundColor,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          cancelTextColor: cancelTextColor,
          confirmTextColor: confirmTextColor,
          onCancel: onCancel,
          onConfirm: onConfirm,
          onChange: onChange,
          diameterRatio: diameterRatio,
          overlayWidget: overlayWidget,
          itemHeight: itemHeight,
        ),
      ),
    );
  }
}
