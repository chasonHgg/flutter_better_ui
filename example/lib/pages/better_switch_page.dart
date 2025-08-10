import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_switch.dart';
import 'package:flutter_better_ui/better_toast.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterSwitchPage extends StatefulWidget {
  const BetterSwitchPage({super.key});

  @override
  State<BetterSwitchPage> createState() => _BetterSwitchPageState();
}

class _BetterSwitchPageState extends State<BetterSwitchPage> {
  bool customBtnIsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('开关'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('基础用法'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(),
              SizedBox(height: 20.bw),
              Text('加载中'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(loading: true),
              SizedBox(height: 20.bw),
              Text('自定义大小'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(width: 44.bw, height: 26.bw),
              SizedBox(height: 20.bw),
              Text('自定义颜色'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(
                defaultValue: true,
                activeBackgroundColor: Colors.red,
              ),
              SizedBox(height: 20.bw),
              Text('自定义按钮'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(
                width: 50.bw,
                height: 30.bw,
                onChanged: (value) {
                  setState(() {
                    customBtnIsChecked = value;
                  });
                },
                ballWidget: Container(
                  width: 26.bw,
                  height: 26.bw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    customBtnIsChecked ? Icons.check : Icons.close,
                    color: Theme.of(context).primaryColor,
                    size: 16.bw,
                  ),
                ),
              ),
              SizedBox(height: 20.bw),
              Text('禁用按钮'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(
                disabled: true,
                onChanged: (value) {
                  BetterToast.showError(context, message: '禁用按钮');
                },
              ),
              SizedBox(height: 20.bw),
              Text('异步控制'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwitch(
                onUpdateChange: () async {
                  // 显示确认对话框并等待用户选择
                  final result = await showCupertinoDialog<bool>(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text('标题'.tr),
                      content: Text('是否切换开关'.tr),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            '取消'.tr,
                            style: TextStyle(
                              fontSize: 14.bsp,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            '确定'.tr,
                            style: TextStyle(
                              fontSize: 14.bsp,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ],
                    ),
                  );
                  return result ?? false; // 返回用户选择结果
                },
              ),
              SizedBox(height: 20.bw),
              Text('配合单元格使用'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterCell(
                titleText: '配合单元格使用'.tr,
                valueWidget: BetterSwitch(width: 44.bw, height: 26.bw),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
