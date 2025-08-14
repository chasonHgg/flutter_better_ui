import 'package:flutter/material.dart';
import 'package:flutter_better_ui/theme/child_themes/better_switch_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

class BetterSwitch extends StatefulWidget {
  /// 开关的默认值
  final bool defaultValue;

  /// 开关状态改变时的回调函数
  final ValueChanged<bool>? onChanged;

  /// 使用 onUpdating Change 来异步控制开关状态
  /// 如果使用了 onUpdateChange，onChange 将被忽略
  final Future<bool> Function()? onUpdateChange;

  /// 开关是否处于加载状态
  final bool? loading;

  /// 开关的固定宽度
  final double? width;
  final double? height;

  /// 开关圆球的背景颜色
  final Color? ballBackgroundColor;

  /// 非激活状态的背景颜色
  final Color? inactiveBackgroundColor;

  /// 激活状态的背景颜色
  final Color? activeBackgroundColor;

  /// 开关的内边距
  final EdgeInsetsGeometry? padding;

  /// 加载指示器的大小
  final double? loadingSize;

  /// 加载指示器的描边宽度
  final double? loadingStrokeWidth;

  /// 加载指示器的颜色
  final Color? loadingColor;

  /// 自定义圆球组件。如果提供，将替换内置的圆球
  final Widget? ballWidget;

  /// 开关是否被禁用
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
    if (widget.loading == true) return;

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
