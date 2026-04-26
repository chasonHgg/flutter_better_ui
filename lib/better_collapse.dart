import 'package:flutter/material.dart';
import 'package:flutter_better_ui/theme/child_themes/better_collapse_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';

class BetterCollapseItem {
  final Widget title;
  final List<Widget> children;

  const BetterCollapseItem({required this.title, required this.children});
}

class BetterCollapse extends StatefulWidget {
  final List<BetterCollapseItem> children;
  final bool accordion;
  final EdgeInsetsGeometry? titlePadding;
  final VisualDensity? titleVisualDensity;
  final bool? titleDense;
  final double? minTitleHeight;
  final double? titleMinVerticalPadding;
  final EdgeInsetsGeometry? childrenPadding;
  final EdgeInsetsGeometry? contentPadding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool showDivider;
  final Color? dividerColor;
  final double? dividerHeight;
  final double dividerThickness;
  final double dividerIndent;
  final double dividerEndIndent;
  final bool showContentTopBorder;
  final Color? contentTopBorderColor;
  final double? contentTopBorderWidth;

  final Color? background;
  final Color? collapsedBackground;

  final Color? iconColor;
  final Color? collapsedIconColor;
  final Color? splashColor;

  final Alignment alignment;
  final CrossAxisAlignment expandedCrossAxisAlignment;

  const BetterCollapse({
    super.key,
    required this.children,
    this.accordion = false,
    this.titlePadding,
    this.titleVisualDensity,
    this.titleDense,
    this.minTitleHeight = 0,
    this.titleMinVerticalPadding = 0,
    this.childrenPadding = EdgeInsets.zero,
    this.contentPadding,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
    this.showDivider = true,
    this.dividerColor,
    this.dividerHeight,
    this.dividerThickness = 0,
    this.dividerIndent = 0,
    this.dividerEndIndent = 0,
    this.showContentTopBorder = true,
    this.contentTopBorderColor,
    this.contentTopBorderWidth,
    this.alignment = Alignment.centerLeft,
    this.expandedCrossAxisAlignment = CrossAxisAlignment.start,
    this.background,
    this.collapsedBackground,
    this.iconColor,
    this.collapsedIconColor,
    this.splashColor,
  });

  @override
  State<BetterCollapse> createState() => _BetterCollapseState();
}

class _BetterCollapseState extends State<BetterCollapse> {
  late List<ExpansibleController> _controllers;
  int? _expandedIndex;
  final Set<int> _closingIndexes = {};

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.children.length,
      (_) => ExpansibleController(),
    );
  }



  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleExpansionChanged(int index, bool expanded) {
    if (!widget.accordion) {
      return;
    }

    if (!expanded) {
      if (_closingIndexes.remove(index)) {
        return;
      }
      if (_expandedIndex == index) {
        _expandedIndex = null;
      }
      return;
    }

    final previousIndex = _expandedIndex;
    _expandedIndex = index;
    if (previousIndex != null &&
        previousIndex != index &&
        previousIndex < _controllers.length) {
      _closingIndexes.add(previousIndex);
      _controllers[previousIndex].collapse();
    }
  }

  @override
  Widget build(BuildContext context) {
    BetterCollapseTheme? theme = BetterUtil.getThemeExtension(
      context,
    )?.collapseTheme;
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        final Color? effectiveSplashColor =
            widget.splashColor ?? theme?.splashColor;
        final Widget expansionTile = ListTileTheme.merge(
          minVerticalPadding: widget.titleMinVerticalPadding,
          child: ExpansionTile(
            controller: _controllers[index],
            onExpansionChanged: (expanded) {
              _handleExpansionChanged(index, expanded);
            },
            shape: const Border(),
            collapsedShape: const Border(),
            title: widget.children[index].title,
            tilePadding:
                widget.titlePadding ??
                EdgeInsets.symmetric(vertical: 12.bw, horizontal: 16.bw),
            visualDensity: widget.titleVisualDensity,
            dense: widget.titleDense,
            minTileHeight: widget.minTitleHeight,
            childrenPadding: widget.childrenPadding,
            expandedCrossAxisAlignment: widget.expandedCrossAxisAlignment,
            expandedAlignment: widget.alignment,
            backgroundColor: widget.background ?? theme?.backgroundColor,
            collapsedBackgroundColor:
                widget.collapsedBackground ?? theme?.collapsedBackground,
            iconColor: widget.iconColor ?? theme?.iconColor,
            collapsedIconColor:
                widget.collapsedIconColor ?? theme?.collapsedIconColor,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: widget.showContentTopBorder
                      ? Border(
                          top: BorderSide(
                            color:
                                widget.contentTopBorderColor ??
                                Theme.of(context).dividerColor,
                            width: widget.contentTopBorderWidth ?? 1.bw,
                          ),
                        )
                      : null,
                ),
              ),
              Padding(
                padding:
                    widget.contentPadding ??
                    EdgeInsets.symmetric(horizontal: 16.bw, vertical: 12.bw),
                child: Column(children: widget.children[index].children),
              ),
            ],
          ),
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (effectiveSplashColor == null)
              expansionTile
            else
              Theme(
                data: Theme.of(
                  context,
                ).copyWith(splashColor: effectiveSplashColor),
                child: expansionTile,
              ),
            if (widget.showDivider && index != widget.children.length - 1)
              Divider(
                height: widget.dividerHeight ?? 1.bw,
                thickness: widget.dividerThickness,
                indent: widget.dividerIndent,
                endIndent: widget.dividerEndIndent,
                color: widget.dividerColor ?? Theme.of(context).dividerColor,
              ),
          ],
        );
      },
    );
  }
}
