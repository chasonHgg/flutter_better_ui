import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

enum BetterSwiperIndicatorType { dot, line }

class BetterSwiper extends StatefulWidget {
  final PageController controller;
  final List<Widget> children;
  final double? width;
  final double height;
  //是否自动播放
  final bool? autoplay;
  //自动播放间隔
  final Duration autoplayDuration;
  //动画时长
  final Duration duration;
  //动画曲线
  final Curve curve;
  //初始索引
  final int initialIndex;
  //指示器颜色
  final Color? indicatorColor;
  //指示器大小
  final double? dotSize;
  //是否显示指示器
  final bool? showIndicator;
  //滚动方向
  final Axis scrollDirection;
  //是否可以通过手势滑动
  final bool touchable;
  //是否懒加载
  final bool lazyRender;
  //是否无限循环
  final bool loop;
  //指示器类型
  final BetterSwiperIndicatorType indicatorType;
  //改变回调
  final ValueChanged<int>? onChanged;
  final Widget? indicatorWidget;

  const BetterSwiper({
    super.key,
    required this.controller,
    required this.children,
    this.width,
    required this.height,
    this.autoplay = true,
    this.autoplayDuration = const Duration(seconds: 3),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.initialIndex = 0,
    this.indicatorColor = Colors.white,
    this.dotSize,
    this.showIndicator = true,
    this.scrollDirection = Axis.horizontal,
    this.touchable = true,
    this.lazyRender = false,
    this.loop = true,
    this.indicatorType = BetterSwiperIndicatorType.dot,
    this.onChanged,
    this.indicatorWidget,
  });

  @override
  State<BetterSwiper> createState() => _BetterSwiperState();
}

class _BetterSwiperState extends State<BetterSwiper> {
  Timer? _timer;
  bool _allowNotification = true;

  late ValueNotifier<int> _currentPage;

  //切换方向：true为下一页，false为上一页,loop为false时有效
  bool _isNext = true;

  @override
  void initState() {
    super.initState();
    _currentPage = ValueNotifier(widget.initialIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.loop == true) {
        if (widget.initialIndex + 1 > widget.children.length) {
          widget.controller.jumpToPage(widget.children.length);
          _currentPage.value = widget.children.length - 1;
        } else {
          widget.controller.jumpToPage(widget.initialIndex + 1);
          _currentPage.value = widget.initialIndex;
        }
      } else {
        if (widget.initialIndex + 1 > widget.children.length) {
          widget.controller.jumpToPage(widget.children.length - 1);
          _currentPage.value = widget.children.length - 1;
          _isNext = false;
        } else {
          widget.controller.jumpToPage(widget.initialIndex);
          _currentPage.value = widget.initialIndex;
        }
      }
    });
    _startAutoPlay();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _timer?.cancel();
    _currentPage.dispose();
    super.dispose();
  }

  // 添加 didUpdateWidget 方法
  @override
  void didUpdateWidget(covariant BetterSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查 autoplay 属性是否发生了变化
    if (widget.autoplay != oldWidget.autoplay) {
      if (widget.autoplay == true) {
        // 如果新值是 true，启动自动播放
        _startAutoPlay();
      } else {
        // 如果新值是 false，停止自动播放
        _timer?.cancel();
      }
    }
  }

  /// 启动自动轮播（仅在手指离开/手势取消时调用）
  void _startAutoPlay() {
    // 先取消已有定时器，避免重复创建
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(widget.autoplayDuration, (timer) {
      if (_allowNotification) {
        if (_isNext || widget.loop == true) {
          widget.controller.nextPage(
            duration: widget.duration,
            curve: widget.curve,
          );
        } else {
          widget.controller.previousPage(
            duration: widget.duration,
            curve: widget.curve,
          );
        }
      }
    });
  }

  //暂停自动轮播（仅在手指按下时调用）
  void _pauseAutoPlay() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    //中断当前正在进行的动画：立即停止任何正在进行的动画
    if (widget.controller.hasClients) {
      final currentPage =
          widget.controller.page?.round() ?? (widget.loop == true ? 0 : 1);
      widget.controller.jumpToPage(currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Listener(
            // 手指按下屏幕（开始触摸）：立即暂停轮播+中断动画
            onPointerDown: (details) {
              if (widget.touchable == true) {
                _pauseAutoPlay();
              }
            },
            // 手指离开屏幕（滑动结束）：恢复自动轮播
            onPointerUp: (details) {
              if (widget.touchable == true) {
                _startAutoPlay();
              }
            },
            // 手势被取消（如来电、弹窗打断）：恢复自动轮播
            onPointerCancel: (details) {
              if (widget.touchable == true) {
                _startAutoPlay();
              }
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (!_allowNotification ||
                    notification is! ScrollEndNotification) {
                  return true;
                }

                final currentIndex = widget.controller.page!.round();

                final totalVirtualCount =
                    widget.children.length + (widget.loop == true ? 2 : 0);

                // 边界无缝跳转逻辑（不影响手势控制）
                if (widget.loop == true) {
                  if (currentIndex == 0) {
                    _allowNotification = false;
                    widget.controller.jumpToPage(widget.children.length);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _allowNotification = true;
                    });
                  } else if (currentIndex == totalVirtualCount - 1) {
                    _allowNotification = false;
                    widget.controller.jumpToPage(1);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _allowNotification = true;
                    });
                  }
                }
                if (widget.loop == false) {
                  if (currentIndex == 0) {
                    _isNext = true;
                  } else if (currentIndex == widget.children.length - 1) {
                    _isNext = false;
                  }
                }
                return true;
              },
              child: getPageView(),
            ),
          ),
          if (widget.showIndicator == true && widget.indicatorWidget == null)
            getIndicator(),
          if (widget.indicatorWidget != null) widget.indicatorWidget!,
        ],
      ),
    );
  }

  Widget getPageView() {
    if (widget.lazyRender == true) {
      return PageView.builder(
        scrollDirection: widget.scrollDirection,
        controller: widget.controller,
        // 页面切换开始时更新指示器（动画同步）
        onPageChanged: (index) {
          if (widget.loop == true) {
            _currentPage.value = (index - 1) % widget.children.length;
          } else {
            _currentPage.value = index;
          }
          widget.onChanged?.call(_currentPage.value);
        },
        physics: widget.touchable == true
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: widget.children.length + (widget.loop == true ? 2 : 0),
        itemBuilder: (context, index) {
          Widget child;
          if (widget.loop == true) {
            if (index == 0) {
              child = widget.children.last; // 头部虚拟页：最后一个子组件
            } else if (index == widget.children.length + 1) {
              child = widget.children.first; // 尾部虚拟页：第一个子组件
            } else {
              child = widget.children[index - 1]; // 真实数据页：当前子组件
            }
          } else {
            child = widget.children[index];
          }
          return child;
        },
      );
    }
    return PageView(
      scrollDirection: widget.scrollDirection,
      controller: widget.controller,
      // 页面切换开始时更新指示器（动画同步）
      onPageChanged: (index) {
        if (widget.loop == true) {
          _currentPage.value = (index - 1) % widget.children.length;
        } else {
          _currentPage.value = index;
        }
        widget.onChanged?.call(_currentPage.value);
      },
      physics: widget.touchable == true
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        if (widget.loop == true) widget.children.last,
        ...widget.children,
        if (widget.loop == true) widget.children.first,
      ],
    );
  }

  List<Widget> getIndicators(int activeIndex) {
    return List.generate(widget.children.length, (index) {
      return Container(
        width: widget.dotSize ?? 6.bw,
        height: widget.dotSize ?? 6.bw,
        decoration: BoxDecoration(
          color: widget.indicatorColor!.withAlpha(
            (activeIndex == index ? 255 : 127),
          ),
          borderRadius: BorderRadius.circular(widget.dotSize ?? 6.bw),
        ),
      );
    });
  }

  Widget getIndicator() {
    if (widget.scrollDirection == Axis.vertical) {
      return Positioned(
        top: 0,
        bottom: 0,
        left: 12.bw,
        child: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, activeIndex, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.bw,
              children: getIndicators(activeIndex),
            );
          },
        ),
      );
    } else {
      return Positioned(
        bottom: 12.bw,
        left: 0,
        right: 0,
        child: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, activeIndex, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.bw,
              children: getIndicators(activeIndex),
            );
          },
        ),
      );
    }
  }
}
