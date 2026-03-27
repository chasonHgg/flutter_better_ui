

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BetterIndexBarPage extends StatelessWidget {
  const BetterIndexBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('索引栏目'.tr)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('索引栏目'.tr),
            ],
          ),
        ),
    );
  }
}