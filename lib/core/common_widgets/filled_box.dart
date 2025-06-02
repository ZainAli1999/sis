import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FilledBox extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxBorder? border;
  final BoxShape shape;
  final Color? color;
  final EdgeInsetsGeometry? innerBoxPadding;
  final EdgeInsetsGeometry outerBoxPadding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final DecorationImage? image;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final Widget? child;
  final bool applyOpacity;
  final List<Color>? opacityColors;
  final BoxConstraints? constraints;
  final VoidCallback? onTap;
  final Function(LongPressDownDetails)? onLongPressDown;
  const FilledBox({
    super.key,
    this.height,
    this.width,
    this.border,
    this.shape = BoxShape.rectangle,
    this.color = const Color(0xffE0E0E0),
    this.innerBoxPadding = const EdgeInsets.all(20),
    this.outerBoxPadding = EdgeInsets.zero,
    this.margin,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8),
    ),
    this.image,
    this.boxShadow,
    this.child,
    this.onTap,
    this.onLongPressDown,
    this.gradient,
    this.applyOpacity = false,
    this.opacityColors,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPressDown: onLongPressDown,
      child: Padding(
        padding: outerBoxPadding,
        child: Container(
          constraints: constraints,
          height: height,
          width: width,
          padding: innerBoxPadding,
          margin: margin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
            border: border,
            image: image,
            boxShadow: boxShadow,
            shape: shape,
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
