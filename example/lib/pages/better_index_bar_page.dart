import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_index_bar.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';
import 'package:get/get.dart';

class BetterIndexBarPage extends StatefulWidget {
  const BetterIndexBarPage({super.key});

  @override
  State<BetterIndexBarPage> createState() => _BetterIndexBarPageState();
}

class _BetterIndexBarPageState extends State<BetterIndexBarPage> {
  List<String> azList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('索引栏'.tr)),
      backgroundColor: Get.isDarkMode ? ColorUtil.hexToColor("#1c1c1e") : Colors.white,
      body: BetterIndexBar(
        indexBarColor: Get.isDarkMode ? ColorUtil.hexToColor("#fff") : ColorUtil.hexToColor("#323233"),
        indexBarActiveColor: ColorUtil.hexToColor("#1989fa"),
        headerSlivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 100.bw,
              alignment: Alignment.center,
              color: Get.isDarkMode ? ColorUtil.hexToColor("#3a3a3c") : ColorUtil.hexToColor("#fff"),
              child: Text("我是自定义内容".tr, style: TextStyle(color: Get.isDarkMode ? ColorUtil.hexToColor("#ffffff") : ColorUtil.hexToColor("#323233")),),
            ),
          ),
        ],
        items: [
          for (var item in azList)
            BetterIndexBarItem(
              header: BetterIndexBarHeader(
                anchor: item,
                height: 32.bw,
                titleWidget: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.bw),
                  decoration: BoxDecoration(
                    color:Get.isDarkMode ? ColorUtil.hexToColor("#000") : ColorUtil.hexToColor("#F7F8FA"),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.bsp,
                      color: Get.isDarkMode ? ColorUtil.hexToColor("#ffffff") : ColorUtil.hexToColor("#323233"),
                    ),
                  ),
                ),
              ),
              list: [
                for (var i in List.generate(10, (index) => index))
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.bw),
                    child: Container(
                      height: 44.bw,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? ColorUtil.hexToColor("#1c1c1e") : Colors.white,
                        border: Border(
                          bottom: i==9 ? BorderSide.none : BorderSide(
                            color: Get.isDarkMode ? ColorUtil.hexToColor("#3a3a3c") : ColorUtil.hexToColor("#E5E5E5"),
                            width: 1.bw,
                          ),
                        ),
                      ),
                      child: Text("$item-text"),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
