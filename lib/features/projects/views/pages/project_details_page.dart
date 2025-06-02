import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/projects/models/project_model.dart';
import 'package:sis/features/projects/viewmodel/project_viewmodel.dart';
import 'package:sis/features/tasks/viewmodel/task_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const ProjectDetailsPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  Future<void> _openPdf(String filePath) async {
    final Uri pdfUri = Uri.parse(filePath);

    if (await canLaunchUrl(pdfUri)) {
      await launchUrl(pdfUri);
    } else {
      throw 'Could not open the PDF file.';
    }
  }

  final _dateFormatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return ref.watch(projectByIdProvider(widget.id)).when(
          data: (project) => Scaffold(
            appBar: _buildPageHeader(project),
            body: _buildPageBody(project),
            bottomNavigationBar: _buildPageFooter(project),
          ),
          error: (error, st) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
          loading: () => const Scaffold(
            body: LoadingProgress(),
          ),
        );
  }

  PreferredSizeWidget _buildPageHeader(ProjectModel project) {
    return AppBar(
      title: const Text('Project Details'),
      actions: [
        FilledBox(
          height: 35,
          width: 130,
          innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
          color: Palette.themecolor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              Helpers.timeLeft(project.deadline),
              style: context.textTheme.labelLarge
                  ?.copyWith(
                    color: Palette.themecolor,
                  )
                  .w600,
            ),
          ),
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody(ProjectModel project) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: context.textTheme.bodyMedium?.bold,
                ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Organization:  ",
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                    children: [
                      TextSpan(
                        text: project.organization,
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
                      ),
                    ],
                  ),
                ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Description:  ",
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                    children: [
                      TextSpan(
                        text: project.description,
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
                      ),
                    ],
                  ),
                ),
                if (project.dueDate != null) 6.kH,
                if (project.dueDate != null)
                  Text.rich(
                    TextSpan(
                      text: "Due Date:  ",
                      style: context.textTheme.labelLarge?.themeGreyTextColor,
                      children: [
                        TextSpan(
                          text: _dateFormatter.format(project.dueDate!),
                          style:
                              context.textTheme.labelLarge?.themeGreyTextColor,
                        ),
                      ],
                    ),
                  ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Priority:  ",
                    style: context.textTheme.bodySmall
                        ?.copyWith(
                          color: project.priority == 'Low'
                              ? themeyellowcolor
                              : project.priority == 'Medium'
                                  ? themegreencolor
                                  : themeredcolor,
                        )
                        .bold,
                    children: [
                      TextSpan(
                        text: project.priority,
                        style: context.textTheme.bodySmall
                            ?.copyWith(
                              color: project.priority == 'Low'
                                  ? themeyellowcolor
                                  : project.priority == 'Medium'
                                      ? themegreencolor
                                      : themeredcolor,
                            )
                            .bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Attachments',
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
          6.kH,
          project.attachments!.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "No Attachments found",
                    style: context.textTheme.bodySmall,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      project.attachments!.length,
                      (index) => FilledBox(
                        innerBoxPadding: const EdgeInsets.all(12),
                        onTap: () {
                          _openPdf(
                            project.attachments![index],
                          );
                        },
                        child: Text(
                          project.attachments![index].split('/').last,
                          style: context.textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Assigned to',
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
          SizedBox(
            height: 110,
            child: GridView.builder(
              itemCount: project.assignedTo.length,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 110,
              ),
              itemBuilder: (context, index) {
                final assignedUser = project.assignedTo[index];
                return ref.watch(getUserByIdProvider(assignedUser)).when(
                      data: (employee) {
                        return Column(
                          children: [
                            employee.profileImage.isEmpty
                                ? Image.asset(
                                    Constants.defaultProfileImage,
                                    height: 60,
                                    width: 60,
                                  )
                                : CustomCachedNetworkImage(
                                    imageUrl: employee.profileImage,
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        radius: 30,
                                        backgroundImage: imageProvider,
                                      );
                                    },
                                    animChild: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          context.colorScheme.surface,
                                    ),
                                  ),
                            5.kH,
                            Text(
                              "${employee.firstName} ${employee.lastName}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: context.textTheme.labelLarge?.w500,
                            ),
                          ],
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
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: context.colorScheme.surface,
                            ),
                            5.kH,
                            Container(
                              height: 15,
                              width: 100,
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Tasks',
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
          ref.watch(getTasksByProjectIdProvider(project.id)).when(
                data: (tasks) {
                  return SliderView(
                    padding: const EdgeInsets.only(bottom: 8),
                    scrollDirection: Axis.vertical,
                    items: tasks.length,
                    childBuilder: (context, index) {
                      final task = tasks[index];
                      return Theme(
                        data: ThemeData(dividerColor: transparentcolor),
                        child: ExpansionTile(
                          backgroundColor: context.colorScheme.surface,
                          collapsedBackgroundColor: context.colorScheme.surface,
                          expandedAlignment: Alignment.centerLeft,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          childrenPadding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  task.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodySmall?.w500,
                                ),
                              ),
                              10.kW,
                              Text(
                                task.priority,
                                style: context.textTheme.bodySmall
                                    ?.copyWith(
                                      color: task.priority == 'Low'
                                          ? themeyellowcolor
                                          : task.priority == 'Medium'
                                              ? themegreencolor
                                              : themeredcolor,
                                    )
                                    .bold,
                              ),
                            ],
                          ),
                          children: [
                            Text(
                              "Task Details",
                              style: context.textTheme.bodySmall?.w500,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Description:  ",
                                style: context.textTheme.labelLarge?.w500,
                                children: [
                                  TextSpan(
                                    text: task.description,
                                    style: context.textTheme.labelLarge?.w500,
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Deadline:  ",
                                style: context.textTheme.labelLarge?.w500,
                                children: [
                                  TextSpan(
                                    text: _dateFormatter.format(task.deadline),
                                    style: context.textTheme.labelLarge?.w500,
                                  ),
                                ],
                              ),
                            ),
                            10.kH,
                            Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: List.generate(
                                task.assignedTo.length,
                                (employeeIndex) => ref
                                    .watch(
                                      getUserByIdProvider(
                                        task.assignedTo[employeeIndex],
                                      ),
                                    )
                                    .when(
                                      data: (employee) {
                                        return IntrinsicWidth(
                                          child: FilledBox(
                                            innerBoxPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 16,
                                            ),
                                            color: context.colorScheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Row(
                                              children: [
                                                employee.profileImage.isEmpty
                                                    ? Image.asset(
                                                        Constants
                                                            .defaultProfileImage,
                                                        height: 40,
                                                        width: 40,
                                                      )
                                                    : CustomCachedNetworkImage(
                                                        imageUrl: employee
                                                            .profileImage,
                                                        imageBuilder: (context,
                                                            imageProvider) {
                                                          return CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage:
                                                                imageProvider,
                                                          );
                                                        },
                                                        animChild: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              context
                                                                  .colorScheme
                                                                  .surface,
                                                        ),
                                                      ),
                                                10.kW,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${employee.firstName} ${employee.lastName}",
                                                      maxLines: 2,
                                                      style: context.textTheme
                                                          .labelLarge?.w500,
                                                    ),
                                                    Text(
                                                      employee.cid,
                                                      maxLines: 2,
                                                      style: context.textTheme
                                                          .labelLarge?.w500,
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                      loading: () => _buildShimmerLoading(),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, st) {
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                },
                loading: () => _buildShimmerLoading(),
              ),
        ],
      ),
    );
  }

  Widget _buildPageFooter(ProjectModel project) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Project Progress",
                style: context.textTheme.bodySmall?.bold,
              ),
              Text(
                "70%",
                style: context.textTheme.bodySmall?.bold,
              ),
            ],
          ),
          12.kH,
          LinearProgressIndicator(
            minHeight: 10,
            borderRadius: BorderRadius.circular(30),
            value: 0.7,
            backgroundColor: context.colorScheme.surface,
            color: Palette.themecolor,
          ),
          12.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.gps_fixed_sharp),
              10.kW,
              Text.rich(
                TextSpan(
                  text: "Deadline:  ",
                  style: context.textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text:
                          DateFormat('MMMM dd, yyyy').format(project.deadline),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      height: 60,
      width: context.screenWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
      ),
      child: Shimmer.fromColors(
        baseColor: context.colorScheme.surfaceDim,
        highlightColor: context.colorScheme.surface,
        child: Container(
          height: 20,
          width: 110,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
