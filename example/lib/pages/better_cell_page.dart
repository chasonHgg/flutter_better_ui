import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_better_ui/better_cell.dart';

class BetterCellPage extends StatelessWidget {
  const BetterCellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单元格'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(color: Theme.of(context).dividerColor, height: 1.bw),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            children: [
              BetterCell(
                height: 44.bw,
                titleText: '单元格'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
              ),
              BetterCell(
                height: 44.bw,
                titleText: '单元格'.tr,
                valueText: '内容'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
              ),
              BetterCell(
                height: 44.bw,
                titleText: '禁止点击'.tr,
                isShowBorder: true,
                isShowArrowRight: true,
                disabled: true,
              ),
              BetterCell(
                height: 44.bw,
                titleText: '单元格'.tr,
                valueText: '内容'.tr,
                isShowBorder: true,
              ),
              BetterCell(
                height: 44.bw,
                titleWidget: Row(
                  children: [
                    Icon(Icons.person, size: 16.bsp),
                    SizedBox(width: 4.bw),
                    Text('自定义单元格'.tr, style: TextStyle(fontSize: 14.bsp)),
                  ],
                ),
                valueWidget: Row(
                  children: [
                    Icon(Icons.person, size: 16.bsp),
                    SizedBox(width: 4.bw),
                    Text('自定义单元格'.tr, style: TextStyle(fontSize: 14.bsp)),
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
