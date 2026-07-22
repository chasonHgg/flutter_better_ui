import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

/// A Vant-style slider for selecting a single value or a range.
class BetterSlider extends StatefulWidget {
  const BetterSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.activeColor,
    this.inactiveColor,
    this.barHeight,
    this.buttonSize,
    this.button,
    this.disabled = false,
    this.readOnly = false,
    this.reverse = false,
    this.vertical = false,
    this.height,
  }) : values = null,
       onRangeChanged = null,
       onRangeChangeStart = null,
       onRangeChangeEnd = null,
       startButton = null,
       endButton = null,
       assert(max > min, 'max must be greater than min'),
       assert(step > 0, 'step must be greater than zero');

  const BetterSlider.range({
    super.key,
    required this.values,
    required ValueChanged<RangeValues> onChanged,
    this.onRangeChangeStart,
    this.onRangeChangeEnd,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.activeColor,
    this.inactiveColor,
    this.barHeight,
    this.buttonSize,
    this.startButton,
    this.endButton,
    this.disabled = false,
    this.readOnly = false,
    this.reverse = false,
    this.vertical = false,
    this.height,
  }) : value = null,
       onChanged = null,
       onChangeStart = null,
       onChangeEnd = null,
       onRangeChanged = onChanged,
       button = null,
       assert(max > min, 'max must be greater than min'),
       assert(step > 0, 'step must be greater than zero');

  final double? value;
  final RangeValues? values;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<RangeValues>? onRangeChanged;
  final ValueChanged<RangeValues>? onRangeChangeStart;
  final ValueChanged<RangeValues>? onRangeChangeEnd;
  final double min;
  final double max;
  final double step;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? barHeight;
  final double? buttonSize;
  final Widget? button;
  final Widget? startButton;
  final Widget? endButton;
  final bool disabled;
  final bool readOnly;
  final bool reverse;
  final bool vertical;

  /// Required space along the main axis when [vertical] is true.
  final double? height;

  bool get isRange => values != null;

  @override
  State<BetterSlider> createState() => _BetterSliderState();
}

class _BetterSliderState extends State<BetterSlider> {
  late final ValueNotifier<double> _valueNotifier;
  late final ValueNotifier<RangeValues> _valuesNotifier;
  int _activeThumb = 0;

  double get _value => _valueNotifier.value;
  RangeValues get _values => _valuesNotifier.value;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(_normalizedValue);
    _valuesNotifier = ValueNotifier(_normalizedValues);
  }

  @override
  void didUpdateWidget(covariant BetterSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value || oldWidget.values != widget.values) {
      _syncValues();
    }
  }

  void _syncValues() {
    _valueNotifier.value = _normalizedValue;
    _valuesNotifier.value = _normalizedValues;
  }

  double get _normalizedValue => _clamp(widget.value ?? widget.min);

  RangeValues get _normalizedValues {
    final values = widget.values ?? RangeValues(widget.min, widget.min);
    final start = _clamp(values.start);
    final end = _clamp(values.end);
    return RangeValues(start <= end ? start : end, start <= end ? end : start);
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    _valuesNotifier.dispose();
    super.dispose();
  }

  double _clamp(double value) => value.clamp(widget.min, widget.max).toDouble();

  double _snap(double value) {
    final steps = ((value - widget.min) / widget.step).round();
    final snapped = widget.min + steps * widget.step;
    return _clamp(double.parse(snapped.toStringAsFixed(10)));
  }

  double _fraction(double value) =>
      (value - widget.min) / (widget.max - widget.min);

  double _valueFromPosition(Offset position, Size size) {
    var fraction = widget.vertical
        ? 1 - position.dy / size.height
        : position.dx / size.width;
    if (widget.reverse) fraction = 1 - fraction;
    return _snap(
      widget.min + fraction.clamp(0.0, 1.0) * (widget.max - widget.min),
    );
  }

  void _start(Offset position, Size size) {
    final next = _valueFromPosition(position, size);
    if (widget.isRange) {
      // When both thumbs overlap, defer the choice until movement begins:
      // dragging towards the minimum controls the start thumb, while dragging
      // towards the maximum controls the end thumb.
      _activeThumb = _values.start == _values.end
          ? next < _values.start
                ? 0
                : next > _values.end
                ? 1
                : -1
          : (next - _values.start).abs() <= (next - _values.end).abs()
          ? 0
          : 1;
      widget.onRangeChangeStart?.call(_values);
    } else {
      widget.onChangeStart?.call(_value);
    }
    _update(position, size);
  }

  void _update(Offset position, Size size) {
    final next = _valueFromPosition(position, size);
    if (widget.isRange) {
      if (_activeThumb == -1) {
        if (next == _values.start) return;
        _activeThumb = next < _values.start ? 0 : 1;
      }
      _valuesNotifier.value = _activeThumb == 0
          ? RangeValues(next.clamp(widget.min, _values.end), _values.end)
          : RangeValues(_values.start, next.clamp(_values.start, widget.max));
      widget.onRangeChanged?.call(_values);
    } else {
      _valueNotifier.value = next;
      widget.onChanged?.call(_value);
    }
  }

  void _end() {
    if (widget.isRange) {
      widget.onRangeChangeEnd?.call(_values);
    } else {
      widget.onChangeEnd?.call(_value);
    }
  }

  void _adjust(double direction) {
    if (widget.disabled || widget.readOnly || widget.isRange) return;
    final next = _snap(_value + direction * widget.step);
    if (next == _value) return;
    _valueNotifier.value = next;
    widget.onChanged?.call(next);
    widget.onChangeEnd?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _valueNotifier,
      builder: (context, _, _) => ValueListenableBuilder<RangeValues>(
        valueListenable: _valuesNotifier,
        builder: (context, _, _) => _buildSlider(context),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final inactiveColor =
        widget.inactiveColor ?? theme.colorScheme.surfaceContainerHighest;
    final barHeight = widget.barHeight ?? 2.bw;
    final buttonSize = widget.buttonSize ?? 24.bw;
    final mainAxisExtent = widget.vertical ? (widget.height ?? 200.bw) : null;

    final slider = FocusableActionDetector(
      enabled: !widget.disabled && !widget.readOnly,
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowRight): _IncreaseIntent(),
        SingleActivator(LogicalKeyboardKey.arrowUp): _IncreaseIntent(),
        SingleActivator(LogicalKeyboardKey.arrowLeft): _DecreaseIntent(),
        SingleActivator(LogicalKeyboardKey.arrowDown): _DecreaseIntent(),
      },
      actions: {
        _IncreaseIntent: CallbackAction<_IncreaseIntent>(
          onInvoke: (_) => _adjust(1),
        ),
        _DecreaseIntent: CallbackAction<_DecreaseIntent>(
          onInvoke: (_) => _adjust(-1),
        ),
      },
      child: Semantics(
        slider: true,
        enabled: !widget.disabled,
        readOnly: widget.readOnly,
        value: widget.isRange
            ? '${_label(_values.start)} - ${_label(_values.end)}'
            : _label(_value),
        increasedValue: widget.isRange
            ? null
            : _label(_snap(_value + widget.step)),
        decreasedValue: widget.isRange
            ? null
            : _label(_snap(_value - widget.step)),
        onIncrease: widget.isRange ? null : () => _adjust(1),
        onDecrease: widget.isRange ? null : () => _adjust(-1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(
              widget.vertical ? buttonSize : constraints.maxWidth,
              widget.vertical ? constraints.maxHeight : buttonSize,
            );
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: widget.disabled || widget.readOnly
                  ? null
                  : (details) {
                      _start(details.localPosition, size);
                      _end();
                    },
              onPanStart: widget.disabled || widget.readOnly
                  ? null
                  : (details) => _start(details.localPosition, size),
              onPanUpdate: widget.disabled || widget.readOnly
                  ? null
                  : (details) => _update(details.localPosition, size),
              onPanEnd: widget.disabled || widget.readOnly
                  ? null
                  : (_) => _end(),
              child: _SliderTrack(
                value: _fraction(_value),
                values: widget.isRange
                    ? RangeValues(
                        _fraction(_values.start),
                        _fraction(_values.end),
                      )
                    : null,
                reverse: widget.reverse,
                vertical: widget.vertical,
                barHeight: barHeight,
                buttonSize: buttonSize,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                button: widget.button,
                startButton: widget.startButton,
                endButton: widget.endButton,
              ),
            );
          },
        ),
      ),
    );

    return Opacity(
      opacity: widget.disabled ? 0.5 : 1,
      child: SizedBox(
        width: widget.vertical ? buttonSize : double.infinity,
        height: widget.vertical ? mainAxisExtent : buttonSize,
        child: slider,
      ),
    );
  }

  String _label(double value) =>
      value % 1 == 0 ? value.toInt().toString() : value.toString();
}

class _SliderTrack extends StatelessWidget {
  const _SliderTrack({
    required this.value,
    required this.values,
    required this.reverse,
    required this.vertical,
    required this.barHeight,
    required this.buttonSize,
    required this.activeColor,
    required this.inactiveColor,
    required this.button,
    required this.startButton,
    required this.endButton,
  });

  final double value;
  final RangeValues? values;
  final bool reverse;
  final bool vertical;
  final double barHeight;
  final double buttonSize;
  final Color activeColor;
  final Color inactiveColor;
  final Widget? button;
  final Widget? startButton;
  final Widget? endButton;

  double _visual(double fraction) => reverse ? 1 - fraction : fraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final extent = vertical ? constraints.maxHeight : constraints.maxWidth;
        final first = _visual(values?.start ?? value);
        final second = _visual(values?.end ?? value);
        final activeStart = values == null
            ? (reverse ? first : 0.0)
            : first < second
            ? first
            : second;
        final activeEnd = values == null
            ? (reverse ? 1.0 : first)
            : first > second
            ? first
            : second;

        Widget thumb(Widget? child) => SizedBox(
          width: buttonSize,
          height: buttonSize,
          child:
              child ??
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 4.bw,
                    ),
                  ],
                ),
              ),
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: vertical ? (buttonSize - barHeight) / 2 : 0,
              right: vertical ? null : 0,
              top: vertical ? 0 : (buttonSize - barHeight) / 2,
              bottom: vertical ? 0 : null,
              width: vertical ? barHeight : null,
              height: vertical ? null : barHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: inactiveColor,
                  borderRadius: BorderRadius.circular(barHeight),
                ),
              ),
            ),
            Positioned(
              left: vertical
                  ? (buttonSize - barHeight) / 2
                  : activeStart * extent,
              top: vertical
                  ? (1 - activeEnd) * extent
                  : (buttonSize - barHeight) / 2,
              width: vertical ? barHeight : (activeEnd - activeStart) * extent,
              height: vertical ? (activeEnd - activeStart) * extent : barHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(barHeight),
                ),
              ),
            ),
            if (values != null)
              _positionedThumb(first, extent, thumb(startButton)),
            _positionedThumb(
              second,
              extent,
              thumb(values == null ? button : endButton),
            ),
          ],
        );
      },
    );
  }

  Widget _positionedThumb(double fraction, double extent, Widget child) {
    return Positioned(
      left: vertical ? 0 : fraction * extent - buttonSize / 2,
      bottom: vertical ? fraction * extent - buttonSize / 2 : null,
      top: vertical ? null : 0,
      child: child,
    );
  }
}

class _IncreaseIntent extends Intent {
  const _IncreaseIntent();
}

class _DecreaseIntent extends Intent {
  const _DecreaseIntent();
}
