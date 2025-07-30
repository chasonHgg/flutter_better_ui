import 'package:better_ui/theme/themes/better_dark_theme.dart';
import 'package:better_ui/theme/themes/better_light_theme.dart';
import 'package:example/i18n/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Better UI'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5), // 边框高度
          child: Container(color: Colors.grey[300], height: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
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
              Text("Flutter ${"移动端组件库".tr}", style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 20.h),
              Text("基础组件".tr, style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 10.h),
              renderRow(context, "按钮".tr),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderRow(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed("/betterButton");
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      child: SizedBox(
        height: 30.h,
        child: Row(
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 14.sp)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 14.sp),
          ],
        ),
      ),
    );
  }
}
