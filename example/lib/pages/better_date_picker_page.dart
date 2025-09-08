import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_date_picker.dart';
import 'package:flutter_better_ui/better_picker_widget.dart';
import 'package:flutter_better_ui/better_toast.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterDatePickerPage extends StatelessWidget {
  const BetterDatePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("日期选择".tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BetterCell(
                height: 44.bw,
                titleText: '基础用法'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '不默认显示当天时间'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    isDefaultShowToday: false,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '指定日期范围'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    minDate: [2022, 1, 1],
                    maxDate: [2024, 12, 31],
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '格式化选项'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    formatter: (BetterDatePickerFormatterOption option) {
                      if (option.columnType ==
                          BetterDatePickerColumnType.year) {
                        return "${option.text}年";
                      }
                      if (option.columnType ==
                          BetterDatePickerColumnType.month) {
                        return "${option.text}月";
                      }
                      if (option.columnType == BetterDatePickerColumnType.day) {
                        return "${option.text}日";
                      }
                      return option.text;
                    },
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '过滤选项'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    columnTypes: [
                      BetterDatePickerColumnType.year,
                      BetterDatePickerColumnType.month,
                    ],
                    filter: (BetterDatePickerFilterOption option) {
                      if (option.columnType ==
                          BetterDatePickerColumnType.month) {
                        if (option.value % 6 == 0) {
                          return true;
                        }
                        return false;
                      }
                      return true;
                    },
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '指定默认日期'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    defaultValue: [2025, 9, 8],
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.bw),
              Text("选择类型自由组合".tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                height: 44.bw,
                titleText: '选择类型(选择年)'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    columnTypes: [BetterDatePickerColumnType.year],
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '选择类型(选择月日)'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    columnTypes: [
                      BetterDatePickerColumnType.month,
                      BetterDatePickerColumnType.day,
                    ],
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '选择类型(选择年月)'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterDatePicker.show(
                    context,
                    title: '日期选择'.tr,
                    columnTypes: [
                      BetterDatePickerColumnType.year,
                      BetterDatePickerColumnType.month,
                    ],
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
