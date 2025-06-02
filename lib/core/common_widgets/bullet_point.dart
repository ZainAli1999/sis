import 'package:flutter/material.dart';
import 'package:sis/core/extensions/theme_extension.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: context.textTheme.bodyMedium,
          ),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
