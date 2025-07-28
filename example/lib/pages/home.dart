import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Better UI'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5), // 边框高度
          child: Container(color: Colors.grey[300], height: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Flutter 移动端组件库", style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 20.h),
              Text("基础组件", style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 10.h),
              renderRow(context, "Button"),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderRow(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        context.push("/betterButton");
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      child: SizedBox(
        height: 30.h,
        child: Row(
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 14.sp)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 14.sp),
          ],
        ),
      ),
    );
  }
}
