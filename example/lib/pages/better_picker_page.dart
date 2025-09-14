import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_picker.dart';
import 'package:flutter_better_ui/better_picker_widget.dart';
import 'package:flutter_better_ui/better_toast.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterPickerPage extends StatelessWidget {
  const BetterPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("选择器".tr)),
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
                  BetterPicker.show(
                    context,
                    title: '标题'.tr,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                    columns: [
                      BetterPickerItem(text: '${'选项'.tr}1', value: '1'),
                      BetterPickerItem(text: '${'选项'.tr}2', value: '2'),
                      BetterPickerItem(text: '${'选项'.tr}3', value: '3'),
                      BetterPickerItem(text: '${'选项'.tr}4', value: '4'),
                      BetterPickerItem(text: '${'选项'.tr}5', value: '5'),
                      BetterPickerItem(text: '${'选项'.tr}6', value: '6'),
                      BetterPickerItem(text: '${'选项'.tr}7', value: '7'),
                      BetterPickerItem(text: '${'选项'.tr}8', value: '8'),
                      BetterPickerItem(text: '${'选项'.tr}9', value: '9'),
                      BetterPickerItem(text: '${'选项'.tr}10', value: '10'),
                    ],
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '齿轮选择器'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPicker.show(
                    context,
                    title: '标题'.tr,
                    diameterRatio: 2,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                    columns: [
                      BetterPickerItem(text: '${'选项'.tr}1', value: '1'),
                      BetterPickerItem(text: '${'选项'.tr}2', value: '2'),
                      BetterPickerItem(text: '${'选项'.tr}3', value: '3'),
                      BetterPickerItem(text: '${'选项'.tr}4', value: '4'),
                      BetterPickerItem(text: '${'选项'.tr}5', value: '5'),
                      BetterPickerItem(text: '${'选项'.tr}6', value: '6'),
                      BetterPickerItem(text: '${'选项'.tr}7', value: '7'),
                      BetterPickerItem(text: '${'选项'.tr}8', value: '8'),
                      BetterPickerItem(text: '${'选项'.tr}9', value: '9'),
                      BetterPickerItem(text: '${'选项'.tr}10', value: '10'),
                    ],
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '默认选中'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPicker.show(
                    context,
                    title: '默认选中'.tr,
                    diameterRatio: 2,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                    columns: [
                      BetterPickerItem(text: '${'选项'.tr}1', value: '1'),
                      BetterPickerItem(text: '${'选项'.tr}2', value: '2'),
                      BetterPickerItem(text: '${'选项'.tr}3', value: '3'),
                      BetterPickerItem(text: '${'选项'.tr}4', value: '4'),
                      BetterPickerItem(
                        text: '${'选项'.tr}5',
                        value: '5',
                        isSelected: true,
                      ),
                      BetterPickerItem(text: '${'选项'.tr}6', value: '6'),
                      BetterPickerItem(text: '${'选项'.tr}7', value: '7'),
                      BetterPickerItem(text: '${'选项'.tr}8', value: '8'),
                      BetterPickerItem(text: '${'选项'.tr}9', value: '9'),
                      BetterPickerItem(text: '${'选项'.tr}10', value: '10'),
                    ],
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '多列选择'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPicker.show(
                    context,
                    title: '标题'.tr,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                    columns: [
                      [
                        BetterPickerItem(
                          text: '${'周'.tr}1',
                          value: '${'周'.tr}1',
                        ),
                        BetterPickerItem(
                          text: '${'周'.tr}2',
                          value: '${'周'.tr}2',
                        ),
                        BetterPickerItem(
                          text: '${'周'.tr}3',
                          value: '${'周'.tr}3',
                        ),
                      ],
                      [
                        BetterPickerItem(text: '上午'.tr, value: '上午'),
                        BetterPickerItem(text: '下午'.tr, value: '下午'),
                        BetterPickerItem(text: '晚上'.tr, value: '晚上'),
                      ],
                    ],
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '级联选择'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPicker.show(
                    context,
                    title: '标题'.tr,
                    onConfirm: (List<BetterPickerItem> selectedValues) {
                      BetterToast.show(
                        context,
                        message: selectedValues.map((e) => e.value).join(','),
                      );
                    },
                    columns: [
                      BetterPickerItem(
                        text: '浙江'.tr,
                        value: 'Monday',
                        children: [
                          BetterPickerItem(
                            text: '杭州'.tr,
                            value: 'Hangzhou',
                            children: [
                              BetterPickerItem(text: '西湖区'.tr, value: 'Xihu'),
                              BetterPickerItem(
                                text: '上城区'.tr,
                                value: 'Shangcheng',
                              ),
                            ],
                          ),
                          BetterPickerItem(
                            text: '温州'.tr,
                            value: 'Wenzhou',
                            children: [
                              BetterPickerItem(
                                text: '鹿城区'.tr,
                                value: 'Luchang',
                              ),
                              BetterPickerItem(text: '瓯海区'.tr, value: 'Ouhai'),
                            ],
                          ),
                        ],
                      ),
                      BetterPickerItem(
                        text: '福建'.tr,
                        value: 'Fujian',
                        children: [
                          BetterPickerItem(
                            text: '福州'.tr,
                            value: 'Fuzhou',
                            children: [
                              BetterPickerItem(text: '鼓楼区'.tr, value: 'Gulou'),
                              BetterPickerItem(
                                text: '台江区'.tr,
                                value: 'Taijiang',
                              ),
                            ],
                          ),
                          BetterPickerItem(
                            text: '厦门'.tr,
                            value: 'Xiamen',
                            children: [
                              BetterPickerItem(text: '思明区'.tr, value: 'Siming'),
                              BetterPickerItem(text: '湖里区'.tr, value: 'Huli'),
                            ],
                          ),
                        ],
                      ),
                    ],
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
