import 'package:flutter_better_ui/better_picker_widget.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';

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

/// Utility to display a modal picker with single/multi/cascade columns.
class BetterPicker {
  static void show(
    BuildContext context, {

    /// Columns of the picker
    required var columns,

    /// Text for cancel button
    String? cancelText,

    /// Text for confirm button
    String? confirmText,

    /// Title of the picker
    String? title,

    /// Title widget of the picker
    Widget? titleWidget,

    /// Background color of the header
    Color? headerBackgroundColor,

    /// Border radius of the picker
    BorderRadiusGeometry? borderRadius,

    /// Text color of the cancel button
    Color? cancelTextColor,

    /// Text color of the confirm button
    Color? confirmTextColor,

    /// On cancel callback
    VoidCallback? onCancel,

    /// On confirm callback
    Function(List<BetterPickerItem>)? onConfirm,

    /// On change callback
    Function(List<BetterPickerItem>)? onChange,

    /// On close callback
    VoidCallback? onClose,

    /// Diameter ratio of the picker
    double? diameterRatio,

    /// Item height of the picker
    double? itemHeight,

    /// Overlay widget of the picker
    Widget? overlayWidget,
  }) {
    itemHeight ??=
        Theme.of(
          context,
        ).extension<BetterThemeExtension>()?.pickerTheme.itemHeight ??
        44.bw;

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
