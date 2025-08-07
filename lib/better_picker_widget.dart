import 'package:flutter_better_ui/better_text_button.dart';
import 'package:flutter_better_ui/theme/better_theme_extension.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum _BetterPickerType { single, multi, cascade }

class BetterPickerItem {
  final String text;
  final String value;
  final TextStyle? textStyle;
  final bool? isSelected;
  final List<BetterPickerItem>? children;

  BetterPickerItem({
    required this.text,
    required this.value,
    this.textStyle,
    this.children,
    this.isSelected,
  });
}

class BetterPickerWidget extends StatefulWidget {
  final dynamic columns;
  final String? cancelText;
  final String? confirmText;
  final String? title;
  final Widget? titleWidget;
  final Color? headerBackgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? cancelTextColor;
  final Color? confirmTextColor;
  final VoidCallback? onCancel;
  final Function(List<BetterPickerItem>)? onConfirm;
  final Function(List<BetterPickerItem>)? onChange;
  final double? diameterRatio;
  final Widget? overlayWidget;
  final double? itemHeight;

  const BetterPickerWidget({
    super.key,
    required this.columns,
    this.cancelText,
    this.confirmText,
    this.title,
    this.titleWidget,
    this.headerBackgroundColor,
    this.borderRadius,
    this.cancelTextColor,
    this.confirmTextColor,
    this.onCancel,
    this.onConfirm,
    this.onChange,
    this.diameterRatio,
    this.overlayWidget,
    this.itemHeight,
  });

  @override
  State<BetterPickerWidget> createState() => _BetterPickerWidgetState();
}

class _BetterPickerWidgetState extends State<BetterPickerWidget> {
  BetterThemeExtension? theme;
  bool isFirstRenderCascade = true;
  _BetterPickerType pickerType = _BetterPickerType.single;
  int level = 0;
  List<FixedExtentScrollController> controllers = [];
  //最后操作的列层级
  int lastOperateLevel = 0;
  //默认选中的上一层的children
  List<BetterPickerItem> setDefaultLastChildren = [];

  final showColumnsNotifier = ValueNotifier<List<Widget>>([]);

  @override
  void initState() {
    super.initState();
    //判断类型:单列,多列,级联
    if (widget.columns is List<List<BetterPickerItem>>) {
      pickerType = _BetterPickerType.multi;
    } else if (widget.columns is List<BetterPickerItem>) {
      pickerType = _BetterPickerType.single;
      //级联-判断有children的
      for (var item in widget.columns) {
        if (item.children != null) {
          pickerType = _BetterPickerType.cascade;
          break;
        }
      }
    }
    level = _getLevelCount(widget.columns, pickerType);
    //初始化控制器
    for (var i = 0; i < level; i++) {
      final initIndex = _setDefaultSelected(i);
      controllers.add(FixedExtentScrollController(initialItem: initIndex));
    }

    initShowColumns();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void initShowColumns() {
    final List<Widget> arr = [];
    //单列或者级联
    if (pickerType == _BetterPickerType.single) {
      arr.add(_renderPickerColumn(columns: widget.columns, controllerIndex: 0));
    }

    //多列
    if (pickerType == _BetterPickerType.multi) {
      widget.columns.asMap().entries.forEach(
        (e) => {
          arr.add(
            _renderPickerColumn(columns: e.value, controllerIndex: e.key),
          ),
        },
      );
    }

    if (pickerType == _BetterPickerType.cascade) {
      arr.addAll(
        _renderCascadeColumns(columns: widget.columns, controllerIndex: 0),
      );
    }
    showColumnsNotifier.value = arr;
    isFirstRenderCascade = false;
  }

  //设置默认选项
  int _setDefaultSelected(int levelIndex) {
    int index = 0;
    if (pickerType == _BetterPickerType.single) {
      index = widget.columns.indexWhere((e) => e.isSelected == true);
    }
    if (pickerType == _BetterPickerType.multi) {
      index = widget.columns[levelIndex].indexWhere(
        (e) => e.isSelected == true,
      );
    }
    if (pickerType == _BetterPickerType.cascade) {
      if (levelIndex == 0) {
        index = widget.columns.indexWhere((e) => e.isSelected == true);
        if (index == -1) return 0;
        setDefaultLastChildren = widget.columns[index].children;
      } else {
        index = setDefaultLastChildren.indexWhere((e) => e.isSelected == true);
        if (index == -1) return 0;
        if (setDefaultLastChildren[index].children != null) {
          setDefaultLastChildren = setDefaultLastChildren[index].children!;
        }
      }
    }
    return index == -1 ? 0 : index;
  }

  void _handleScrollEnd(int controllerIndex) {
    lastOperateLevel = controllerIndex;
    //级联才需要处理
    if (pickerType != _BetterPickerType.cascade) return;
    //最后一列不需要处理
    if (controllerIndex == controllers.length - 1) return;
    final List<Widget> arr = [];
    arr.addAll(
      _renderCascadeColumns(columns: widget.columns, controllerIndex: 0),
    );
    showColumnsNotifier.value = arr;
  }

  List<BetterPickerItem> _getSelectedValues() {
    List<BetterPickerItem> selectedValues = [];
    if (pickerType == _BetterPickerType.single) {
      selectedValues.add(widget.columns[controllers[0].selectedItem]);
    }
    if (pickerType == _BetterPickerType.multi) {
      for (int i = 0; i < controllers.length; i++) {
        selectedValues.add(widget.columns[i][controllers[i].selectedItem]);
      }
    }
    if (pickerType == _BetterPickerType.cascade) {
      late BetterPickerItem parent;
      for (int i = 0; i < controllers.length; i++) {
        if (i == 0) {
          parent = widget.columns[controllers[i].selectedItem];
          selectedValues.add(parent);
        } else {
          if (parent.children != null) {
            parent = parent.children![controllers[i].selectedItem];
            selectedValues.add(parent);
          }
        }
      }
    }
    return selectedValues;
  }

  @override
  Widget build(BuildContext context) {
    theme ??= Theme.of(context).extension<BetterThemeExtension>()!;

    return SizedBox(
      height: 300.bw,
      child: Column(
        children: [
          _renderHeader(
            context: context,
            cancelText: widget.cancelText,
            confirmText: widget.confirmText,
            title: widget.title,
            titleWidget: widget.titleWidget,
            headerBackgroundColor: widget.headerBackgroundColor,
            theme: theme,
            borderRadius: widget.borderRadius,
            cancelTextColor: widget.cancelTextColor,
            confirmTextColor: widget.confirmTextColor,
          ),
          Expanded(
            child: Container(
              color: theme?.pickerTheme.backgroundColor,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: showColumnsNotifier,
                    builder: (context, value, child) {
                      return Row(children: value);
                    },
                  ),
                  widget.overlayWidget ??
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        theme?.pickerTheme.overlayStartColor
                                                ?.withAlpha(200) ??
                                            Colors.white.withAlpha(200),
                                        theme?.pickerTheme.overlayEndColor
                                                ?.withAlpha(50) ??
                                            Colors.white.withAlpha(50),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16.bw,
                                  right: 16.bw,
                                ),
                                child: Container(
                                  height: widget.itemHeight,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color:
                                            theme?.borderColor ?? Colors.grey,
                                        width: 1.bw,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            theme?.borderColor ?? Colors.grey,
                                        width: 1.bw,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        theme?.pickerTheme.overlayStartColor
                                                ?.withAlpha(200) ??
                                            Colors.white.withAlpha(200),
                                        theme?.pickerTheme.overlayEndColor
                                                ?.withAlpha(50) ??
                                            Colors.white.withAlpha(50),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //计算层级深度
  int _getLevelCount(var columns, _BetterPickerType pickerType) {
    if (pickerType == _BetterPickerType.single) {
      return 1;
    }
    if (pickerType == _BetterPickerType.multi) {
      return columns.length;
    }

    int maxLevel = 1;
    for (var item in columns) {
      if (item.children != null && item.children!.isNotEmpty) {
        int childLevel = _getLevelCount(item.children!, pickerType);
        if (childLevel + 1 > maxLevel) {
          maxLevel = childLevel + 1;
        }
      }
    }
    return maxLevel;
  }

  Widget _renderHeader({
    required BuildContext context,
    String? cancelText,
    String? confirmText,
    String? title,
    Widget? titleWidget,
    Color? headerBackgroundColor,
    BorderRadiusGeometry? borderRadius,
    BetterThemeExtension? theme,
    Color? cancelTextColor,
    Color? confirmTextColor,
  }) {
    return Container(
      height: 44.bw,
      decoration: BoxDecoration(
        color:
            headerBackgroundColor ?? theme?.pickerTheme.headerBackgroundColor,
        borderRadius:
            borderRadius ??
            theme?.pickerTheme.borderRadius ??
            BorderRadius.only(
              topLeft: Radius.circular(16.bw),
              topRight: Radius.circular(16.bw),
            ),
      ),
      child: Row(
        children: [
          BetterTextButton(
            text: cancelText?.tr ?? theme?.pickerTheme.cancelText ?? "取消".tr,
            onPressed: () {
              widget.onCancel?.call();
              Navigator.pop(context);
            },
            color: cancelTextColor ?? theme?.pickerTheme.cancelTextColor,
            activeColor: (cancelTextColor ?? theme?.pickerTheme.cancelTextColor)
                ?.withAlpha(153),
            textStyle: TextStyle(fontSize: 14.bsp),
          ),
          Expanded(
            child:
                titleWidget ??
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.bsp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          ),
          BetterTextButton(
            text: confirmText?.tr ?? theme?.pickerTheme.confirmText ?? "确定".tr,
            onPressed: () {
              //获取选中值
              widget.onConfirm?.call(_getSelectedValues());
              Navigator.pop(context);
            },
            color: confirmTextColor ?? theme?.primaryColor,
            activeColor: (confirmTextColor ?? theme?.primaryColor)?.withAlpha(
              153,
            ),
            textStyle: TextStyle(fontSize: 14.bsp),
          ),
        ],
      ),
    );
  }

  Widget _renderPickerColumn({
    required List<BetterPickerItem> columns,
    required int controllerIndex,
  }) {
    return Expanded(
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          _handleScrollEnd(controllerIndex);
          widget.onChange?.call(_getSelectedValues());
          return false;
        },
        child: ListWheelScrollView.useDelegate(
          controller: controllers[controllerIndex],
          itemExtent: widget.itemHeight ?? 44.bw,
          // 透视效果（仿 iOS 风格）
          perspective: 0.01,
          // 控制滚轮的弯曲程度
          diameterRatio: widget.diameterRatio ?? 1000,
          overAndUnderCenterOpacity: 0.5,
          //确保每次滚动对齐一项
          physics: FixedExtentScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: columns.length,
            builder: (context, index) {
              return Container(
                height: 44.bw,
                alignment: Alignment.center,
                child: Text(
                  columns[index].text,
                  style:
                      columns[index].textStyle ?? TextStyle(fontSize: 14.bsp),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //渲染级联
  List<Widget> _renderCascadeColumns({
    required List<BetterPickerItem> columns,
    required int controllerIndex,
  }) {
    List<Widget> children = [];
    if (columns.isEmpty) return children;

    // 添加当前列
    children.add(
      _renderPickerColumn(columns: columns, controllerIndex: controllerIndex),
    );

    // 如果当前不是最后一列且有子项，则递归添加子列
    if (controllerIndex < controllers.length - 1) {
      // 获取当前选中项的索引（如果没有客户端则默认为0）
      final selectedIndex = controllers[controllerIndex].hasClients
          ? controllers[controllerIndex].selectedItem
          : controllers[controllerIndex].initialItem;

      // 确保索引有效且有子项
      if (selectedIndex < columns.length &&
          columns[selectedIndex].children != null) {
        children.addAll(
          _renderCascadeColumns(
            columns: columns[selectedIndex].children!,
            controllerIndex: controllerIndex + 1,
          ),
        );
        // 重置下级列的位置（不包括当前列）
        if (!isFirstRenderCascade) _resetSubsequentControllers();
      }
    }

    return children;
  }

  void _resetSubsequentControllers() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = lastOperateLevel + 1; i < controllers.length; i++) {
        if (controllers[i].hasClients &&
            !controllers[i].position.isScrollingNotifier.value) {
          controllers[i].jumpTo(0);
        }
      }
    });
  }
}
