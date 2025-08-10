import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_picker.dart';
import 'package:flutter_better_ui/better_picker_widget.dart';
import 'package:flutter_better_ui/theme/themes/better_dark_theme.dart';
import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:example/i18n/translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Get.changeTheme(
                Get.isDarkMode ? betterLightTheme : betterDarkTheme,
              );
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
                context,
                onConfirm: (value) {
                  if (value.first.value == 'zh') {
                    I18nTranslations.updateLocale(I18nLocale.zh_CN);
                  } else {
                    I18nTranslations.updateLocale(I18nLocale.en_US);
                  }
                },
                columns: [
                  BetterPickerItem(text: '中文', value: 'zh'),
                  BetterPickerItem(text: 'English', value: 'en'),
                ],
              );
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Flutter ${"移动端组件库".tr}", style: TextStyle(fontSize: 16.bsp)),
            SizedBox(height: 20.bw),
            Text("基础组件".tr, style: TextStyle(fontSize: 14.bsp)),
            SizedBox(height: 10.bw),
            BetterCell(
              titleText: "按钮".tr,
              isShowArrowRight: true,
              isShowBorder: true,
              onClick: () {
                Get.toNamed("/betterButton");
              },
            ),
            BetterCell(
              titleText: "单元格".tr,
              isShowArrowRight: true,
              isShowBorder: true,
              onClick: () {
                Get.toNamed("/betterCell");
              },
            ),
            BetterCell(
              titleText: "轻提示".tr,
              isShowArrowRight: true,
              isShowBorder: true,
              onClick: () {
                Get.toNamed("/betterToast");
              },
            ),
            BetterCell(
              titleText: "弹出层".tr,
              isShowArrowRight: true,
              onClick: () {
                Get.toNamed("/betterPopup");
              },
            ),
            SizedBox(height: 20.bw),
            Text("表单组件".tr, style: TextStyle(fontSize: 14.bsp)),
            SizedBox(height: 10.bw),
            BetterCell(
              titleText: "选择器".tr,
              isShowArrowRight: true,
              isShowBorder: true,
              onClick: () {
                Get.toNamed("/betterPicker");
              },
            ),
            BetterCell(
              titleText: "开关".tr,
              isShowArrowRight: true,
              isShowBorder: true,
              onClick: () {
                Get.toNamed("/betterSwitch");
              },
            ),
          ],
        ),
      ),
    );
  }
}
