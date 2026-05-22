import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_slide_action.dart';
import 'package:flutter_better_ui/better_toast.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterSlideActionPage extends StatefulWidget {
  const BetterSlideActionPage({super.key});

  @override
  State<BetterSlideActionPage> createState() => _BetterSlideActionPageState();
}

class _BetterSlideActionPageState extends State<BetterSlideActionPage> {
  final BetterSlideActionController _controller = BetterSlideActionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滑动按钮'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('基础用法'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                color: Theme.of(context).primaryColor,
                onCompleted: () {
                  BetterToast.showSuccess(context: context, message: '完成'.tr);
                },
                knobChild: Icon(Icons.chevron_right, size: 26.bw),
                children: Text(
                  '向右滑动完成'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                ),
              ),
              SizedBox(height: 20.bw),
              Text('自动复位'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                color: const Color(0xFF8B5CF6),
                resetAfterCompleted: true,
                onCompleted: () {
                  BetterToast.showSuccess(context: context, message: '完成'.tr);
                },
                knobChild: Icon(Icons.arrow_forward, size: 22.bw),
                children: Text(
                  '完成后自动复位'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                ),
              ),
              SizedBox(height: 20.bw),
              Text('自定义颜色'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                color: const Color(0xFF00B894),
                onCompleted: () {
                  BetterToast.showSuccess(context: context, message: '完成'.tr);
                },
                knobChild: Icon(
                  Icons.keyboard_double_arrow_right,
                  color: const Color(0xFF00B894),
                  size: 22.bw,
                ),
                children: Text(
                  '向右滑动完成'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                ),
              ),
              SizedBox(height: 20.bw),
              Text('反向滑动'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                reverse: true,
                color: const Color(0xFFFA8C16),
                onCompleted: () {
                  BetterToast.showSuccess(context: context, message: '完成'.tr);
                },
                knobChild: Icon(Icons.chevron_left, size: 26.bw),
                children: Text(
                  '向左滑动完成'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                ),
              ),
              SizedBox(height: 20.bw),
              Text('自定义内容'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                height: 58.bw,
                knobSize: 46.bw,
                leftPadding: 10.bw,
                rightPadding: 10.bw,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.bw),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFF8A00), Color(0xFFFF4D4F)],
                  ),
                ),
                onCompleted: () {
                  BetterToast.showSuccess(context: context, message: '完成'.tr);
                },
                knobChild: Icon(Icons.lock_open, size: 20.bw),
                children: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: Colors.white, size: 18.bw),
                    SizedBox(width: 6.bw),
                    Text(
                      '滑动解锁'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.bw),
              Text('控制器'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                color: const Color(0xFF1677FF),
                controller: _controller,
                onCompleted: () {
                  BetterToast.showSuccess(context: context, message: '完成'.tr);
                },
                knobChild: Icon(Icons.check, size: 22.bw),
                children: Text(
                  '可手动复位'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                ),
              ),
              SizedBox(height: 10.bw),
              BetterButton(
                type: BetterButtonType.primary,
                onTap: _controller.reset,
                child: Text('重置'.tr, style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20.bw),
              Text('禁用状态'.tr, style: TextStyle(fontSize: 14.bsp)),
              SizedBox(height: 10.bw),
              BetterSlideAction(
                enabled: false,
                color: const Color(0xFFB8B8B8),
                knobChild: Icon(Icons.lock, size: 22.bw),
                children: Text(
                  '禁用按钮'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 15.bsp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
