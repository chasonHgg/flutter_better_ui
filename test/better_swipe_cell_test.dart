import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_swipe_cell.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'does not animate after an action completes when the cell is disposed',
    (tester) async {
      final actionResult = Completer<bool>();
      var actionCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BetterSwipeCell(
              rightActions: [
                BetterSwipeCellAction(
                  width: 80,
                  onTap: (_) {
                    actionCalled = true;
                    return actionResult.future;
                  },
                  child: const ColoredBox(
                    key: Key('action'),
                    color: Colors.red,
                  ),
                ),
              ],
              child: const SizedBox(
                width: 240,
                height: 60,
                child: ColoredBox(key: Key('content'), color: Colors.white),
              ),
            ),
          ),
        ),
      );

      final actionGesture = find.ancestor(
        of: find.byKey(const Key('action')),
        matching: find.byType(GestureDetector),
      );
      tester.widget<GestureDetector>(actionGesture).onTap!();
      await tester.pump();
      expect(actionCalled, isTrue);

      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      actionResult.complete(true);
      await tester.pump();

      expect(tester.takeException(), isNull);
    },
  );
}
