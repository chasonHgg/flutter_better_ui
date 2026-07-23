import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_picker.dart';
import 'package:flutter_better_ui/better_picker_widget.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:example/i18n/translations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Better UI'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(color: Theme.of(context).dividerColor, height: 0.5),
        ),
        //右边切换主题和语种
        actions: [
          //切换主题的图标
          IconButton(
            onPressed: () {
              BetterUi.toggleTheme();
            },
            //判断显示主题的图标
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: () {
              BetterPicker.show(
                onConfirm: (value) {
                  if (value.first.value == I18nLocale.zhCN.name) {
                    I18nTranslations.updateLocale(I18nLocale.zhCN);
                  } else {
                    I18nTranslations.updateLocale(I18nLocale.enUS);
                  }
                },
                columns: [
                  BetterPickerItem(text: '中文', value: I18nLocale.zhCN.name),
                  BetterPickerItem(
                    text: 'English',
                    value: I18nLocale.enUS.name,
                  ),
                ],
              );
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Flutter ${"移动端组件库".tr}",
                style: TextStyle(fontSize: 16.bsp),
              ),
              SizedBox(height: 20.bw),
              Text("基础组件".tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: "按钮".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterButton");
                },
              ),
              BetterCell(
                titleText: "单元格".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterCell");
                },
              ),
              BetterCell(
                titleText: "轻提示".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterToast");
                },
              ),
              BetterCell(
                titleText: "弹出层".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterPopup");
                },
              ),
              SizedBox(height: 20.bw),
              Text("表单组件".tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: "选择器".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterPicker");
                },
              ),
              BetterCell(
                titleText: "开关".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterSwitch");
                },
              ),
              BetterCell(
                titleText: "滑块".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterSlider");
                },
              ),
              BetterCell(
                titleText: "日期选择".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterDatePicker");
                },
              ),
              BetterCell(
                titleText: "时间选择".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterTimePicker");
                },
              ),
              SizedBox(height: 20.bw),
              Text("反馈组件".tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: "滑动单元格".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterSwipeAction");
                },
              ),
              BetterCell(
                titleText: "滑动按钮".tr,
                isShowArrowRight: true,
                onTap: () {
                  context.push("/betterSlideAction");
                },
              ),
              BetterCell(
                titleText: "弹出框".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterDialog");
                },
              ),
              SizedBox(height: 20.bw),
              Text("展示组件".tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: "气泡弹出框".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterPopover");
                },
              ),
              BetterCell(
                titleText: "轮播图".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterSwiper");
                },
              ),
              BetterCell(
                titleText: "图片预览".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterImagePreview");
                },
              ),
              BetterCell(
                titleText: "跑马灯".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterMarquee");
                },
              ),
              BetterCell(
                titleText: "折叠面板".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterCollapse");
                },
              ),
              BetterCell(
                titleText: "骨架屏".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterSkeleton");
                },
              ),
              BetterCell(
                titleText: "进度条".tr,
                isShowArrowRight: true,
                onTap: () {
                  context.push("/betterProgress");
                },
              ),
              SizedBox(height: 20.bw),
              Text("业务组件".tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: "索引栏".tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onTap: () {
                  context.push("/betterIndexBar");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
