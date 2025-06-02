import 'package:flutter/material.dart';
import 'package:sis/core/extensions/spacing_extension.dart';

class CustomMarquee extends StatefulWidget {
  final Widget child;
  final double velocity;
  final Axis scrollDirection;

  const CustomMarquee({
    super.key,
    required this.child,
    this.velocity = 100.0, // Higher value makes the widget scroll faster
    this.scrollDirection = Axis.horizontal,
  });

  @override
  State<CustomMarquee> createState() => _CustomMarqueeState();
}

class _CustomMarqueeState extends State<CustomMarquee>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late double _scrollWidth;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() async {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    _scrollWidth = renderBox.size.width;

    while (true) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(
            seconds: (_scrollWidth / widget.velocity)
                .round()), // Scroll based on velocity
        curve: Curves.linear,
      );

      _scrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.scrollDirection == Axis.horizontal ? 50 : null,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        child: Row(
          key: _key,
          children: [
            widget.child,
            30.kW,
            widget.child,
          ],
        ),
      ),
    );
  }
}
