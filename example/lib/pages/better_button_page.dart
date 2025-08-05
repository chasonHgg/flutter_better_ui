import 'package:better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:better_ui/better_button.dart';
import 'package:get/get.dart';

class BetterButtonPage extends StatelessWidget {
  const BetterButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('按钮'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(color: Theme.of(context).dividerColor, height: 1.bw),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('按钮类型'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              Wrap(
                spacing: 6.bw,
                runSpacing: 6.bw,
                children: [
                  BetterButton(text: '默认按钮'.tr),
                  BetterButton(
                    text: '主要按钮'.tr,
                    type: BetterButtonType.primary,
                    loadingText: "加载中...".tr,
                  ),
                  BetterButton(
                    text: '主要按钮'.tr,
                    type: BetterButtonType.primary,
                    loadingText: "加载中...".tr,
                  ),
                  BetterButton(
                    text: '主要按钮'.tr,
                    type: BetterButtonType.primary,
                    loadingText: "加载中...".tr,
                  ),
                  BetterButton(text: '成功按钮'.tr, type: BetterButtonType.success),
                  BetterButton(text: '警告按钮'.tr, type: BetterButtonType.warning),
                  BetterButton(text: '危险按钮'.tr, type: BetterButtonType.danger),
                  BetterButton(text: 'info按钮'.tr, type: BetterButtonType.info),
                ],
              ),
              SizedBox(height: 20.bw),
              Text('朴素按钮'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 4.bw),
              Wrap(
                spacing: 6.bw,
                runSpacing: 6.bw,
                children: [
                  BetterButton(
                    text: '朴素按钮'.tr,
                    plain: true,
                    type: BetterButtonType.primary,
                  ),
                  BetterButton(
                    text: '朴素按钮'.tr,
                    plain: true,
                    type: BetterButtonType.success,
                  ),
                  BetterButton(
                    text: '朴素按钮'.tr,
                    plain: true,
                    type: BetterButtonType.warning,
                  ),
                  BetterButton(
                    text: '朴素按钮'.tr,
                    plain: true,
                    type: BetterButtonType.danger,
                  ),
                ],
              ),
              SizedBox(height: 20.bw),
              Text('加载状态'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 4.bw),
              Wrap(
                spacing: 6.bw,
                runSpacing: 6.bw,
                children: [
                  BetterButton(type: BetterButtonType.primary, loading: true),
                  BetterButton(
                    type: BetterButtonType.primary,
                    loading: true,
                    loadingType: BetterButtonLoadingType.spinner,
                  ),
                  BetterButton(
                    text: '加载按钮'.tr,
                    type: BetterButtonType.success,
                    loading: true,
                    hideContentWhenLoading: false,
                  ),
                  BetterButton(
                    text: '加载按钮'.tr,
                    type: BetterButtonType.primary,
                    loading: true,
                    loadingType: BetterButtonLoadingType.spinner,
                    hideContentWhenLoading: false,
                  ),
                  BetterButton(
                    text: '主要按钮'.tr,
                    type: BetterButtonType.success,
                    loading: true,
                    loadingType: BetterButtonLoadingType.spinner,
                    loadingText: "加载中...".tr,
                  ),
                ],
              ),
              SizedBox(height: 20.bw),
              Text('渐变按钮'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 4.bw),
              Wrap(
                spacing: 6.bw,
                runSpacing: 6.bw,
                children: [
                  BetterButton(
                    text: '主要按钮'.tr,
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
                    text: '自定义颜色'.tr,
                    borderColor: Colors.transparent,
                    color: Colors.purple,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.bw),
              Text('禁用状态'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 4.bw),
              Wrap(
                spacing: 6.bw,
                runSpacing: 6.bw,
                children: [
                  BetterButton(
                    text: '禁用按钮'.tr,
                    type: BetterButtonType.success,
                    disabled: true,
                  ),
                ],
              ),
              SizedBox(height: 20.bw),
              Text('自定义内容'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 4.bw),
              BetterButton(
                type: BetterButtonType.success,
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    Text('自定义内容'.tr, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 20.bw),
              //屏幕宽度
            ],
          ),
        ),
      ),
    );
  }
}
