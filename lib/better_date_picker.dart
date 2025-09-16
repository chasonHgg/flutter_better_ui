import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_picker.dart';
import 'package:flutter_better_ui/better_picker_widget.dart';

enum BetterDatePickerColumnType { year, month, day }

class BetterDatePickerFormatterOption {
  final BetterDatePickerColumnType columnType;
  final String text;

  BetterDatePickerFormatterOption({
    required this.columnType,
    required this.text,
  });
}

class BetterDatePickerFilterOption {
  final BetterDatePickerColumnType columnType;
  final int value;

  BetterDatePickerFilterOption({required this.columnType, required this.value});
}

class BetterDatePicker {
  static bool _isLeapYear(int year) {
    if (year % 4 != 0) {
      return false; // 不能被4整除 → 不是闰年
    } else if (year % 100 != 0) {
      return true; // 能被4整除但不能被100整除 → 是闰年
    } else {
      return (year % 400 == 0); // 能被100整除 → 必须被400整除才是闰年
    }
  }

  static int _getDaysInMonth(int year, int month) {
    if (month == 2) return _isLeapYear(year) ? 29 : 28;
    if ([4, 6, 9, 11].contains(month)) return 30;
    return 31;
  }

  static List<BetterPickerItem> _generateDayItems(
    int minDay,
    int maxDay,
    int selectedDay,
    Function(BetterDatePickerFormatterOption)? formatter,
    Function(BetterDatePickerFilterOption)? filter,
  ) {
    // 确保选中的天数不超过该月的最大天数
    int validSelectedDay = selectedDay > maxDay ? maxDay : selectedDay;

    List<BetterPickerItem> items = [];
    for (int day = minDay; day <= maxDay; day++) {
      BetterPickerItem item = BetterPickerItem(
        text:
            formatter?.call(
              BetterDatePickerFormatterOption(
                columnType: BetterDatePickerColumnType.day,
                text: day < 10 ? "0$day" : day.toString(),
              ),
            ) ??
            (day < 10 ? "0$day" : day.toString()),
        value: day.toString(),
        isSelected: day == validSelectedDay,
      );
      if (filter != null) {
        if (filter.call(
          BetterDatePickerFilterOption(
            columnType: BetterDatePickerColumnType.day,
            value: day,
          ),
        )) {
          items.add(item);
        }
      } else {
        items.add(item);
      }
    }

    return items;
  }

  static List<BetterPickerItem> _generateItems(
    int minValue,
    int maxValue,
    int currentValue,
    BetterDatePickerColumnType columnType,
    Function(BetterDatePickerFormatterOption)? formatter,
    Function(BetterDatePickerFilterOption)? filter,
  ) {
    List<BetterPickerItem> items = [];
    for (int value = minValue; value <= maxValue; value++) {
      BetterPickerItem item = BetterPickerItem(
        text:
            formatter?.call(
              BetterDatePickerFormatterOption(
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
          BetterDatePickerFilterOption(columnType: columnType, value: value),
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
    bool isDefaultShowToday = true,
    List<int>? minDate,
    List<int>? maxDate,
    List<BetterDatePickerColumnType>? columnTypes = const [
      BetterDatePickerColumnType.year,
      BetterDatePickerColumnType.month,
      BetterDatePickerColumnType.day,
    ],

    /// 格式化选项
    Function(BetterDatePickerFormatterOption)? formatter,
    //过滤选项
    Function(BetterDatePickerFilterOption)? filter,

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
    //最小日期
    int minYear = now.year - 5;
    int minMonth = 1;
    int minDay = 1;
    int maxYear = now.year + 5;
    int maxMonth = 12;
    int maxDay = _getDaysInMonth(maxYear, maxMonth);

    if (minDate != null) {
      if (minDate.length < 3) {
        throw Exception("minDate length must be 3");
      }
      minYear = minDate[0];
      minMonth = minDate[1];
      //避免超过该月最大天数
      int d = _getDaysInMonth(minYear, minMonth);
      minDay = minDate[2] > d ? d : minDate[2];
    }
    if (maxDate != null) {
      if (maxDate.length < 3) {
        throw Exception("maxDate length must be 3");
      }
      maxYear = maxDate[0];
      maxMonth = maxDate[1];
      //避免超过该月最大天数
      int d = _getDaysInMonth(maxYear, maxMonth);
      maxDay = maxDate[2] > d ? d : maxDate[2];
    }

    // 存储当前选中的值
    int currentYear;
    int currentMonth;
    int currentDay;

    //获取年份的列在columns的下标
    int yearColumnIndex = columnTypes!.indexWhere(
      (element) => element == BetterDatePickerColumnType.year,
    );
    int monthColumnIndex = columnTypes.indexWhere(
      (element) => element == BetterDatePickerColumnType.month,
    );
    int dayColumnIndex = columnTypes.indexWhere(
      (element) => element == BetterDatePickerColumnType.day,
    );

    //如果不需要默认显示当天时间，则设置为最小年月日
    if (!isDefaultShowToday) {
      currentYear = minYear;
      currentMonth = 1;
      currentDay = 1;
    } else {
      currentYear = now.year;
      currentMonth = now.month;
      currentDay = now.day;
    }

    //有默认值
    if (defaultValue != null) {
      if (defaultValue.length < 3) {
        throw Exception("defaultValue length must be 3");
      }
      if (yearColumnIndex != -1) {
        currentYear = defaultValue[yearColumnIndex];
      }
      if (monthColumnIndex != -1) {
        currentMonth = defaultValue[monthColumnIndex];
      }
      if (dayColumnIndex != -1) {
        currentDay = defaultValue[dayColumnIndex];
      }
    }

    // 列数据
    List<List<BetterPickerItem>> columns = [];
    //年
    if (columnTypes.contains(BetterDatePickerColumnType.year)) {
      columns.add(
        _generateItems(
          minYear,
          maxYear,
          currentYear,
          BetterDatePickerColumnType.year,
          formatter,
          filter,
        ),
      );
    }
    //月份
    if (columnTypes.contains(BetterDatePickerColumnType.month)) {
      columns.add(
        _generateItems(
          1,
          12,
          currentMonth,
          BetterDatePickerColumnType.month,
          formatter,
          filter,
        ),
      );
    }

    if (columnTypes.contains(BetterDatePickerColumnType.day)) {
      columns.add(
        _generateDayItems(minDay, maxDay, currentDay, formatter, filter),
      );
    }

    BetterPicker.show(
      context,
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
            //有显示天数的才需要判断更新
            if (columnTypes.contains(BetterDatePickerColumnType.day)) {
              // 检查年份或月份是否发生变化
              //获取年份的列在columns的下标
              int newYear = currentYear;
              if (yearColumnIndex != -1) {
                newYear = int.parse(selectedValues[yearColumnIndex].value);
              }
              int newMonth = currentMonth;
              if (monthColumnIndex != -1) {
                newMonth = int.parse(selectedValues[monthColumnIndex].value);
              }
              // 如果年份或月份发生变化，判断是否需要更新天数
              if (newYear != currentYear || newMonth != currentMonth) {
                currentYear = newYear;
                currentMonth = newMonth;
                int newMaxDay = _getDaysInMonth(currentYear, currentMonth);
                //天数最大值发生变化再改变
                if (newMaxDay != maxDay) {
                  maxDay = newMaxDay;
                  // 获取当前选中的天数
                  int selectedDay = int.parse(
                    selectedValues[dayColumnIndex].value,
                  );
                  // 重新生成天数列表
                  columns[dayColumnIndex] = _generateDayItems(
                    minDay,
                    maxDay,
                    selectedDay,
                    formatter,
                    filter,
                  );

                  // 更新当前天数
                  currentDay = selectedDay > maxDay ? maxDay : selectedDay;
                  updateColumns(columns);
                }
              }
            }
            onChange?.call(selectedValues);
          },
      columns: columns,
    );
  }
}
