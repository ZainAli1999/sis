import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/home/views/widgets/project_card.dart';
import 'package:sis/features/projects/viewmodel/project_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildPageHeader(),
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    final user = ref.watch(currentUserNotifierProvider)!;
    return AppBar(
      title: Text(
        "Hey! ${user.firstName} ${user.lastName}",
      ),
    );
  }

  Widget _buildPageBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hintText: "Search for Project",
              enabledBorderColor: context.colorScheme.surface,
              focusedBorderColor: Palette.themecolor,
              isOutlinedInputBorder: true,
              outlineBorderRadius: 40,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
              suffix: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
          16.kH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'My Projects',
              style: context.textTheme.bodyLarge?.bold,
            ),
          ),
          6.kH,
          ref.watch(projectsProvider).when(
                data: (projects) {
                  return SliderView(
                    items: projects.length,
                    scrollDirection: Axis.horizontal,
                    childBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ProjectCard(
                          project: projects[index],
                        ),
                      );
                    },
                  );
                },
                loading: () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 250,
                    width: context.screenWidth / 100 * 80,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: context.colorScheme.surfaceDim,
                      highlightColor: context.colorScheme.shadow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 110,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surface,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          10.kH,
                          Container(
                            height: 15,
                            width: 150,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surface,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          6.kH,
                          Container(
                            height: 15,
                            width: 150,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surface,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          6.kH,
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: context.colorScheme.surface,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                error: (error, st) {
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
