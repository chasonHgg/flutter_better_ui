import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_marquee.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterMarqueePage extends StatelessWidget {
  const BetterMarqueePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('跑马灯'.tr)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200.bw,
                height: 44.bw,
                color: Colors.red,
                child: BetterMarquee(textList: ['你好', '我很好我很好', '他很好']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
