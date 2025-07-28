import 'package:better_ui/theme/better_theme_controller.dart';
import 'package:better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:better_ui/better_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:better_ui/theme/themes/better_dark_theme.dart';

class BetterButtonPage extends StatefulWidget {
  const BetterButtonPage({super.key});

  @override
  State<BetterButtonPage> createState() => _BetterButtonPageState();
}

class _BetterButtonPageState extends State<BetterButtonPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<BetterThemeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Button'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5), // 边框高度
          child: Container(color: Colors.grey[300], height: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          width: 750.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  themeController.changeTheme(betterDarkTheme);
                },
                child: Text('切换黑暗主题'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeController.changeTheme(betterLightTheme);
                },
                child: Text('切换白色主题'),
              ),
              Text('按钮类型', style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 10.h),
              BetterButton(text: '默认按钮', loading: true),
              SizedBox(height: 10.h),
              BetterButton(
                text: '主要按钮',
                width: 120.w,
                type: BetterButtonType.primary,
                loading: isLoading,
                loadingText: "加载中...",
                onClick: () {
                  setState(() => isLoading = !isLoading);
                },
              ),
              SizedBox(height: 10.h),
              BetterButton(
                text: '成功按钮',
                type: BetterButtonType.success,
                loading: true,
                hideContentWhenLoading: false,
              ),
              SizedBox(height: 10.h),
              BetterButton(text: '警告按钮', type: BetterButtonType.warning),
              SizedBox(height: 10.h),
              BetterButton(text: '危险按钮', type: BetterButtonType.danger),
              SizedBox(height: 10.h),
              BetterButton(text: 'info按钮', type: BetterButtonType.info),
              SizedBox(height: 20.h),
              Text('朴素按钮', style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 10.h),
              BetterButton(
                text: '朴素按钮',
                plain: true,
                type: BetterButtonType.primary,
                loading: true,
                hideContentWhenLoading: false,
              ),
              SizedBox(height: 10.h),
              BetterButton(
                text: '朴素按钮',
                plain: true,
                type: BetterButtonType.success,
              ),
              SizedBox(height: 10.h),
              BetterButton(
                text: '朴素按钮',
                plain: true,
                type: BetterButtonType.warning,
              ),
              SizedBox(height: 10.h),
              BetterButton(
                text: '朴素按钮',
                plain: true,
                type: BetterButtonType.danger,
              ),
              SizedBox(height: 10.h),
              SizedBox(height: 20.h),
              Text('加载状态', style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 10.h),
              BetterButton(
                text: '主要按钮',
                type: BetterButtonType.primary,
                loading: true,
              ),
              BetterButton(
                text: '主要按钮',
                type: BetterButtonType.primary,
                loading: true,
                loadingType: BetterButtonLoadingType.spinner,
              ),
              Container(padding: EdgeInsets.symmetric(horizontal: 16.w)),
              BetterButton(
                text: '主要按钮',
                type: BetterButtonType.primary,
                gradient: LinearGradient(
                  colors: [Colors.red[400]!, Colors.red[900]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 0.7],
                  tileMode: TileMode.clamp,
                ),
              ),
              BetterButton(
                text: '自定义颜色',
                borderColor: Colors.transparent,
                color: Colors.purple,
                textStyle: TextStyle(color: Colors.white),
              ),
              BetterButton(
                text: '禁用按钮',
                type: BetterButtonType.success,
                disabled: true,
              ),
              BetterButton(
                type: BetterButtonType.success,
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    Text('自定义内容', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
