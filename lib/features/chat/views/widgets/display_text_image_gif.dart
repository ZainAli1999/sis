import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/custom_zoom_widget.dart';
import 'package:sis/core/enums/message_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';

class DisplayTextImageGif extends StatelessWidget {
  final String message;
  final String image;
  final MessageEnum type;
  const DisplayTextImageGif({
    super.key,
    required this.message,
    required this.type,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: context.textTheme.labelLarge,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: WidgetZoom(
                  heroAnimationTag: image,
                  zoomWidget: CachedNetworkImage(
                    imageUrl: image,
                    height: 375,
                    width: context.screenWidth / 100 * 55,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (message.isNotEmpty) 5.kH,
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    message,
                    style: context.textTheme.labelLarge,
                  ),
                ),
            ],
          );
  }
}
