import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_popup.dart';
import 'package:flutter_better_ui/better_toast.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterPopupPage extends StatelessWidget {
  const BetterPopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    BetterThemeExtension theme = Theme.of(
      context,
    ).extension<BetterThemeExtension>()!;
    return Scaffold(
      appBar: AppBar(title: Text('弹出层'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('弹出位置'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              Row(
                children: [
                  renderPositionRowItem(
                    context: context,
                    title: '底部弹出'.tr,
                    icon: CupertinoIcons.chevron_down,
                    position: BetterPopupPosition.bottom,
                    height: 200.bw,
                    theme: theme,
                  ),
                  renderPositionRowItem(
                    context: context,
                    title: '顶部弹出'.tr,
                    icon: CupertinoIcons.chevron_up,
                    position: BetterPopupPosition.top,
                    theme: theme,
                  ),
                  renderPositionRowItem(
                    context: context,
                    title: '左侧弹出'.tr,
                    width: 200.bw,
                    icon: CupertinoIcons.chevron_left,
                    position: BetterPopupPosition.left,
                    theme: theme,
                  ),
                  renderPositionRowItem(
                    context: context,
                    title: '右侧弹出'.tr,
                    width: 200.bw,
                    icon: CupertinoIcons.chevron_right,
                    position: BetterPopupPosition.right,
                    theme: theme,
                  ),
                  renderPositionRowItem(
                    context: context,
                    title: '居中弹出'.tr,
                    width: 150.bw,
                    height: 150.bw,
                    icon: Icons.center_focus_strong,
                    position: BetterPopupPosition.center,
                    theme: theme,
                  ),
                ],
              ),
              SizedBox(height: 20.bw),
              Text('关闭图标'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: '关闭图标'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPopup.show(
                    context,
                    height: 200.bw,
                    child: Center(
                      child: Text(
                        '关闭图标'.tr,
                        style: TextStyle(fontSize: 14.bsp),
                      ),
                    ),
                    isShowCloseIcon: true,
                  );
                },
              ),
              BetterCell(
                titleText: '自定义图标'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPopup.show(
                    context,
                    height: 200.bw,
                    closeIcon: Positioned(
                      right: 16.bw,
                      top: 16.bw,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(CupertinoIcons.cloud_sleet_fill),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '自定义图标'.tr,
                        style: TextStyle(fontSize: 14.bsp),
                      ),
                    ),
                    isShowCloseIcon: true,
                  );
                },
              ),
              BetterCell(
                titleText: '图标位置'.tr,
                isShowArrowRight: true,
                onClick: () {
                  BetterPopup.show(
                    context,
                    height: 200.bw,
                    closeIcon: Positioned(
                      left: 16.bw,
                      top: 16.bw,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, size: 24.bw),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '图标位置'.tr,
                        style: TextStyle(fontSize: 14.bsp),
                      ),
                    ),
                    isShowCloseIcon: true,
                  );
                },
              ),
              SizedBox(height: 20.bw),
              Text('事件监听'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: '关闭事件'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                onClick: () {
                  BetterPopup.show(
                    context,
                    height: 200.bw,
                    child: Center(
                      child: Text(
                        '关闭事件'.tr,
                        style: TextStyle(fontSize: 14.bsp),
                      ),
                    ),
                    isShowCloseIcon: true,
                    onClose: () {
                      BetterToast.show(context, message: '关闭了');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderPositionRowItem({
    required BuildContext context,
    required String title,
    required BetterPopupPosition position,
    required IconData icon,
    required BetterThemeExtension theme,
    double? width,
    double? height,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          BetterPopup.show(
            context,
            position: position,
            width: width,
            height: height,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.bw,
                spreadRadius: 2.bw,
              ),
            ],
            child: Center(
              child: Text(title.tr, style: TextStyle(fontSize: 14.bsp)),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 10.bw, bottom: 10.bw),
          decoration: BoxDecoration(
            color: theme.popupTheme.backgroundColor,
            //右边框
            border: Border(
              right: BorderSide(color: theme.borderColor, width: 1.bw),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              SizedBox(height: 8.bw),
              Text(
                title.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.bsp),
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
