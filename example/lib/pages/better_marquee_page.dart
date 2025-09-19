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
            SizedBox(height: 10.bw),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.bw),
              child: Text('基础用法'.tr, style: TextStyle(fontSize: 14.bsp)),
            ),
            SizedBox(height: 10.bw),
            BetterMarquee(),
          ],
        ),
      ),
    );
  }
}
