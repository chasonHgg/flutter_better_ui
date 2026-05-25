import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_dialog.dart';
import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BetterDialogPage extends StatefulWidget {
  const BetterDialogPage({super.key});

  @override
  State<BetterDialogPage> createState() => _BetterDialogPageState();
}

class _BetterDialogPageState extends State<BetterDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("弹出框".tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            children: [
              BetterCell(
                height: 44.bw,
                titleText: '提示弹窗'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onTap: () {
                  BetterDialog.showDialog(title: "提示弹窗".tr, content: "提示弹窗".tr);
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '提示弹窗(无标题)'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onTap: () {
                  BetterDialog.showDialog(content: "提示弹窗(无标题)".tr);
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '确认弹窗'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onTap: () {
                  BetterDialog.showDialog(
                    title: "标题".tr,
                    content: "确认弹窗".tr,
                    showCancelButton: true,
                  );
                },
              ),
              BetterCell(
                height: 44.bw,
                titleText: '自定义按钮'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onTap: () {
                  BetterDialog.showDialog(
                    title: "标题".tr,
                    content: "自定义按钮".tr,
                    buttomWidget: Padding(
                      padding: EdgeInsetsGeometry.only(
                        bottom: 10.bw,
                        left: 16.bw,
                        right: 16.bw,
                      ),
                      child: BetterButton(
                        width: double.infinity,
                        text: "确认".tr,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.bsp,
                        ),
                        decoration: BoxDecoration(color: Colors.red),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
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
