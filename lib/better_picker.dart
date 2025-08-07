import 'package:better_ui/better_picker_widget.dart';
import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/utils/better_screen_util.dart';
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

class BetterPicker {
  static void show(
    BuildContext context, {
    //可能是一维数组，也可能是二维数组
    required var columns,
    String? cancelText,
    String? confirmText,
    String? title,
    Widget? titleWidget,
    Color? headerBackgroundColor,
    BorderRadiusGeometry? borderRadius,
    Color? cancelTextColor,
    Color? confirmTextColor,
    VoidCallback? onCancel,
    Function(List<BetterPickerItem>)? onConfirm,
    Function(List<BetterPickerItem>)? onChange,
    VoidCallback? onClose,
    double? diameterRatio,
    double? itemHeight,
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
