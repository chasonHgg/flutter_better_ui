import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_collapse.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';
import 'package:get/get.dart';

class BetterCollapsePage extends StatefulWidget {
  const BetterCollapsePage({super.key});

  @override
  State<BetterCollapsePage> createState() => _BetterCollapsePageState();
}

class _BetterCollapsePageState extends State<BetterCollapsePage> {
  late final ExpansibleController _expansibleController;

  @override
  void initState() {
    super.initState();
    _expansibleController = ExpansibleController();
  }

  @override
  void dispose() {
    _expansibleController.dispose();
    super.dispose();
  }

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
            Padding(
              padding: EdgeInsets.all(16.bw),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _expansibleController.expand,
                      child: Text('展开'.tr),
                    ),
                  ),
                  SizedBox(width: 12.bw),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _expansibleController.collapse,
                      child: Text('收起'.tr),
                    ),
                  ),
                ],
              ),
            ),
            BetterCollapse(
              expansibleController: _expansibleController,
              accordion: true,
              children: BetterCollapseItem(
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
            ),
          ],
        ),
      ),
    );
  }
}
