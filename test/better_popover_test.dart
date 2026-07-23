import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget app(Widget child, {ThemeData? theme}) => BetterUi(
    theme: theme,
    builder: (context, config) => MaterialApp(
      theme: config.theme,
      home: Scaffold(body: Center(child: child)),
    ),
  );

  testWidgets('opens, selects an action, and closes', (tester) async {
    BetterPopoverAction? selected;
    await tester.pumpWidget(
      app(
        BetterPopover(
          actions: const [BetterPopoverAction(text: 'Edit')],
          onSelect: (action) => selected = action,
          child: const Text('Open'),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Edit'), findsOneWidget);

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(selected?.text, 'Edit');
    expect(find.text('Edit'), findsNothing);
  });

  testWidgets('opens when trigger child handles taps itself', (tester) async {
    await tester.pumpWidget(
      app(
        BetterPopover(
          actions: const [BetterPopoverAction(text: 'Action')],
          child: ElevatedButton(onPressed: () {}, child: const Text('Open')),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Action'), findsOneWidget);
  });

  testWidgets('plays reverse animation before closing', (tester) async {
    await tester.pumpWidget(
      app(
        const BetterPopover(
          enableAnimation: true,
          animationDuration: Duration(milliseconds: 240),
          actions: [BetterPopoverAction(text: 'Action')],
          child: Text('Open'),
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.text('Open')));
    await tester.pumpAndSettle();
    await tester.tapAt(tester.getCenter(find.text('Action')));
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.text('Action'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Action'), findsNothing);
  });

  testWidgets('uses intrinsic action width when width is not provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        const BetterPopover(
          placement: BetterPopoverPlacement.topStart,
          actions: [BetterPopoverAction(text: 'A')],
          child: Text('Open'),
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.text('Open')));
    await tester.pumpAndSettle();
    final actionSize = tester.getSize(find.text('A'));
    expect(actionSize.width, lessThan(140));
  });

  testWidgets('flips from bottom to top when bottom space is insufficient', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        Align(
          alignment: Alignment.bottomCenter,
          child: BetterPopover(
            actions: const [BetterPopoverAction(text: 'Action')],
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.text('Open')));
    await tester.pumpAndSettle();
    expect(
      tester.getCenter(find.text('Action')).dy,
      lessThan(tester.getCenter(find.text('Open')).dy),
    );
  });

  testWidgets('flips from right to left when right space is insufficient', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        Align(
          alignment: Alignment.centerRight,
          child: BetterPopover(
            placement: BetterPopoverPlacement.right,
            actions: const [BetterPopoverAction(text: 'Action')],
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tapAt(tester.getCenter(find.text('Open')));
    await tester.pumpAndSettle();
    expect(
      tester.getCenter(find.text('Action')).dx,
      lessThan(tester.getCenter(find.text('Open')).dx),
    );
  });

  testWidgets('disabled action cannot be selected', (tester) async {
    var selected = false;
    await tester.pumpWidget(
      app(
        BetterPopover(
          actions: const [BetterPopoverAction(text: 'Delete', disabled: true)],
          onSelect: (_) => selected = true,
          child: const Text('Open'),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pump();
    expect(selected, isFalse);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('uses dark color scheme without BetterThemeExtension', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        const BetterPopover(
          actions: [BetterPopoverAction(text: 'Action')],
          child: Text('Open'),
        ),
        theme: ThemeData.dark(),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    expect(find.text('Action'), findsOneWidget);
    final text = tester.widget<Text>(find.text('Action'));
    expect(text.style?.color, ThemeData.dark().colorScheme.onSurface);
  });
}
