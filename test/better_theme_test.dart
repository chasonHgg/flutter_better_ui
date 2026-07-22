import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('changes theme mode and replaces theme data', (tester) async {
    final lightTheme = ThemeData(colorSchemeSeed: Colors.blue);
    final darkTheme = ThemeData.dark();

    await tester.pumpWidget(
      BetterUi(
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: (context, config) => MaterialApp(
          theme: config.theme,
          darkTheme: config.darkTheme,
          themeMode: config.themeMode,
          home: const _ThemeProbe(),
        ),
      ),
    );

    expect(find.text('light'), findsOneWidget);

    BetterUi.changeThemeMode(ThemeMode.dark);
    await tester.pumpAndSettle();
    expect(find.text('dark'), findsOneWidget);

    final replacement = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.purple,
    );
    BetterUi.changeDarkTheme(replacement);
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(_ThemeProbe));
    expect(Theme.of(context).scaffoldBackgroundColor, Colors.purple);
  });

  testWidgets('builds responsive themes after screen initialization', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(750, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    late double scaledWidth;
    await tester.pumpWidget(
      BetterUi(
        designWidth: 375,
        themeBuilder: () {
          scaledWidth = 10.bw;
          return ThemeData.light();
        },
        builder: (context, config) =>
            MaterialApp(theme: config.theme, home: const SizedBox()),
      ),
    );

    expect(scaledWidth, 10 * BetterScreenUtil.screenWidth / 375);
    expect(BetterScreenUtil.screenWidth, isNot(375));
  });
}

class _ThemeProbe extends StatelessWidget {
  const _ThemeProbe();

  @override
  Widget build(BuildContext context) {
    return Text(Theme.of(context).brightness.name);
  }
}
