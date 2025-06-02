import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/bullet_point.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';

class Section extends StatelessWidget {
  final String? heading;
  final String? title;
  final String? content;
  final RichText? richTextContent;
  final List<String>? bulletPoints;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry headingPadding;

  const Section({
    super.key,
    this.heading,
    this.title,
    this.content,
    this.richTextContent,
    this.bulletPoints,
    this.titlePadding = const EdgeInsets.only(top: 16.0),
    this.headingPadding = const EdgeInsets.only(top: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: headingPadding,
            child: Text(
              heading!,
              style: context.textTheme.titleSmall?.themeGreyTextColor.bold,
            ),
          ),
        if (title != null)
          Padding(
            padding: titlePadding,
            child: Text(
              title!,
              style: context.textTheme.bodyMedium?.themeGreyTextColor.bold,
            ),
          ),
        if (content != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              content!,
              style: context.textTheme.bodySmall,
            ),
          ),
        if (richTextContent != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: richTextContent,
          ),
        if (bulletPoints != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: bulletPoints!
                  .map((point) => BulletPoint(text: point))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
