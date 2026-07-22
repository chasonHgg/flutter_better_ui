import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_slider.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

class BetterSliderPage extends StatefulWidget {
  const BetterSliderPage({super.key});

  @override
  State<BetterSliderPage> createState() => _BetterSliderPageState();
}

class _BetterSliderPageState extends State<BetterSliderPage> {
  final ValueNotifier<double> _value = ValueNotifier(50);
  final ValueNotifier<double> _stepValue = ValueNotifier(20);
  final ValueNotifier<RangeValues> _range = ValueNotifier(
    const RangeValues(20, 60),
  );

  @override
  void dispose() {
    _value.dispose();
    _stepValue.dispose();
    _range.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滑块'.tr)),
      body: AnimatedBuilder(
        animation: Listenable.merge([_value, _stepValue, _range]),
        builder: (context, _) => SingleChildScrollView(
          padding: EdgeInsets.all(16.bw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('${'基础用法'.tr}: ${_value.value.toInt()}'),
              BetterSlider(
                value: _value.value,
                onChanged: (value) => _value.value = value,
              ),
              _gap(),
              _title('${'指定步长'.tr}: ${_stepValue.value.toInt()}'),
              BetterSlider(
                value: _stepValue.value,
                step: 10,
                activeColor: const Color(0xffee0a24),
                onChanged: (value) => _stepValue.value = value,
              ),
              _gap(),
              _title(
                '${'范围选择'.tr}: ${_range.value.start.toInt()} - ${_range.value.end.toInt()}',
              ),
              BetterSlider.range(
                values: _range.value,
                onChanged: (value) => _range.value = value,
              ),
              _gap(),
              _title('禁用与只读'.tr),
              const BetterSlider(value: 40, disabled: true, onChanged: _ignore),
              SizedBox(height: 12.bw),
              const BetterSlider(value: 70, readOnly: true, onChanged: _ignore),
              _gap(),
              _title('自定义滑块'.tr),
              BetterSlider(
                value: _value.value,
                onChanged: (value) => _value.value = value,
                buttonSize: 28.bw,
                button: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0xff1989fa),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${_value.value.toInt()}',
                      style: TextStyle(color: Colors.white, fontSize: 10.bsp),
                    ),
                  ),
                ),
              ),
              _gap(),
              _title('竖向与反向'.tr),
              Row(
                children: [
                  BetterSlider(
                    value: _value.value,
                    vertical: true,
                    height: 160.bw,
                    onChanged: (value) => _value.value = value,
                  ),
                  SizedBox(width: 32.bw),
                  BetterSlider(
                    value: _value.value,
                    vertical: true,
                    reverse: true,
                    height: 160.bw,
                    onChanged: (value) => _value.value = value,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _ignore(double _) {}

  Widget _title(String text) => Padding(
    padding: EdgeInsets.only(bottom: 12.bw),
    child: Text(text, style: TextStyle(fontSize: 14.bsp)),
  );

  Widget _gap() => SizedBox(height: 24.bw);
}
