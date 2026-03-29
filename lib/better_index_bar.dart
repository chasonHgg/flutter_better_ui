import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';

class BetterIndexBarHeader extends StatelessWidget {
  final Widget titleWidget;
  final String anchor;
  final double height;
  final Key? contentKey;
  const BetterIndexBarHeader({
    super.key,
    required this.titleWidget,
    required this.height,
    required this.anchor,
    this.contentKey,
  });
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderDelegate(
        height: height,
        child: titleWidget,
        contentKey: contentKey,
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  final Key? contentKey;

  _StickyHeaderDelegate({
    required this.child,
    required this.height,
    this.contentKey,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return KeyedSubtree(
      key: contentKey,
      child: SizedBox.expand(child: child),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return true;
  }
}

class BetterIndexBarItem {
  final BetterIndexBarHeader header;
  final List<Widget> list;
  BetterIndexBarItem({required this.header, required this.list});

  String get anchor => header.anchor;
}

class BetterIndexBar extends StatefulWidget {
  final List<Widget>? headerSlivers;
  final List<BetterIndexBarItem> items;
  final Color? indexBarColor;
  final Color? indexBarActiveColor;
  final double? indexBarFontSize;
  final double? indexBarSpacing;
  const BetterIndexBar({
    super.key,
    required this.items,
    this.headerSlivers,
    this.indexBarColor,
    this.indexBarActiveColor,
    this.indexBarFontSize,
    this.indexBarSpacing,
  });

  @override
  State<BetterIndexBar> createState() => _BetterIndexBarState();
}

class _BetterIndexBarState extends State<BetterIndexBar> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollViewKey = GlobalKey();
  late List<GlobalKey> _headerKeys;
  late List<GlobalKey> _indexItemKeys;
  final ValueNotifier<int> _lastTouchedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _headerKeys = _buildHeaderKeys(widget.items.length);
    _indexItemKeys = _buildHeaderKeys(widget.items.length);
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
  }

  @override
  void didUpdateWidget(covariant BetterIndexBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _headerKeys = _buildHeaderKeys(widget.items.length);
      _indexItemKeys = _buildHeaderKeys(widget.items.length);
      if (_lastTouchedIndex.value >= widget.items.length) {
        _lastTouchedIndex.value = widget.items.isEmpty
            ? 0
            : widget.items.length - 1;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _lastTouchedIndex.dispose();
    super.dispose();
  }

  List<GlobalKey> _buildHeaderKeys(int count) {
    return List<GlobalKey>.generate(count, (_) => GlobalKey());
  }

  void _scrollToIndex(int index) {
    if (index < 0 || index >= widget.items.length) return;
    if (_lastTouchedIndex.value == index) return;
    _lastTouchedIndex.value = index;

    final targetContext = _headerKeys[index].currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 0),
      );
    }
  }

  void _handleIndexBarTouch(Offset globalPosition) {
    for (int i = 0; i < _indexItemKeys.length; i++) {
      final targetContext = _indexItemKeys[i].currentContext;
      if (targetContext == null) continue;

      final renderBox = targetContext.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;

      final offset = renderBox.localToGlobal(Offset.zero);
      final rect = offset & renderBox.size;
      if (rect.contains(globalPosition)) {
        _scrollToIndex(i);
        return;
      }
    }
  }

  void _handleScroll() {
    if (!mounted || widget.items.isEmpty) return;

    final scrollViewContext = _scrollViewKey.currentContext;
    if (scrollViewContext == null) return;

    final scrollViewRenderBox =
        scrollViewContext.findRenderObject() as RenderBox?;
    if (scrollViewRenderBox == null || !scrollViewRenderBox.hasSize) return;

    final viewportTop = scrollViewRenderBox.localToGlobal(Offset.zero).dy;
    int currentIndex = 0;
    double nearestPassedDistance = double.infinity;
    int? nearestUpcomingIndex;
    double nearestUpcomingDistance = double.infinity;

    for (int i = 0; i < _headerKeys.length; i++) {
      final headerContext = _headerKeys[i].currentContext;
      if (headerContext == null) continue;

      final renderBox = headerContext.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;

      final headerTop = renderBox.localToGlobal(Offset.zero).dy;
      final distance = headerTop - viewportTop;

      if (distance <= 0 && distance.abs() < nearestPassedDistance) {
        nearestPassedDistance = distance.abs();
        currentIndex = i;
      } else if (distance > 0 && distance < nearestUpcomingDistance) {
        nearestUpcomingDistance = distance;
        nearestUpcomingIndex = i;
      }
    }

    if (nearestPassedDistance == double.infinity &&
        nearestUpcomingIndex != null) {
      currentIndex = nearestUpcomingIndex;
    }

    if (_lastTouchedIndex.value != currentIndex) {
      _lastTouchedIndex.value = currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          key: _scrollViewKey,
          controller: _scrollController,
          slivers: [
            ...widget.headerSlivers ?? [],
            ...widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return SliverMainAxisGroup(
                slivers: [
                  BetterIndexBarHeader(
                    anchor: item.header.anchor,
                    contentKey: _headerKeys[index],
                    height: item.header.height,
                    titleWidget: item.header.titleWidget,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, idx) => item.list[idx],
                      childCount: item.list.length,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        _buildIndexBar(),
      ],
    );
  }

  Widget _buildIndexBar() {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) => _handleIndexBarTouch(details.globalPosition),
        onVerticalDragDown: (details) =>
            _handleIndexBarTouch(details.globalPosition),
        onVerticalDragUpdate: (details) =>
            _handleIndexBarTouch(details.globalPosition),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: widget.indexBarSpacing ?? 0,
          children: [
            for (int i = 0; i < widget.items.length; i++)
              Padding(
                key: _indexItemKeys[i],
                padding: EdgeInsets.only(left: 16.bw, right: 10.bw),
                child: ValueListenableBuilder(
                  valueListenable: _lastTouchedIndex,
                  builder: (context, value, child) {
                    return Text(
                      widget.items[i].anchor,
                      style: TextStyle(
                        fontSize: widget.indexBarFontSize ?? 10.bsp,
                        color: i != value
                            ? widget.indexBarColor ??
                                  ColorUtil.hexToColor("#323233")
                            : (widget.indexBarActiveColor ?? Colors.blue),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
