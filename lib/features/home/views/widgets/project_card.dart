import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
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
import 'package:sis/features/projects/models/project_model.dart';

class ProjectCard extends ConsumerStatefulWidget {
  final ProjectModel project;
  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Banner(
      message: widget.project.priority,
      location: BannerLocation.topEnd,
      color: widget.project.priority == 'Low'
          ? themeyellowcolor
          : widget.project.priority == 'Medium'
              ? themegreencolor
              : themeredcolor,
      child: FilledBox(
        width: context.screenWidth / 100 * 80,
        color: context.colorScheme.primary,
        onTap: () {
          Go.named(
            context,
            RouteName.projectDetailsPage,
            params: {
              "id": widget.project.id,
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
              width: 130,
              innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
              color: Palette.themecolor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(30),
              child: Center(
                child: Text(
                  Helpers.timeLeft(widget.project.deadline),
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: Palette.themecolor)
                      .w600,
                ),
              ),
            ),
            10.kH,
            Text(
              widget.project.title,
              style: context.textTheme.bodyMedium?.w600,
            ),
            6.kH,
            Text(
              widget.project.organization,
              style: context.textTheme.labelLarge?.themeColor,
            ),
            6.kH,
            Text(
              widget.project.description,
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
            Stack(
              children: [
                for (int i = 0;
                    i <
                        (widget.project.assignedTo.length > 5
                            ? 5
                            : widget.project.assignedTo.length);
                    i++)
                  ref
                      .watch(getUserByIdProvider(widget.project.assignedTo[i]))
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
                if (widget.project.assignedTo.length > 5)
                  Positioned(
                    left: 5 * 25.0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: context.colorScheme.surface,
                      child: Text(
                        '+${widget.project.assignedTo.length - 5}',
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    height: 40,
                    width: 140,
                    buttoncolor: Palette.themecolor,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Text(
                      "View Progress",
                      style: context.textTheme.labelLarge?.themeWhiteColor.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
