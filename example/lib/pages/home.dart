import 'package:better_ui/better_cell.dart';
import 'package:better_ui/theme/themes/better_dark_theme.dart';
import 'package:better_ui/theme/themes/better_light_theme.dart';
import 'package:better_ui/utils/better_screen_util.dart';
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.changeTheme(betterDarkTheme);
              },
              child: Text('切换黑暗主题'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.changeTheme(betterLightTheme);
              },
              child: Text('切换白色主题'),
            ),
            ElevatedButton(
              onPressed: () {
                I18nTranslations.updateLocale(I18nLocale.en_US);
              },
              child: Text('切换英文'),
            ),
            ElevatedButton(
              onPressed: () {
                I18nTranslations.updateLocale(I18nLocale.zh_CN);
              },
              child: Text('切换中文'),
            ),
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
              onClick: () {
                Get.toNamed("/betterCell");
              },
            ),
          ],
        ),
      ),
    );
  }
}
