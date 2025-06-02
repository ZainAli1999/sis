import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';

confirmationDialog({
  required BuildContext context,
  required String title,
  required VoidCallback onTapConfirm,
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
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 50,
                    buttoncolor: themegreencolor2,
                    borderRadius: BorderRadius.circular(30),
                    onTap: onTapConfirm,
                    child: Text(
                      "Yes",
                      style: context.textTheme.bodySmall?.themeWhiteColor.bold,
                    ),
                  ),
                ),
                10.kW,
                Expanded(
                  child: CustomButton(
                    height: 50,
                    buttoncolor: themeredcolor,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      Go.pop(context);
                    },
                    child: Text(
                      "No",
                      style: context.textTheme.bodySmall?.themeWhiteColor.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
