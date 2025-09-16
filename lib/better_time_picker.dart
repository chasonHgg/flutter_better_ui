import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_picker.dart';
import 'package:flutter_better_ui/better_picker_widget.dart';

enum BetterTimePickerColumnType { hour, minute, second }

class BetterTimePickerFormatterOption {
  final BetterTimePickerColumnType columnType;
  final String text;

  BetterTimePickerFormatterOption({
    required this.columnType,
    required this.text,
  });
}

class BetterTimePickerFilterOption {
  final BetterTimePickerColumnType columnType;
  final int value;

  BetterTimePickerFilterOption({required this.columnType, required this.value});
}

class BetterTimePicker {
  static List<BetterPickerItem> _generateItems(
    int minValue,
    int maxValue,
    int currentValue,
    BetterTimePickerColumnType columnType,
    Function(BetterTimePickerFormatterOption)? formatter,
    Function(BetterTimePickerFilterOption)? filter,
  ) {
    List<BetterPickerItem> items = [];
    for (int value = minValue; value <= maxValue; value++) {
      BetterPickerItem item = BetterPickerItem(
        text:
            formatter?.call(
              BetterTimePickerFormatterOption(
                columnType: columnType,
                text: value < 10 ? "0$value" : value.toString(),
              ),
            ) ??
            (value < 10 ? "0$value" : value.toString()),
        value: value.toString(),
        isSelected: value == currentValue,
      );
      if (filter != null) {
        if (filter.call(
          BetterTimePickerFilterOption(columnType: columnType, value: value),
        )) {
          items.add(item);
        }
      } else {
        items.add(item);
      }
    }
    return items;
  }

  static void show(
    BuildContext context, {
    //标题
    String? title,

    List<int>? defaultValue,

    /// 取消按钮的文本
    String? cancelText,

    /// 确认按钮的文本
    String? confirmText,

    /// 选择器的标题组件
    Widget? titleWidget,

    /// 头部背景颜色
    Color? headerBackgroundColor,

    /// 选择器的背景颜色
    Color? backgroundColor,

    /// 取消按钮的文本颜色
    Color? cancelTextColor,

    /// 确认按钮的文本颜色
    Color? confirmTextColor,

    /// 选择器的圆角半径
    BorderRadiusGeometry? borderRadius,
    //是否默认显示当天时间
    bool isDefaultShowNow = true,
    List<int>? minDate,
    List<int>? maxDate,
    List<BetterTimePickerColumnType>? columnTypes = const [
      BetterTimePickerColumnType.hour,
      BetterTimePickerColumnType.minute,
      BetterTimePickerColumnType.second,
    ],

    /// 格式化选项
    Function(BetterTimePickerFormatterOption)? formatter,
    //过滤选项
    Function(BetterTimePickerFilterOption)? filter,

    /// 取消回调
    VoidCallback? onCancel,

    /// 确认回调
    Function(List<BetterPickerItem>)? onConfirm,

    /// 改变回调
    Function(List<BetterPickerItem>)? onChange,

    /// 关闭回调
    VoidCallback? onClose,

    /// 选择器的直径比例
    double? diameterRatio,

    /// 选择器的高度
    double? itemHeight,

    /// 选择器的覆盖组件
    Widget? overlayWidget,
  }) {
    DateTime now = DateTime.now();
    int minHour = 0;
    int minMinute = 0;
    int minSecond = 0;
    int maxHour = 23;
    int maxMinute = 59;
    int maxSecond = 59;
    if (minDate != null) {
      if (minDate.length < 3) {
        throw Exception("minDate length must be 3");
      }
      minHour = minDate[0];
      minMinute = minDate[1];
      minSecond = minDate[2];
    }
    if (maxDate != null) {
      if (maxDate.length < 3) {
        throw Exception("maxDate length must be 3");
      }
      maxHour = maxDate[0];
      maxMinute = maxDate[1];
      maxSecond = maxDate[2];
    }
    // 存储当前选中的值
    int currentHour;
    int currentMinute;
    int currentSecond;

    int hourColumnIndex = columnTypes!.indexWhere(
      (element) => element == BetterTimePickerColumnType.hour,
    );
    int minuteColumnIndex = columnTypes.indexWhere(
      (element) => element == BetterTimePickerColumnType.minute,
    );
    int secondColumnIndex = columnTypes.indexWhere(
      (element) => element == BetterTimePickerColumnType.second,
    );
    if (!isDefaultShowNow) {
      currentHour = minHour;
      currentMinute = minMinute;
      currentSecond = minSecond;
    } else {
      currentHour = now.hour;
      currentMinute = now.minute;
      currentSecond = now.second;
    }
    if (defaultValue != null) {
      if (defaultValue.length < 3) {
        throw Exception("defaultValue length must be 3");
      }
      if (hourColumnIndex != -1) {
        currentHour = defaultValue[hourColumnIndex];
      }
      if (minuteColumnIndex != -1) {
        currentMinute = defaultValue[minuteColumnIndex];
      }
      if (secondColumnIndex != -1) {
        currentSecond = defaultValue[secondColumnIndex];
      }
    }
    List<List<BetterPickerItem>> columns = [];
    if (columnTypes.contains(BetterTimePickerColumnType.hour)) {
      columns.add(
        _generateItems(
          minHour,
          maxHour,
          currentHour,
          BetterTimePickerColumnType.hour,
          formatter,
          filter,
        ),
      );
    }
    if (columnTypes.contains(BetterTimePickerColumnType.minute)) {
      columns.add(
        _generateItems(
          minMinute,
          maxMinute,
          currentMinute,
          BetterTimePickerColumnType.minute,
          formatter,
          filter,
        ),
      );
    }
    if (columnTypes.contains(BetterTimePickerColumnType.second)) {
      columns.add(
        _generateItems(
          minSecond,
          maxSecond,
          currentSecond,
          BetterTimePickerColumnType.second,
          formatter,
          filter,
        ),
      );
    }

    BetterPicker.show(
      context,
      columns: columns,
      title: title,
      cancelText: cancelText,
      confirmText: confirmText,
      titleWidget: titleWidget,
      headerBackgroundColor: headerBackgroundColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      onCancel: onCancel,
      onConfirm: onConfirm,
      onClose: onClose,
      diameterRatio: diameterRatio,
      itemHeight: itemHeight,
      overlayWidget: overlayWidget,
      onChange:
          (
            List<BetterPickerItem> selectedValues,
            Function(dynamic columns) updateColumns,
          ) {
            onChange?.call(selectedValues);
          },
    );
  }
}
