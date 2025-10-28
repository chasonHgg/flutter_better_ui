import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double speed;

  const MarqueeWidget({
    Key? key,
    required this.text,
    this.style,
    this.speed = 1.0,
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String _fullText;
  late double _textWidth;
  late double _screenWidth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: -1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        )..addListener(() {
          setState(() {});
        });
    _controller.repeat();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _textWidth = _getTextPainter().width;
        _screenWidth = MediaQuery.of(context).size.width;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextPainter _getTextPainter() {
    return TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset((_textWidth + _screenWidth) * _animation.value, 0),
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marquee Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Marquee Demo')),
        body: Center(
          child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.black,
            child: MarqueeWidget(
              text: '公告内容公告内容公告内容公告内容公告内容...',
              style: const TextStyle(color: Colors.white, fontSize: 18),
              speed: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
