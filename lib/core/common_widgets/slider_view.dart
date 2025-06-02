import 'package:flutter/material.dart';

class SliderView extends StatelessWidget {
  final IndexedWidgetBuilder childBuilder;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final int items;
  final Widget? spacer;
  final bool isListView;
  final bool primary;
  final bool shrinkWrap;
  final double? height;
  final double? width;
  final bool reverse;
  final ScrollController? controller;
  const SliderView({
    super.key,
    required this.childBuilder,
    this.scrollDirection = Axis.horizontal,
    this.padding,
    required this.items,
    this.spacer,
    this.isListView = false,
    this.primary = false,
    this.shrinkWrap = true,
    this.height,
    this.width,
    this.reverse = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return isListView
        ? SizedBox(
            height: height,
            width: width,
            child: ListView.separated(
              controller: controller,
              primary: primary,
              shrinkWrap: shrinkWrap,
              reverse: reverse,
              padding: padding,
              scrollDirection: scrollDirection,
              itemCount: items,
              itemBuilder: (context, index) {
                return childBuilder(context, index);
              },
              separatorBuilder: (context, separator) {
                return spacer!;
              },
            ),
          )
        : SingleChildScrollView(
            scrollDirection: scrollDirection,
            child: scrollDirection == Axis.vertical
                ? Padding(
                    padding:
                        padding ?? const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: List.generate(
                        items,
                        (index) {
                          return Padding(
                            padding: padding != null
                                ? EdgeInsets.symmetric(
                                    vertical:
                                        (padding as EdgeInsets).vertical / 2)
                                : const EdgeInsets.symmetric(vertical: 8),
                            child: childBuilder(context, index),
                          );
                        },
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        padding ?? const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: List.generate(
                        items,
                        (index) {
                          return Padding(
                            padding: padding != null
                                ? EdgeInsets.symmetric(
                                    horizontal:
                                        (padding as EdgeInsets).horizontal / 2)
                                : const EdgeInsets.symmetric(horizontal: 8),
                            child: childBuilder(context, index),
                          );
                        },
                      ),
                    ),
                  ),
          );
  }
}
