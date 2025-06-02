import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/extensions/theme_extension.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget animChild;
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.imageBuilder,
    required this.animChild,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      fadeInDuration: const Duration(milliseconds: 750),
      fadeOutDuration: const Duration(milliseconds: 1500),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: context.colorScheme.surfaceDim,
        highlightColor: context.colorScheme.shadow,
        child: animChild,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
