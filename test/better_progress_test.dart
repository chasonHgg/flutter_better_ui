import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_progress.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('controller changes and clamps the progress value', () {
    final controller = BetterProgressController(initialValue: 95);
    controller.increase(10);
    expect(controller.value, 100);
    controller.decrease(120);
    expect(controller.value, 0);
  });

  testWidgets('controller updates the displayed pivot text', (tester) async {
    final controller = BetterProgressController(initialValue: 20);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            BetterScreenUtil.init(
              context: context,
              designWidth: 375,
              designHeight: 812,
            );
            return Scaffold(body: BetterProgress(controller: controller));
          },
        ),
      ),
    );
    expect(find.text('20%'), findsOneWidget);

    controller.increase(15);
    await tester.pump();
    expect(find.text('35%'), findsOneWidget);
  });
}
