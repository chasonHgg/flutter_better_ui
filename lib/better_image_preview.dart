import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

/// The location of the close button in [BetterImagePreview].
enum BetterImagePreviewClosePosition { topLeft, topRight }

typedef BetterImagePreviewBuilder =
    Widget Function(BuildContext context, String image, int index);

/// Wraps the default image while preserving its loading and error states.
typedef BetterImagePreviewImageBuilder =
    Widget Function(
      BuildContext context,
      String image,
      int index,
      Widget child,
    );

/// A full-screen image viewer inspired by Vant's ImagePreview.
class BetterImagePreview {
  const BetterImagePreview._();

  /// Opens a full-screen image preview.
  ///
  /// [images] must not be empty. HTTP(S) values are loaded as network images;
  /// other values are treated as Flutter asset names. The returned future
  /// completes after the preview has closed.
  static Future<void> show({
    BuildContext? context,
    required List<String> images,
    int startPosition = 0,
    bool loop = true,
    bool vertical = false,
    bool doubleScale = true,
    bool showIndex = true,
    bool closeable = false,
    bool closeOnTap = true,
    BetterImagePreviewClosePosition closePosition =
        BetterImagePreviewClosePosition.topRight,
    Color backgroundColor = Colors.black,
    double minScale = 1,
    double maxScale = 4,
    Duration transitionDuration = const Duration(milliseconds: 250),
    ValueChanged<int>? onChange,
    ValueChanged<int>? onClose,
    BetterImagePreviewImageBuilder? imageBuilder,
    BetterImagePreviewBuilder? loadingBuilder,
    BetterImagePreviewBuilder? errorBuilder,
    Widget Function(BuildContext context, int index, int total)? indexBuilder,
  }) async {
    assert(images.isNotEmpty, 'images must not be empty');
    assert(minScale > 0, 'minScale must be greater than zero');
    assert(maxScale >= minScale, 'maxScale must be >= minScale');
    if (images.isEmpty) {
      throw ArgumentError.value(images, 'images', 'must not be empty');
    }
    if (minScale <= 0 || maxScale < minScale) {
      throw ArgumentError('Expected 0 < minScale <= maxScale');
    }

    final previewContext = context ?? BetterUi.currentContext;
    if (previewContext == null) {
      throw StateError(
        'No BuildContext is available. Pass context or configure '
        'BetterUi.navigatorKey on your app.',
      );
    }
    final safeStart = startPosition.clamp(0, images.length - 1);

    await showGeneralDialog<void>(
      context: previewContext,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(
        previewContext,
      ).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _BetterImagePreviewView(
          images: List<String>.unmodifiable(images),
          startPosition: safeStart,
          loop: loop,
          vertical: vertical,
          doubleScale: doubleScale,
          showIndex: showIndex,
          closeable: closeable,
          closeOnTap: closeOnTap,
          closePosition: closePosition,
          backgroundColor: backgroundColor,
          minScale: minScale,
          maxScale: maxScale,
          onChange: onChange,
          onClose: onClose,
          imageBuilder: imageBuilder,
          loadingBuilder: loadingBuilder,
          errorBuilder: errorBuilder,
          indexBuilder: indexBuilder,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class _BetterImagePreviewView extends StatefulWidget {
  const _BetterImagePreviewView({
    required this.images,
    required this.startPosition,
    required this.loop,
    required this.vertical,
    required this.doubleScale,
    required this.showIndex,
    required this.closeable,
    required this.closeOnTap,
    required this.closePosition,
    required this.backgroundColor,
    required this.minScale,
    required this.maxScale,
    this.onChange,
    this.onClose,
    this.imageBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.indexBuilder,
  });

  final List<String> images;
  final int startPosition;
  final bool loop;
  final bool vertical;
  final bool doubleScale;
  final bool showIndex;
  final bool closeable;
  final bool closeOnTap;
  final BetterImagePreviewClosePosition closePosition;
  final Color backgroundColor;
  final double minScale;
  final double maxScale;
  final ValueChanged<int>? onChange;
  final ValueChanged<int>? onClose;
  final BetterImagePreviewImageBuilder? imageBuilder;
  final BetterImagePreviewBuilder? loadingBuilder;
  final BetterImagePreviewBuilder? errorBuilder;
  final Widget Function(BuildContext, int, int)? indexBuilder;

  @override
  State<_BetterImagePreviewView> createState() =>
      _BetterImagePreviewViewState();
}

class _BetterImagePreviewViewState extends State<_BetterImagePreviewView> {
  static const int _loopMiddle = 1000000;
  late final PageController _pageController;
  late int _page;
  late int _index;
  bool _zoomed = false;
  bool _closed = false;

  bool get _canLoop => widget.loop && widget.images.length > 1;
  int _logicalIndex(int page) => page % widget.images.length;

  @override
  void initState() {
    super.initState();
    _index = widget.startPosition;
    _page = _canLoop
        ? _loopMiddle - (_loopMiddle % widget.images.length) + _index
        : _index;
    _pageController = PageController(initialPage: _page);
    WidgetsBinding.instance.addPostFrameCallback((_) => _precacheNeighbors());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ImageProvider<Object> _provider(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https')
        ? NetworkImage(value)
        : AssetImage(value);
  }

  void _precacheNeighbors() {
    if (!mounted || widget.images.length < 2) return;
    final indexes = <int>{
      if (_canLoop || _index > 0)
        (_index - 1 + widget.images.length) % widget.images.length,
      if (_canLoop || _index < widget.images.length - 1)
        (_index + 1) % widget.images.length,
    };
    for (final index in indexes) {
      precacheImage(
        _provider(widget.images[index]),
        context,
      ).catchError((_) {});
    }
  }

  void _close() {
    if (_closed) return;
    _closed = true;
    widget.onClose?.call(_index);
    Navigator.of(context).pop();
  }

  void _onPageChanged(int page) {
    _page = page;
    final nextIndex = _logicalIndex(page);
    if (_index != nextIndex) {
      setState(() {
        _index = nextIndex;
        _zoomed = false;
      });
      widget.onChange?.call(nextIndex);
      _precacheNeighbors();
    }
  }

  void _goToPreviousPage() {
    if (!_canLoop && _index == 0) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToNextPage() {
    if (!_canLoop && _index == widget.images.length - 1) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final closeTooltip = MaterialLocalizations.of(context).closeButtonTooltip;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && !_closed) {
          _closed = true;
          widget.onClose?.call(_index);
        }
      },
      child: Material(
        color: widget.backgroundColor,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: widget.vertical
                      ? Axis.vertical
                      : Axis.horizontal,
                  physics: _zoomed
                      ? const NeverScrollableScrollPhysics()
                      : const PageScrollPhysics(),
                  itemCount: _canLoop ? null : widget.images.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, page) {
                    final index = _logicalIndex(page);
                    return _ZoomableImage(
                      key: ValueKey('preview-$page-${widget.images[index]}'),
                      image: widget.images[index],
                      index: index,
                      provider: _provider(widget.images[index]),
                      minScale: widget.minScale,
                      maxScale: widget.maxScale,
                      doubleScale: widget.doubleScale,
                      pageAxis: widget.vertical
                          ? Axis.vertical
                          : Axis.horizontal,
                      closeOnTap: widget.closeOnTap,
                      onTap: _close,
                      onPreviousPage: _goToPreviousPage,
                      onNextPage: _goToNextPage,
                      onZoomChanged: (zoomed) {
                        if (page == _page && _zoomed != zoomed && mounted) {
                          setState(() => _zoomed = zoomed);
                        }
                      },
                      imageBuilder: widget.imageBuilder,
                      loadingBuilder: widget.loadingBuilder,
                      errorBuilder: widget.errorBuilder,
                    );
                  },
                ),
              ),
              if (widget.showIndex)
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.paddingOf(context).top + 16.bw,
                  child: Center(
                    child:
                        widget.indexBuilder?.call(
                          context,
                          _index,
                          widget.images.length,
                        ) ??
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(14.bw),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.bw,
                              vertical: 4.bw,
                            ),
                            child: Text(
                              '${_index + 1} / ${widget.images.length}',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.bsp,
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
              if (widget.closeable)
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 8.bw,
                  left:
                      widget.closePosition ==
                          BetterImagePreviewClosePosition.topLeft
                      ? 8.bw
                      : null,
                  right:
                      widget.closePosition ==
                          BetterImagePreviewClosePosition.topRight
                      ? 8.bw
                      : null,
                  child: IconButton(
                    tooltip: closeTooltip,
                    onPressed: _close,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  const _ZoomableImage({
    super.key,
    required this.image,
    required this.index,
    required this.provider,
    required this.minScale,
    required this.maxScale,
    required this.doubleScale,
    required this.pageAxis,
    required this.closeOnTap,
    required this.onTap,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onZoomChanged,
    this.imageBuilder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final String image;
  final int index;
  final ImageProvider<Object> provider;
  final double minScale;
  final double maxScale;
  final bool doubleScale;
  final Axis pageAxis;
  final bool closeOnTap;
  final VoidCallback onTap;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final ValueChanged<bool> onZoomChanged;
  final BetterImagePreviewImageBuilder? imageBuilder;
  final BetterImagePreviewBuilder? loadingBuilder;
  final BetterImagePreviewBuilder? errorBuilder;

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> {
  late final TransformationController _controller;
  TapDownDetails? _doubleTapDetails;
  Offset? _lastFocalPoint;
  double _edgeDrag = 0;
  bool _pageSwitchTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    final currentScale = _controller.value.getMaxScaleOnAxis();
    if (currentScale > widget.minScale + 0.01) {
      _controller.value = Matrix4.identity();
      widget.onZoomChanged(false);
      return;
    }
    final position = _doubleTapDetails?.localPosition ?? Offset.zero;
    final targetScale = widget.maxScale.clamp(widget.minScale, 2.5);
    _controller.value = Matrix4.identity()
      ..translateByDouble(
        -position.dx * (targetScale - 1),
        -position.dy * (targetScale - 1),
        0,
        1,
      )
      ..scaleByDouble(targetScale, targetScale, targetScale, 1);
    widget.onZoomChanged(true);
  }

  void _onInteractionStart(ScaleStartDetails details) {
    _lastFocalPoint = details.localFocalPoint;
    _edgeDrag = 0;
    _pageSwitchTriggered = false;
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    final scale = _controller.value.getMaxScaleOnAxis();
    widget.onZoomChanged(scale > widget.minScale + 0.01);
    if (scale <= widget.minScale + 0.01 || details.pointerCount != 1) {
      _lastFocalPoint = details.localFocalPoint;
      _edgeDrag = 0;
      return;
    }

    final previousFocalPoint = _lastFocalPoint;
    _lastFocalPoint = details.localFocalPoint;
    if (previousFocalPoint == null || _pageSwitchTriggered) return;

    final size = context.size;
    if (size == null) return;
    final delta = widget.pageAxis == Axis.horizontal
        ? details.localFocalPoint.dx - previousFocalPoint.dx
        : details.localFocalPoint.dy - previousFocalPoint.dy;
    final translation = widget.pageAxis == Axis.horizontal
        ? _controller.value.storage[12]
        : _controller.value.storage[13];
    final extent = widget.pageAxis == Axis.horizontal
        ? size.width
        : size.height;
    final minimumTranslation = extent * (1 - scale);
    final edgeTolerance = 1.bw;
    final atPreviousEdge = translation >= -edgeTolerance;
    final atNextEdge = translation <= minimumTranslation + edgeTolerance;

    if ((delta > 0 && atPreviousEdge) || (delta < 0 && atNextEdge)) {
      if (_edgeDrag == 0 || _edgeDrag.sign == delta.sign) {
        _edgeDrag += delta;
      } else {
        _edgeDrag = delta;
      }
    } else {
      _edgeDrag = 0;
    }

    if (_edgeDrag.abs() >= 48.bw) {
      _pageSwitchTriggered = true;
      if (_edgeDrag > 0) {
        widget.onPreviousPage();
      } else {
        widget.onNextPage();
      }
    }
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    _lastFocalPoint = null;
    _edgeDrag = 0;
    widget.onZoomChanged(
      _controller.value.getMaxScaleOnAxis() > widget.minScale + 0.01,
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultImage = Image(
      image: widget.provider,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, synchronouslyLoaded) {
        if (synchronouslyLoaded || frame != null) return child;
        return widget.loadingBuilder?.call(
              context,
              widget.image,
              widget.index,
            ) ??
            const Center(child: CircularProgressIndicator(color: Colors.white));
      },
      errorBuilder: (context, error, stackTrace) {
        return widget.errorBuilder?.call(context, widget.image, widget.index) ??
            Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white70,
                size: 40.bw,
              ),
            );
      },
    );
    final image =
        widget.imageBuilder?.call(
          context,
          widget.image,
          widget.index,
          defaultImage,
        ) ??
        defaultImage;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.closeOnTap ? widget.onTap : null,
      onDoubleTapDown: widget.doubleScale
          ? (details) => _doubleTapDetails = details
          : null,
      onDoubleTap: widget.doubleScale ? _onDoubleTap : null,
      child: InteractiveViewer(
        transformationController: _controller,
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        panEnabled: true,
        scaleEnabled: true,
        clipBehavior: Clip.none,
        onInteractionStart: _onInteractionStart,
        onInteractionUpdate: _onInteractionUpdate,
        onInteractionEnd: _onInteractionEnd,
        child: SizedBox.expand(child: Center(child: image)),
      ),
    );
  }
}
