import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';

chooseImageDialog({
  required String title,
  Widget? content,
  VoidCallback? onTapButton1,
  VoidCallback? onTapButton2,
  Widget? button1Child,
  Widget? button2Child,
  Color? button1Color,
  Color? button2Color,
  required context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FadeInUp(
        duration: const Duration(milliseconds: 400),
        child: AlertDialog(
          backgroundColor: context.colorScheme.primary,
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.bold,
          ),
          content: content,
          actions: [
            if (onTapButton1 != null)
              CustomButton(
                height: 50,
                buttoncolor: button1Color,
                borderRadius: BorderRadius.circular(30),
                onTap: onTapButton1,
                child: button1Child!,
              ),
            if (onTapButton2 != null) 10.kH,
            if (onTapButton2 != null)
              CustomButton(
                height: 50,
                buttoncolor: button2Color,
                borderRadius: BorderRadius.circular(30),
                onTap: onTapButton2,
                child: button2Child!,
              ),
          ],
        ),
      );
    },
  );
}
