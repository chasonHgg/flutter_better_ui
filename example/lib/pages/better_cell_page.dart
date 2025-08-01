import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:better_ui/better_cell.dart';

class BetterCellPage extends StatelessWidget {
  const BetterCellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单元格'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(color: Theme.of(context).dividerColor, height: 0.5),
        ),
      ),
      body: Column(
        children: [
          BetterCell(
            height: 44.w,
            titleText: '单元格'.tr,
            isShowBorder: true,
            isShowArrowRight: true,
          ),
          BetterCell(
            height: 44.w,
            titleText: '单元格'.tr,
            valueText: '内容'.tr,
            isShowBorder: true,
            isShowArrowRight: true,
          ),
          BetterCell(
            height: 44.w,
            titleText: '禁止点击'.tr,
            isShowBorder: true,
            isShowArrowRight: true,
            disabled: true,
          ),
          BetterCell(
            height: 44.w,
            titleText: '单元格'.tr,
            valueText: '内容'.tr,
            isShowBorder: true,
          ),
          BetterCell(
            height: 44.w,
            titleWidget: Row(
              children: [
                Icon(Icons.person, size: 14.sp),
                SizedBox(width: 4.w),
                Text('自定义单元格'.tr, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
            valueWidget: Row(
              children: [
                Icon(Icons.person, size: 14.sp),
                SizedBox(width: 4.w),
                Text('自定义单元格'.tr, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
