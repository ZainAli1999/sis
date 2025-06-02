import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ResponsiveExtension on BuildContext {
  bool get isPhone => ResponsiveBreakpoints.of(this).isPhone;
  bool get isMobile => ResponsiveBreakpoints.of(this).isMobile;
  bool get isTablet => ResponsiveBreakpoints.of(this).isTablet;
  bool get isDesktop => ResponsiveBreakpoints.of(this).isDesktop;
  bool get isSmallerThanDesktop =>
      ResponsiveBreakpoints.of(this).smallerThan(DESKTOP);
  bool get isLargerThanDesktop =>
      ResponsiveBreakpoints.of(this).largerThan(DESKTOP);
  bool get isSmallerThanMobile =>
      ResponsiveBreakpoints.of(this).smallerThan(MOBILE);
  bool get isLargerThanMobile =>
      ResponsiveBreakpoints.of(this).largerThan(MOBILE);
}
