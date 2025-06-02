import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sis/core/theme/colors.dart';

class LoadingProgress extends StatelessWidget {
  final double size;
  final Color color;
  const LoadingProgress({
    super.key,
    this.size = 40,
    this.color = Palette.themecolor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: LoadingAnimationWidget.inkDrop(
          color: color,
          size: size,
        ),
      ),
    );
  }
}
