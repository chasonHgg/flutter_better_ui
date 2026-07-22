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
    expect(value, 0);
    await tester.pumpAndSettle();
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

  testWidgets('onChanged fires only after dragging ends', (tester) async {
    final changes = <double>[];
    await tester.pumpWidget(
      app(BetterSlider(value: 20, onChanged: changes.add)),
    );
    final rect = tester.getRect(find.byType(BetterSlider));
    final gesture = await tester.startGesture(rect.centerLeft);
    await tester.pump(const Duration(milliseconds: 200));
    expect(changes, isEmpty);

    await gesture.moveTo(rect.center);
    await tester.pump();
    expect(changes, isEmpty);

    await gesture.up();
    await tester.pump();
    expect(changes, hasLength(1));
    expect(changes.single, 50);
  });

  testWidgets('controller changes and clamps the slider value', (tester) async {
    final controller = BetterSliderController(initialValue: 20);
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      app(BetterSlider(controller: controller, onChanged: (_) {})),
    );

    controller.setValue(140);
    await tester.pump();
    expect(controller.value, 100);

    controller.decrease(70);
    await tester.pump();
    expect(controller.value, 30);
  });

  testWidgets('slider responds before the drag touch slop is reached', (
    tester,
  ) async {
    final controller = BetterSliderController(initialValue: 50);
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      app(BetterSlider(controller: controller, onChanged: (_) {})),
    );
    final rect = tester.getRect(find.byType(BetterSlider));
    final gesture = await tester.startGesture(rect.center);
    await gesture.moveBy(const Offset(4, 0));
    await tester.pump();
    expect(controller.value, greaterThan(50));
    await gesture.up();
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
    await tester.pumpAndSettle();
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

  testWidgets('range thumbs can cross each other', (tester) async {
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
    await tester.dragFrom(
      Offset(rect.left + rect.width * .2, rect.center.dy),
      Offset(rect.width * .7, 0),
    );
    expect(changed, const RangeValues(80, 90));
  });
}
