import 'package:flutter/material.dart';
import 'package:flutter_better_ui/theme/child_themes/better_switch_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

class BetterSwitch extends StatefulWidget {
  /// Default value of the switch.
  final bool defaultValue;

  /// Callback when the switch is changed.
  final ValueChanged<bool>? onChanged;

  /// Use onUpdating Change to asynchronously control switch status.
  /// If onUpdating Change is used, onChange will be ignored
  final Future<bool> Function()? onUpdateChange;

  /// Whether the switch is loading.
  final bool? loading;

  /// Fixed width of the switch.
  final double? width;
  final double? height;

  /// Background color of the ball.
  final Color? ballBackgroundColor;

  /// Background color of the inactive state.
  final Color? inactiveBackgroundColor;

  /// Background color of the active state.
  final Color? activeBackgroundColor;

  /// Padding of the switch.
  final EdgeInsetsGeometry? padding;

  /// Size of the loading indicator.
  final double? loadingSize;

  /// Stroke width of the loading indicator.
  final double? loadingStrokeWidth;

  /// Color of the loading indicator.
  final Color? loadingColor;

  /// Custom ball widget. If provided it replaces the built-in ball.
  final Widget? ballWidget;

  /// Whether the switch is disabled.
  final bool? disabled;

  const BetterSwitch({
    super.key,
    this.onChanged,
    this.onUpdateChange,
    this.defaultValue = false,
    this.loading = false,
    this.width,
    this.height,
    this.ballBackgroundColor,
    this.inactiveBackgroundColor,
    this.activeBackgroundColor,
    this.padding,
    this.loadingSize,
    this.loadingStrokeWidth,
    this.loadingColor,
    this.ballWidget,
    this.disabled = false,
  });

  @override
  State<BetterSwitch> createState() => _BetterSwitchState();
}

class _BetterSwitchState extends State<BetterSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue;
  }

  Future<void> _handleSwitchChange() async {
    if (widget.disabled == true) return;

    if (widget.onUpdateChange != null) {
      final shouldUpdate = await widget.onUpdateChange!();
      if (shouldUpdate == true) {
        setState(() {
          _value = !_value;
        });
      }
      return;
    }
    setState(() {
      _value = !_value;
    });
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    BetterSwitchTheme switchTheme = BetterUtil.getThemeExtension(
      context,
    )!.switchTheme;

    final finalWidth = widget.width ?? switchTheme.width ?? 50.bw;
    final finalHeight = widget.height ?? switchTheme.height ?? 30.bw;
    final finalPadding =
        widget.padding ?? switchTheme.padding ?? EdgeInsets.all(2);

    return GestureDetector(
      onTap: _handleSwitchChange,
      child: Opacity(
        opacity: widget.disabled == true ? 0.5 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: finalWidth,
          height: finalHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(switchTheme.height ?? 30.bw),
            color: _value
                ? widget.activeBackgroundColor ??
                      switchTheme.activeBackgroundColor
                : widget.inactiveBackgroundColor ??
                      switchTheme.inactiveBackgroundColor,
          ),
          child: Padding(
            padding: finalPadding,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
              curve: Curves.easeInOut,
              child:
                  widget.ballWidget ??
                  Container(
                    width: finalHeight - finalPadding.horizontal,
                    height: finalHeight - finalPadding.horizontal,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          widget.ballBackgroundColor ??
                          switchTheme.ballBackgroundColor,
                    ),
                    alignment: Alignment.center,
                    child: widget.loading == true
                        ? SizedBox(
                            width:
                                widget.loadingSize ??
                                switchTheme.loadingSize ??
                                14.bw,
                            height:
                                widget.loadingSize ??
                                switchTheme.loadingSize ??
                                14.bw,
                            child: CircularProgressIndicator(
                              strokeWidth:
                                  widget.loadingStrokeWidth ??
                                  switchTheme.loadingStrokeWidth ??
                                  1,
                              valueColor: AlwaysStoppedAnimation(
                                widget.loadingColor ??
                                    switchTheme.loadingColor ??
                                    Colors.white,
                              ),
                            ),
                          )
                        : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
