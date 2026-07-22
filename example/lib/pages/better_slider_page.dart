import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_slider.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

class BetterSliderPage extends StatefulWidget {
  const BetterSliderPage({super.key});

  @override
  State<BetterSliderPage> createState() => _BetterSliderPageState();
}

class _BetterSliderPageState extends State<BetterSliderPage> {
  final BetterSliderController _controller = BetterSliderController(
    initialValue: 50,
  );
  final BetterSliderController _customController = BetterSliderController(
    initialValue: 50,
  );

  @override
  void dispose() {
    _controller.dispose();
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滑块'.tr)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.bw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('基础用法'.tr),
            BetterSlider(value: 50, onChanged: _onValueChanged),
            _gap(),
            _title('指定步长'.tr),
            BetterSlider(
              value: 20,
              step: 10,
              activeColor: const Color(0xffee0a24),
              onChanged: _onValueChanged,
            ),
            _gap(),
            _title('范围选择'.tr),
            BetterSlider.range(
              values: const RangeValues(20, 60),
              onChanged: _onRangeChanged,
            ),
            _gap(),
            _title('函数控制'.tr),
            BetterSlider(controller: _controller, onChanged: _onValueChanged),
            SizedBox(height: 12.bw),
            Row(
              children: [
                BetterButton(text: '-1', onTap: _controller.decrease),
                SizedBox(width: 12.bw),
                BetterButton(
                  text: '+1',
                  type: BetterButtonType.primary,
                  onTap: _controller.increase,
                ),
              ],
            ),
            _gap(),
            _title('禁用与只读'.tr),
            const BetterSlider(value: 40, disabled: true, onChanged: _ignore),
            SizedBox(height: 12.bw),
            const BetterSlider(value: 70, readOnly: true, onChanged: _ignore),
            _gap(),
            _title('自定义滑块'.tr),
            ValueListenableBuilder<double>(
              valueListenable: _customController,
              builder: (context, value, _) => BetterSlider(
                controller: _customController,
                onChanged: _onValueChanged,
                buttonSize: 28.bw,
                button: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0xff1989fa),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _formatValue(value),
                      style: TextStyle(color: Colors.white, fontSize: 10.bsp),
                    ),
                  ),
                ),
              ),
            ),
            _gap(),
            _title('竖向与反向'.tr),
            Row(
              children: [
                BetterSlider(
                  value: 50,
                  vertical: true,
                  height: 160.bw,
                  onChanged: _onValueChanged,
                ),
                SizedBox(width: 32.bw),
                BetterSlider(
                  value: 50,
                  vertical: true,
                  reverse: true,
                  height: 160.bw,
                  onChanged: _onValueChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void _ignore(double _) {}

  static void _onValueChanged(double value) => debugPrint('Slider: $value');

  static void _onRangeChanged(RangeValues values) =>
      debugPrint('Slider range: ${values.start} - ${values.end}');

  static String _formatValue(double value) =>
      value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);

  Widget _title(String text) => Padding(
    padding: EdgeInsets.only(bottom: 12.bw),
    child: Text(text, style: TextStyle(fontSize: 14.bsp)),
  );

  Widget _gap() => SizedBox(height: 24.bw);
}
