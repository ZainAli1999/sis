import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/home/views/widgets/project_card.dart';
import 'package:sis/features/projects/viewmodel/project_viewmodel.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends ConsumerState<ProjectsPage> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildPageHeader(),
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    final projectsAsync = ref.watch(projectsProvider);
    final hasProjects = projectsAsync.value?.isNotEmpty ?? false;
    return AppBar(
      title: const Text('Projects'),
      bottom: hasProjects
          ? PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 16,
                ),
                child: CustomTextField(
                  controller: _searchController,
                  hintText: "Search by price, name...",
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
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildPageBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const CustomHorizontalCalendar(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ref.watch(projectsProvider).when(
                  data: (projects) {
                    final searchProjects = projects.where((project) {
                      bool matchesSearchQuery = [
                        project.title,
                        project.organization,
                        project.priority,
                      ].any(
                        (element) => element
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()),
                      );
                      return matchesSearchQuery;
                    }).toList();
                    if (searchProjects.isEmpty) {
                      return _buildNoProjectsView();
                    }
                    return SliderView(
                      items: searchProjects.length,
                      isListView: true,
                      spacer: 10.kH,
                      scrollDirection: Axis.vertical,
                      childBuilder: (context, index) {
                        return ProjectCard(
                          project: searchProjects[index],
                        );
                      },
                    );
                  },
                  loading: () => _buildShimmerLoading(),
                  error: (error, st) {
                    return Center(
                      child: Text(
                        error.toString(),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoProjectsView() {
    return SizedBox(
      height: context.screenHeight / 100 * 75,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: context.colorScheme.surface,
              radius: 80,
              child: const Icon(
                Icons.close,
                size: 100,
                color: Palette.themecolor,
              ),
            ),
          ),
          20.kH,
          Center(
            child: Text(
              "No Projects Found",
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildShimmerLoading() {
    return SliderView(
      scrollDirection: Axis.vertical,
      isListView: true,
      spacer: 10.kH,
      items: 10,
      childBuilder: (context, index) {
        return Padding(
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
        );
      },
    );
  }
}
