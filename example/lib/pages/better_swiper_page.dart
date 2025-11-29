import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_swiper.dart';
import 'package:flutter_better_ui/better_switch.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterSwiperPage extends StatefulWidget {
  const BetterSwiperPage({super.key});

  @override
  State<BetterSwiperPage> createState() => _BetterSwiperPageState();
}

class _BetterSwiperPageState extends State<BetterSwiperPage> {
  bool isVertical = false;
  bool loop = true;
  bool touchable = true;
  bool autoplay = true;

  PageController pageController = PageController();
  PageController pageController2 = PageController();

  int swiper2CurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("轮播".tr)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BetterSwiper(
              controller: pageController,
              height: 200.bw,
              autoplay: autoplay,
              loop: loop,
              touchable: touchable,
              scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
              children: [
                Container(width: double.infinity, color: Colors.red),
                Container(width: double.infinity, color: Colors.blue),
                Container(width: double.infinity, color: Colors.green),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.bw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('自动播放'.tr),
                      SizedBox(width: 10.bw),
                      BetterSwitch(
                        width: 44.bw,
                        height: 26.bw,
                        defaultValue: autoplay,
                        onChanged: (value) {
                          setState(() {
                            autoplay = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.bw),
                  Row(
                    children: [
                      Text('纵向滚动'.tr),
                      SizedBox(width: 10.bw),
                      BetterSwitch(
                        width: 44.bw,
                        height: 26.bw,
                        onChanged: (value) {
                          setState(() {
                            isVertical = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.bw),
                  Row(
                    children: [
                      Text('无限循环'.tr),
                      SizedBox(width: 10.bw),
                      BetterSwitch(
                        width: 44.bw,
                        height: 26.bw,
                        defaultValue: loop,
                        onChanged: (value) {
                          setState(() {
                            loop = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.bw),
                  Row(
                    children: [
                      Text('手势滑动'.tr),
                      SizedBox(width: 10.bw),
                      BetterSwitch(
                        width: 44.bw,
                        height: 26.bw,
                        defaultValue: touchable,
                        onChanged: (value) {
                          setState(() {
                            touchable = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.bw),
                  BetterButton(
                    text: '上一页'.tr,
                    onClick: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  SizedBox(height: 10.bw),
                  BetterButton(
                    text: '下一页'.tr,
                    onClick: () {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),
            Text("自定义指示器".tr, style: TextStyle(fontSize: 14.bsp)),
            SizedBox(height: 10.bw),
            BetterSwiper(
              height: 200.bw,
              controller: pageController2,
              onChanged: (index) {
                setState(() {
                  swiper2CurrentIndex = index;
                });
              },
              children: [
                Container(width: double.infinity, color: Colors.red),
                Container(width: double.infinity, color: Colors.blue),
                Container(width: double.infinity, color: Colors.green),
              ],
              indicatorWidget: Positioned(
                bottom: 12.bw,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.bw,
                        vertical: 4.bw,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: BorderRadius.circular(12.bw),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${swiper2CurrentIndex + 1}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("/3", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
