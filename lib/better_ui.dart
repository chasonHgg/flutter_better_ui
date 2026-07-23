import 'package:flutter/material.dart';
import 'package:flutter_better_ui/i18n/better_localizations.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

export 'better_image_preview.dart';
export 'better_popover.dart';
export 'better_progress.dart';
export 'better_skeleton.dart';
export 'better_slider.dart';
export 'i18n/better_localizations.dart';

typedef BetterUiBuilder =
    Widget Function(BuildContext context, BetterUiConfig config);

/// Values managed by [BetterUi] that should be passed to MaterialApp.
@immutable
class BetterUiConfig {
  const BetterUiConfig({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
    required this.locale,
    required this.supportedLocales,
  });

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final Locale locale;
  final List<Locale> supportedLocales;
}

/// Global Better UI configuration for responsive sizing, themes and locale.
class BetterUi extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final ValueNotifier<_BetterThemeValue?> _themeNotifier =
      ValueNotifier<_BetterThemeValue?>(null);

  final Widget? child;
  final BetterUiBuilder? builder;
  final double designWidth;
  final double designHeight;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData Function()? themeBuilder;
  final ThemeData Function()? darkThemeBuilder;
  final ThemeMode themeMode;
  final Map<String, Map<String, String>> translations;
  final Locale locale;
  final Locale fallbackLocale;

  const BetterUi({
    super.key,
    this.child,
    this.builder,
    this.designWidth = 375,
    this.designHeight = 812,
    this.theme,
    this.darkTheme,
    this.themeBuilder,
    this.darkThemeBuilder,
    this.themeMode = ThemeMode.system,
    this.translations = const {},
    this.locale = const Locale('en', 'US'),
    this.fallbackLocale = const Locale('en', 'US'),
  }) : assert(
         (child == null) != (builder == null),
         'Provide either child or builder, but not both.',
       ),
       assert(
         theme == null || themeBuilder == null,
         'Provide either theme or themeBuilder, but not both.',
       ),
       assert(
         darkTheme == null || darkThemeBuilder == null,
         'Provide either darkTheme or darkThemeBuilder, but not both.',
       );

  static _BetterThemeValue get _themeValue {
    final value = _themeNotifier.value;
    if (value == null) {
      throw StateError('BetterUi must be mounted before changing its theme.');
    }
    return value;
  }

  static BuildContext? get currentContext => navigatorKey.currentContext;

  static Locale get currentLocale => BetterLocalizations.locale;

  static Locale localeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_BetterLocaleScope>()!
        .locale;
  }

  static List<Locale> get supportedLocales =>
      BetterLocalizations.supportedLocales;

  static void updateLocale(Locale locale) {
    BetterLocalizations.updateLocale(locale);
  }

  static String translate(String key) => BetterLocalizations.translate(key);

  static ThemeData get currentTheme => _themeValue.theme;

  static ThemeData get currentDarkTheme => _themeValue.darkTheme;

  static ThemeMode get currentThemeMode => _themeValue.themeMode;

  static void changeTheme(ThemeData theme) {
    _themeNotifier.value = _themeValue.copyWith(theme: theme);
  }

  static void changeDarkTheme(ThemeData darkTheme) {
    _themeNotifier.value = _themeValue.copyWith(darkTheme: darkTheme);
  }

  static void changeThemes({
    required ThemeData theme,
    required ThemeData darkTheme,
  }) {
    _themeNotifier.value = _themeValue.copyWith(
      theme: theme,
      darkTheme: darkTheme,
    );
  }

  static void changeThemeMode(ThemeMode themeMode) {
    _themeNotifier.value = _themeValue.copyWith(themeMode: themeMode);
  }

  static void toggleTheme() {
    final mode = currentThemeMode;
    final isDark =
        mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);
    changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  static OverlayState? get overlay {
    final navigatorOverlay = navigatorKey.currentState?.overlay;
    if (navigatorOverlay != null) return navigatorOverlay;

    final context = currentContext;
    return context == null ? null : Overlay.maybeOf(context, rootOverlay: true);
  }

  @override
  State<BetterUi> createState() => _BetterUiState();
}

class _BetterUiState extends State<BetterUi> {
  bool _themeConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureLocalizations();
  }

  @override
  void didUpdateWidget(covariant BetterUi oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.translations != widget.translations ||
        oldWidget.locale != widget.locale ||
        oldWidget.fallbackLocale != widget.fallbackLocale) {
      _configureLocalizations();
    }
    if (oldWidget.theme != widget.theme ||
        oldWidget.darkTheme != widget.darkTheme ||
        oldWidget.themeBuilder != widget.themeBuilder ||
        oldWidget.darkThemeBuilder != widget.darkThemeBuilder ||
        oldWidget.themeMode != widget.themeMode) {
      _configureTheme();
    }
  }

  void _configureLocalizations() {
    BetterLocalizations.configure(
      translations: widget.translations,
      locale: widget.locale,
      fallbackLocale: widget.fallbackLocale,
    );
  }

  void _configureTheme() {
    final theme =
        widget.themeBuilder?.call() ?? widget.theme ?? ThemeData.light();
    BetterUi._themeNotifier.value = _BetterThemeValue(
      theme: theme,
      darkTheme: widget.darkThemeBuilder?.call() ?? widget.darkTheme ?? theme,
      themeMode: widget.themeMode,
    );
    _themeConfigured = true;
  }

  @override
  Widget build(BuildContext context) {
    BetterUtil.init(
      context,
      designWidth: widget.designWidth,
      designHeight: widget.designHeight,
    );
    if (!_themeConfigured) {
      _configureTheme();
    }
    return ValueListenableBuilder<Locale>(
      valueListenable: BetterLocalizations.localeNotifier,
      builder: (context, locale, _) {
        return ValueListenableBuilder<_BetterThemeValue?>(
          valueListenable: BetterUi._themeNotifier,
          builder: (context, themeValue, _) {
            final value = themeValue!;
            final config = BetterUiConfig(
              theme: value.theme,
              darkTheme: value.darkTheme,
              themeMode: value.themeMode,
              locale: locale,
              supportedLocales: BetterLocalizations.supportedLocales,
            );
            final content =
                widget.builder?.call(context, config) ?? widget.child!;
            return _BetterLocaleScope(locale: locale, child: content);
          },
        );
      },
    );
  }
}

class _BetterLocaleScope extends InheritedWidget {
  const _BetterLocaleScope({required this.locale, required super.child});

  final Locale locale;

  @override
  bool updateShouldNotify(_BetterLocaleScope oldWidget) =>
      locale != oldWidget.locale;
}

@immutable
class _BetterThemeValue {
  const _BetterThemeValue({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  _BetterThemeValue copyWith({
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
  }) {
    return _BetterThemeValue(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
