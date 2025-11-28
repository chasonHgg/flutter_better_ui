import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetterSwiperPage extends StatefulWidget {
  const BetterSwiperPage({super.key});

  @override
  State<BetterSwiperPage> createState() => _BetterSwiperPageState();
}

class _BetterSwiperPageState extends State<BetterSwiperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("轮播".tr)),
      body: Column(children: [
          
        ],
      ),
    );
  }
}
