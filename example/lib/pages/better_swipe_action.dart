import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_cell.dart';
import 'package:flutter_better_ui/better_swipe_cell.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterSwipeAction extends StatelessWidget {
  const BetterSwipeAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滑动单元格')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('基础用法'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwipeCell(
                leftActions: [
                  BetterSwipeCellAction(
                    width: 60.bw,
                    value: '收藏',
                    onClick: (value) async {
                      return true;
                    },
                    child: Container(
                      color: Colors.blue,
                      height: 54.bw,
                      alignment: Alignment.center,
                      child: Text(
                        '收藏'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14.bsp),
                      ),
                    ),
                  ),
                ],
                rightActions: [
                  BetterSwipeCellAction(
                    width: 60.bw,
                    value: '删除',
                    onClick: (value) async {
                      return true;
                    },
                    child: Container(
                      color: Colors.red,
                      height: 54.bw,
                      alignment: Alignment.center,
                      child: Text(
                        '删除'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14.bsp),
                      ),
                    ),
                  ),
                  BetterSwipeCellAction(
                    width: 60.bw,
                    value: '收藏',
                    onClick: (value) async {
                      return true;
                    },
                    child: Container(
                      color: Colors.blue,
                      height: 54.bw,
                      alignment: Alignment.center,
                      child: Text(
                        '收藏'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14.bsp),
                      ),
                    ),
                  ),
                ],
                child: BetterCell(
                  height: 54.bw,
                  titleText: '滑动单元格'.tr,
                  valueText: '内容'.tr,
                ),
              ),
              SizedBox(height: 20.bw),
              Text('异步控制'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSwipeCell(
                rightActions: [
                  BetterSwipeCellAction(
                    width: 60.bw,
                    value: '收藏',
                    child: Container(
                      color: Colors.blue,
                      height: 54.bw,
                      alignment: Alignment.center,
                      child: Text(
                        '收藏'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14.bsp),
                      ),
                    ),
                    onClick: (value) async {
                      final result = await showCupertinoDialog<bool>(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text('标题'.tr),
                          content: Text('是否收藏'.tr),
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
                ],
                child: BetterCell(height: 54.bw, titleText: '异步控制'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
