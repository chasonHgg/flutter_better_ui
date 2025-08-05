import 'package:better_ui/better_button.dart';
import 'package:better_ui/better_popup.dart';
import 'package:better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterPopupPage extends StatelessWidget {
  const BetterPopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('弹出层'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            children: [
              Text('弹出位置'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterButton(
                text: '底部弹出'.tr,
                onClick: () => {
                  BetterPopup.show(
                    context,
                    child: SizedBox(
                      width: BetterScreenUtil.screenWidth,
                      height: 200.bw,
                      child: Center(
                        child: Text(
                          "底部弹出".tr,
                          style: TextStyle(fontSize: 14.bsp),
                        ),
                      ),
                    ),
                  ),
                },
              ),
              BetterButton(
                text: '左侧弹出'.tr,
                onClick: () => {
                  BetterPopup.show(
                    context,
                    position: BetterPopupPosition.left,
                    width: 150.bw,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.bw,
                        spreadRadius: 2.bw,
                      ),
                    ],
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "左侧弹出".tr,
                          style: TextStyle(fontSize: 14.bsp),
                        ),
                      ),
                    ),
                  ),
                },
              ),
              BetterButton(
                text: '右侧弹出'.tr,
                onClick: () => {
                  BetterPopup.show(
                    context,
                    position: BetterPopupPosition.right,
                    width: 150.bw,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.bw,
                        spreadRadius: 2.bw,
                      ),
                    ],
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "右侧弹出".tr,
                          style: TextStyle(fontSize: 14.bsp),
                        ),
                      ),
                    ),
                  ),
                },
              ),
              BetterButton(
                text: '顶部弹出'.tr,
                onClick: () => {
                  BetterPopup.show(
                    context,
                    position: BetterPopupPosition.top,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.bw,
                        spreadRadius: 2.bw,
                      ),
                    ],
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "顶部弹出".tr,
                          style: TextStyle(fontSize: 14.bsp),
                        ),
                      ),
                    ),
                  ),
                },
              ),
              BetterButton(
                text: '中间弹出'.tr,
                onClick: () => {
                  BetterPopup.show(
                    context,
                    position: BetterPopupPosition.center,
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "中间弹出".tr,
                          style: TextStyle(fontSize: 14.bsp),
                        ),
                      ),
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
