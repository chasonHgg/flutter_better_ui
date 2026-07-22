import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_slider.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget app(Widget child) => MaterialApp(
    home: Builder(
      builder: (context) {
        BetterScreenUtil.init(
          context: context,
          designWidth: 375,
          designHeight: 812,
        );
        return Scaffold(
          body: Center(child: SizedBox(width: 300, child: child)),
        );
      },
    ),
  );

  testWidgets('tap applies step and emits value', (tester) async {
    double value = 0;
    await tester.pumpWidget(
      app(
        BetterSlider(value: value, step: 10, onChanged: (next) => value = next),
      ),
    );
    final rect = tester.getRect(find.byType(BetterSlider));
    await tester.tapAt(Offset(rect.left + rect.width * .54, rect.center.dy));
    expect(value, 50);
  });

  testWidgets('disabled slider ignores gestures', (tester) async {
    double? changed;
    await tester.pumpWidget(
      app(
        BetterSlider(
          value: 20,
          disabled: true,
          onChanged: (value) => changed = value,
        ),
      ),
    );
    await tester.tap(find.byType(BetterSlider));
    expect(changed, isNull);
  });

  testWidgets('range slider moves nearest thumb', (tester) async {
    RangeValues? changed;
    await tester.pumpWidget(
      app(
        BetterSlider.range(
          values: const RangeValues(20, 80),
          onChanged: (value) => changed = value,
        ),
      ),
    );
    final rect = tester.getRect(find.byType(BetterSlider));
    await tester.tapAt(Offset(rect.left + rect.width * .3, rect.center.dy));
    expect(changed, const RangeValues(30, 80));
  });

  testWidgets('overlapping range thumbs can drag in both directions', (
    tester,
  ) async {
    final value = ValueNotifier(const RangeValues(50, 50));
    addTearDown(value.dispose);
    await tester.pumpWidget(
      app(
        ValueListenableBuilder<RangeValues>(
          valueListenable: value,
          builder: (context, current, _) => BetterSlider.range(
            values: current,
            onChanged: (next) => value.value = next,
          ),
        ),
      ),
    );

    var rect = tester.getRect(find.byType(BetterSlider));
    await tester.dragFrom(rect.center, Offset(rect.width * .2, 0));
    await tester.pump();
    expect(value.value.start, 50);
    expect(value.value.end, greaterThan(50));

    value.value = const RangeValues(50, 50);
    await tester.pump();
    rect = tester.getRect(find.byType(BetterSlider));
    await tester.dragFrom(rect.center, Offset(-rect.width * .2, 0));
    await tester.pump();
    expect(value.value.start, lessThan(50));
    expect(value.value.end, 50);
  });
}
