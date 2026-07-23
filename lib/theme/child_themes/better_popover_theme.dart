import 'dart:ui';

/// Visual defaults used by [BetterPopover].
class BetterPopoverTheme {
  const BetterPopoverTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.disabledTextColor,
    required this.dividerColor,
    required this.overlayColor,
    required this.shadowColor,
    required this.borderRadius,
    required this.actionHeight,
    required this.fontSize,
    required this.iconSize,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color disabledTextColor;
  final Color dividerColor;
  final Color overlayColor;
  final Color shadowColor;
  final double borderRadius;
  final double actionHeight;
  final double fontSize;
  final double iconSize;

  BetterPopoverTheme copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? disabledTextColor,
    Color? dividerColor,
    Color? overlayColor,
    Color? shadowColor,
    double? borderRadius,
    double? actionHeight,
    double? fontSize,
    double? iconSize,
  }) {
    return BetterPopoverTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      dividerColor: dividerColor ?? this.dividerColor,
      overlayColor: overlayColor ?? this.overlayColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
      actionHeight: actionHeight ?? this.actionHeight,
      fontSize: fontSize ?? this.fontSize,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  static BetterPopoverTheme lerp(
    BetterPopoverTheme a,
    BetterPopoverTheme b,
    double t,
  ) {
    return BetterPopoverTheme(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      textColor: Color.lerp(a.textColor, b.textColor, t)!,
      disabledTextColor: Color.lerp(
        a.disabledTextColor,
        b.disabledTextColor,
        t,
      )!,
      dividerColor: Color.lerp(a.dividerColor, b.dividerColor, t)!,
      overlayColor: Color.lerp(a.overlayColor, b.overlayColor, t)!,
      shadowColor: Color.lerp(a.shadowColor, b.shadowColor, t)!,
      borderRadius: lerpDouble(a.borderRadius, b.borderRadius, t)!,
      actionHeight: lerpDouble(a.actionHeight, b.actionHeight, t)!,
      fontSize: lerpDouble(a.fontSize, b.fontSize, t)!,
      iconSize: lerpDouble(a.iconSize, b.iconSize, t)!,
    );
  }
}
