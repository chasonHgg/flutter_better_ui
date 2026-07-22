import 'package:example/pages/home.dart';
import 'package:example/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('go_router builds the home route', (tester) async {
    router.go('/');
    await tester.pumpWidget(
      const BetterUi(
        designWidth: 375,
        designHeight: 812,
        child: _RouterTestApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Home), findsOneWidget);
  });
}

class _RouterTestApp extends StatelessWidget {
  const _RouterTestApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router, theme: betterLightTheme);
  }
}
