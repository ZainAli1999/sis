import 'package:flutter/material.dart';
import 'package:sis/core/extensions/responsive_extension.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';

class Responsive extends StatelessWidget {
  final Widget child;
  const Responsive({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isDesktop
          ? context.screenWidth / 100 * 32
          : context.isTablet
              ? context.screenWidth / 100 * 55
              : null,
      child: child,
    );
  }
}
