import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('updates locale and translations without GetX', (tester) async {
    await tester.pumpWidget(
      BetterUi(
        locale: const Locale('zh', 'CN'),
        fallbackLocale: const Locale('en', 'US'),
        translations: const {
          'zh_CN': {'greeting': '你好 @name，剩余 @days 天'},
          'en_US': {'greeting': 'Hello @name, @days days left'},
        },
        child: const _LocaleProbe(),
      ),
    );

    expect(find.text('你好 Codex，剩余 3 天'), findsOneWidget);

    BetterUi.updateLocale(const Locale('en', 'US'));
    await tester.pump();

    expect(find.text('Hello Codex, 3 days left'), findsOneWidget);
  });
}

class _LocaleProbe extends StatelessWidget {
  const _LocaleProbe();

  @override
  Widget build(BuildContext context) {
    BetterUi.localeOf(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text('greeting'.trParams(const {'name': 'Codex', 'days': 3})),
    );
  }
}
