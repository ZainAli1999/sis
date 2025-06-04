import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/tasks/model/task_model.dart';

class TaskCard extends ConsumerStatefulWidget {
  final TaskModel task;
  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Banner(
      message: widget.task.priority,
      location: BannerLocation.topEnd,
      color: widget.task.priority == 'Low'
          ? themeyellowcolor
          : widget.task.priority == 'Medium'
              ? themegreencolor
              : themeredcolor,
      child: FilledBox(
        width: context.screenWidth / 100 * 80,
        color: context.colorScheme.primary,
        onTap: () {
          Go.named(
            context,
            RouteName.taskDetailsPage,
            params: {
              "id": widget.task.id,
            },
          );
        },
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.surface,
            blurRadius: 10,
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledBox(
              height: 35,
              width: 110,
              innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
              color: Palette.themecolor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
              child: Center(
                child: Text(
                  Helpers.timeLeft(widget.task.deadline),
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: Palette.themecolor)
                      .w600,
                ),
              ),
            ),
            10.kH,
            Text(
              widget.task.title,
              style: context.textTheme.bodyMedium?.w600,
            ),
            6.kH,
            Text(
              widget.task.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelLarge?.themeGreyTextColor,
            ),
            8.kH,
            Text(
              'Assigned to',
              style: context.textTheme.labelLarge?.bold,
            ),
            4.kH,
            SizedBox(
              height: 40,
              child: Stack(
                children: [
                  for (int i = 0;
                      i <
                          (widget.task.assignedTo.length > 5
                              ? 5
                              : widget.task.assignedTo.length);
                      i++)
                    ref
                        .watch(getUserByIdProvider(widget.task.assignedTo[i]))
                        .when(
                          data: (user) {
                            return Positioned(
                              left: i * 25.0,
                              child: user.profileImage.isEmpty
                                  ? Image.asset(
                                      Constants.defaultProfileImage,
                                      height: 32,
                                      width: 32,
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: user.profileImage,
                                      imageBuilder: (context, imageProvider) {
                                        return CircleAvatar(
                                          radius: 16,
                                          backgroundImage: imageProvider,
                                        );
                                      },
                                      animChild: CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            context.colorScheme.surface,
                                      ),
                                    ),
                            );
                          },
                          error: (error, st) {
                            return Center(
                              child: Text(
                                error.toString(),
                              ),
                            );
                          },
                          loading: () => Shimmer.fromColors(
                            baseColor: context.colorScheme.surfaceDim,
                            highlightColor: context.colorScheme.shadow,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: context.colorScheme.surface,
                            ),
                          ),
                        ),
                  if (widget.task.assignedTo.length > 5)
                    Positioned(
                      left: 5 * 25.0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: context.colorScheme.surface,
                        child: Text(
                          '+${widget.task.assignedTo.length - 5}',
                          style: context.textTheme.labelLarge,
                        ),
                      ),
                    ),
                  if (widget.task.status == 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomIconButton(
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Palette.themecolor,
                          child: Icon(
                            Icons.check,
                            color: themewhitecolor,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
