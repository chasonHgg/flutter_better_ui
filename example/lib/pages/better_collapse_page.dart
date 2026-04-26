import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_collapse.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BetterCollapsePage extends StatefulWidget {
  const BetterCollapsePage({super.key});

  @override
  State<BetterCollapsePage> createState() => _BetterCollapsePageState();
}

class _BetterCollapsePageState extends State<BetterCollapsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('折叠面板'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Theme.of(context).dividerColor, height: 1.bw),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BetterCollapse(
              accordion:true,
              children: [
                BetterCollapseItem(
                  title: Text(
                    "折叠面板".tr,
                    style: TextStyle(
                      fontSize: 14.bsp,
                      color: Get.isDarkMode
                          ? Colors.white
                          : ColorUtil.hexToColor("#323232"),
                    ),
                  ),
                  children: [
                    Text(
                      "1234",
                      style: TextStyle(
                        fontSize: 14.bsp,
                        color: Get.isDarkMode
                            ? ColorUtil.hexToColor("#707070")
                            : ColorUtil.hexToColor("#969799"),
                      ),
                    ),
                  ],
                ),
                BetterCollapseItem(
                  title: Text(
                    "折叠面板".tr,
                    style: TextStyle(
                      fontSize: 14.bsp,
                      color: Get.isDarkMode
                          ? Colors.white
                          : ColorUtil.hexToColor("#323232"),
                    ),
                  ),
                  children: [
                    Text(
                      "1234",
                      style: TextStyle(
                        fontSize: 14.bsp,
                        color: Get.isDarkMode
                            ? ColorUtil.hexToColor("#707070")
                            : ColorUtil.hexToColor("#969799"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
