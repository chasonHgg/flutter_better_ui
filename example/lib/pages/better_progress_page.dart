import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_progress.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

class BetterProgressPage extends StatefulWidget {
  const BetterProgressPage({super.key});

  @override
  State<BetterProgressPage> createState() => _BetterProgressPageState();
}

class _BetterProgressPageState extends State<BetterProgressPage> {
  final BetterProgressController _controller = BetterProgressController(
    initialValue: 50,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('进度条'.tr)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.bw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('基础用法'.tr),
            const BetterProgress(percentage: 50),
            _gap(),
            _title('线条粗细'.tr),
            BetterProgress(percentage: 50, strokeWidth: 8.bw),
            _gap(),
            _title('置灰'.tr),
            const BetterProgress(
              percentage: 50,
              color: Color(0xff969799),
              pivotColor: Color(0xff969799),
            ),
            _gap(),
            _title('自定义样式'.tr),
            const BetterProgress(
              percentage: 75,
              color: Color(0xffee0a24),
              trackColor: Color(0xffffe1e1),
              pivotText: '红色',
              pivotColor: Color(0xffee0a24),
            ),
            SizedBox(height: 12.bw),
            const BetterProgress(
              percentage: 25,
              color: Color(0xff07c160),
              showPivot: false,
            ),
            _gap(),
            _title('函数控制'.tr),
            BetterProgress(controller: _controller),
            SizedBox(height: 16.bw),
            Row(
              children: [
                BetterButton(text: '-10', onTap: () => _controller.decrease()),
                SizedBox(width: 12.bw),
                BetterButton(
                  text: '+10',
                  type: BetterButtonType.primary,
                  onTap: () => _controller.increase(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) => Padding(
    padding: EdgeInsets.only(bottom: 12.bw),
    child: Text(text, style: TextStyle(fontSize: 14.bsp)),
  );

  Widget _gap() => SizedBox(height: 24.bw);
}
