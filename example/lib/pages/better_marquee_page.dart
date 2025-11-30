import 'package:example/constant/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_marquee.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';
import 'package:get/get.dart';

class BetterMarqueePage extends StatefulWidget {
  const BetterMarqueePage({super.key});

  @override
  State<BetterMarqueePage> createState() => _BetterMarqueePageState();
}

class _BetterMarqueePageState extends State<BetterMarqueePage> {
  List<String> textList = ['hello world hello world hello world hello world'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('跑马灯'.tr)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
              child: Text('基础用法'.tr, style: TextStyle(fontSize: 14.bsp)),
            ),
            BetterMarquee(
              height: 40.bw,
              leftWidget: Icon(
                BetterIcon.volumeO,
                size: 16.bsp,
                color: ColorUtil.hexToColor("#ed6a0c"),
              ),
              textList: textList,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
              child: Text('通知栏模式'.tr, style: TextStyle(fontSize: 14.bsp)),
            ),
            BetterMarquee(
              height: 40.bw,
              leftWidget: Icon(
                BetterIcon.volumeO,
                size: 16.bsp,
                color: ColorUtil.hexToColor("#ed6a0c"),
              ),
              rightWidget: Icon(
                BetterIcon.cross,
                size: 16.bsp,
                color: ColorUtil.hexToColor("#ed6a0c"),
              ),
              textList: textList,
            ),
            SizedBox(height: 2.bw),
            BetterMarquee(
              height: 40.bw,
              leftWidget: Icon(
                BetterIcon.volumeO,
                size: 16.bsp,
                color: ColorUtil.hexToColor("#ed6a0c"),
              ),
              rightWidget: Icon(
                BetterIcon.arrow,
                size: 16.bsp,
                color: ColorUtil.hexToColor("#ed6a0c"),
              ),
              textList: textList,
            ),
            SizedBox(height: 2.bw),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
              child: Text('垂直滚动'.tr, style: TextStyle(fontSize: 14.bsp)),
            ),
            BetterMarquee(
              height: 40.bw,
              leftWidget: Icon(
                BetterIcon.volumeO,
                size: 16.bsp,
                color: ColorUtil.hexToColor("#ed6a0c"),
              ),
              textList: ["hello world", "1234567890"],
              isVertical: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 10.bw),
              child: Text('自定义样式'.tr, style: TextStyle(fontSize: 14.bsp)),
            ),
            BetterMarquee(
              height: 40.bw,
              textColor: Color.fromRGBO(25, 137, 250, 1),
              backgroundColor: Color.fromRGBO(236, 249, 255, 1),
              leftWidget: Icon(
                BetterIcon.volumeO,
                size: 16.bsp,
                color: Color.fromRGBO(25, 137, 250, 1),
              ),
              textList: ["hello world"],
            ),
          ],
        ),
      ),
    );
  }
}
