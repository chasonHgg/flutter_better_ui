# Better UI Example

Example app for `flutter_better_ui`.

## Run

```bash
flutter pub get
flutter run
```

## Basic Usage

The example app wraps `MaterialApp` with `BetterUi` and assigns `BetterUi.navigatorKey` so toast, popup, and picker widgets can use the global overlay.

```dart
void main() {
  runApp(
    BetterUi(
      designWidth: 375,
      designHeight: 812,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: BetterUi.navigatorKey,
      home: const Home(),
    );
  }
}
```

## BetterSlideAction

```dart
BetterSlideAction(
  color: Theme.of(context).primaryColor,
  onCompleted: () {
    BetterToast.showSuccess(message: 'Completed');
  },
  knobChild: const Icon(Icons.chevron_right),
  children: const Text(
    'Slide right to complete',
    style: TextStyle(color: Colors.white),
  ),
)

BetterSlideAction(
  reverse: true,
  color: Colors.orange,
  onCompleted: () {
    BetterToast.showSuccess(message: 'Completed');
  },
  knobChild: const Icon(Icons.chevron_left),
  children: const Text(
    'Slide left to complete',
    style: TextStyle(color: Colors.white),
  ),
)
```
