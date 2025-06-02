import 'package:flutter/material.dart';

extension IntExtension on int {
  Widget get kH => SizedBox(
        height: toDouble(),
      );
  Widget get kW => SizedBox(
        width: toDouble(),
      );
}
