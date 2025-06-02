import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required BuildContext context,
  required String content,
  required ToastType toastType,
  AlignmentGeometry? alignment,
  ToastificationStyle? toastificationStyle,
  Color? backgroundColor,
  Color? foregroundColor,
  BorderSide? borderSide,
  bool? applyBlurEffect,
  Duration? autoCloseDuration,
}) {
  toastification.show(
    context: context,
    alignment: alignment ?? (kIsWeb ? Alignment.topRight : Alignment.topLeft),
    title: Text(
      content,
      style: context.textTheme.labelLarge?.bold,
    ),
    autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 5),
    applyBlurEffect: applyBlurEffect ?? true,
    borderSide: borderSide ?? BorderSide(color: context.colorScheme.surface),
    backgroundColor: backgroundColor ?? context.colorScheme.surface,
    foregroundColor: foregroundColor ?? context.colorScheme.secondary,
    style: toastificationStyle ?? ToastificationStyle.minimal,
    type: toastType.toToastificationType,
  );
}
