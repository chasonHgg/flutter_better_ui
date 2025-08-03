import 'package:better_ui/better_cell.dart';
import 'package:better_ui/better_toast.dart';
import 'package:better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterToastPage extends StatelessWidget {
  const BetterToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('轻提示'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('基础用法'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: '文字提示'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () =>
                    BetterToast.show(context, message: 'This is a toast'),
              ),
              BetterCell(
                titleText: '成功提示'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () =>
                    BetterToast.showSuccess(context, message: '成功文案'.tr),
              ),
              BetterCell(
                titleText: '失败提示'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () =>
                    BetterToast.showError(context, message: '失败文案'.tr),
              ),
              BetterCell(
                titleText: '加载提示'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.showLoading(context, forbidClick: true),
                  Future.delayed(Duration(seconds: 2), () {
                    BetterToast.hideLoading();
                  }),
                },
              ),
              BetterCell(
                titleText: '文字加载提示'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.showLoading(
                    context,
                    forbidClick: true,
                    message: '加载中...',
                  ),
                  Future.delayed(Duration(seconds: 2), () {
                    BetterToast.hideLoading();
                  }),
                },
              ),
              SizedBox(height: 20.bw),
              Text('自定义位置'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: '顶部位置'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.show(
                    context,
                    message: 'This is a toast',
                    position: BetterToastPosition.top,
                  ),
                },
              ),
              BetterCell(
                titleText: '中间位置'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.show(
                    context,
                    message: 'This is a toast',
                    position: BetterToastPosition.center,
                  ),
                },
              ),
              BetterCell(
                titleText: '底部位置'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.show(context, message: 'This is a toast'),
                },
              ),
              SizedBox(height: 20.bw),
              Text('自定义内容'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: '自定义图标'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.show(
                    context,
                    message: '自定义图标'.tr,
                    width: 120.bw,
                    height: 120.bw,
                    icon: Icon(Icons.favorite, color: Colors.red, size: 40.bw),
                    position: BetterToastPosition.center,
                  ),
                },
              ),
              BetterCell(
                titleText: '自定义内容'.tr,
                isShowArrowRight: true,
                isShowBorder: true,
                onClick: () => {
                  BetterToast.show(
                    context,
                    child: Image.asset(
                      'assets/images/cat.jpeg',
                      width: 200.bw,
                      height: 200.bw,
                    ),
                    position: BetterToastPosition.center,
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
