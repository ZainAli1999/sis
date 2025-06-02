import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/confirmation_dialog.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/enums/toast_enum.dart';
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
import 'package:sis/features/client/viewmodel/client_viewmodel.dart';
import 'package:sis/features/projects/viewmodel/project_viewmodel.dart';
import 'package:sis/features/tasks/model/task_model.dart';
import 'package:sis/features/tasks/viewmodel/task_viewmodel.dart';
// import 'package:url_launcher/url_launcher.dart';

class TaskDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const TaskDetailsPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends ConsumerState<TaskDetailsPage> {
  // Future<void> _openPdf(String filePath) async {
  //   final Uri pdfUri = Uri.parse(filePath);

  //   if (await canLaunchUrl(pdfUri)) {
  //     await launchUrl(pdfUri);
  //   } else {
  //     throw 'Could not open the PDF file.';
  //   }
  // }

  final _dateFormatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(taskViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      taskViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Task Created Successfully!',
              context: context,
              toastType: ToastType.success,
            );
            Go.pop(context);
          },
          error: (error, st) {
            showToast(
              content: error.toString(),
              context: context,
              toastType: ToastType.error,
            );
          },
          loading: () {},
        );
      },
    );
    return ref.watch(getTaskByIdProvider(widget.id)).when(
          data: (task) => Stack(
            children: [
              Scaffold(
                appBar: _buildPageHeader(task),
                body: _buildPageBody(task),
                bottomNavigationBar: _buildPageFooter(task),
              ),
              if (isLoading) const LoadingProgress(),
            ],
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

  PreferredSizeWidget _buildPageHeader(TaskModel task) {
    return AppBar(
      title: const Text('Task Details'),
      actions: [
        FilledBox(
          height: 35,
          width: 110,
          innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
          color: Palette.themecolor.withAlpha(38),
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              Helpers.timeLeft(task.deadline),
              style: context.textTheme.labelLarge
                  ?.copyWith(
                    color: Palette.themecolor,
                  )
                  .w600,
            ),
          ),
          onTap: () {
            Go.named(
              context,
              RouteName.editTaskPage,
              params: {
                'id': widget.id,
              },
            );
          },
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody(TaskModel task) {
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
                  task.title,
                  style: context.textTheme.bodyMedium?.bold,
                ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Description:  ",
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                    children: [
                      TextSpan(
                        text: task.description,
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
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
                          color: task.priority == 'Low'
                              ? themeyellowcolor
                              : task.priority == 'Medium'
                                  ? themegreencolor
                                  : themeredcolor,
                        )
                        .bold,
                    children: [
                      TextSpan(
                        text: task.priority,
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
                ),
                6.kH,
                Builder(
                  builder: (context) {
                    final clientAsync =
                        ref.watch(clientByIdProvider(task.createdBy));
                    final userAsync =
                        ref.watch(getUserByIdProvider(task.createdBy));

                    if (clientAsync.isLoading || userAsync.isLoading) {
                      return Shimmer.fromColors(
                        baseColor: context.colorScheme.surfaceDim,
                        highlightColor: context.colorScheme.shadow,
                        child: Container(
                          height: 20,
                          width: 120,
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    }

                    return clientAsync.maybeWhen(
                      data: (client) {
                        return Text(
                          "Created By ${client.firstName} ${client.lastName}",
                          style: context
                              .textTheme.labelLarge?.themeGreyTextColor
                              .copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        );
                      },
                      orElse: () {
                        return userAsync.maybeWhen(
                          data: (user) {
                            return Text(
                              "Created By ${user.firstName} ${user.lastName}",
                              style: context
                                  .textTheme.labelLarge?.themeGreyTextColor
                                  .copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          },
                          orElse: () => const SizedBox(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          ref.watch(projectByIdProvider(task.projectId)).when(
                data: (project) {
                  return FilledBox(
                    width: context.screenWidth,
                    color: Palette.themecolor.withAlpha(50),
                    borderRadius: BorderRadius.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Project Details",
                          style: context.textTheme.bodySmall?.themeColor.bold,
                        ),
                        5.kH,
                        Text(
                          project.title,
                          style: context.textTheme.titleSmall?.themeColor.w600,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Organization:  ",
                            style: context.textTheme.labelLarge?.themeColor,
                            children: [
                              TextSpan(
                                text: project.organization,
                                style: context.textTheme.labelLarge?.themeColor,
                              ),
                            ],
                          ),
                        ),
                        if (project.dueDate != null)
                          Text.rich(
                            TextSpan(
                              text: "Due Date:  ",
                              style: context.textTheme.labelLarge?.themeColor,
                              children: [
                                TextSpan(
                                  text: _dateFormatter.format(project.dueDate!),
                                  style:
                                      context.textTheme.labelLarge?.themeColor,
                                ),
                              ],
                            ),
                          ),
                        Text.rich(
                          TextSpan(
                            text: "Deadline:  ",
                            style: context.textTheme.labelLarge?.themeColor,
                            children: [
                              TextSpan(
                                text: _dateFormatter.format(project.deadline),
                                style: context.textTheme.labelLarge?.themeColor,
                              ),
                            ],
                          ),
                        ),
                      ],
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
          20.kH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Assigned to',
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
          10.kH,
          SizedBox(
            height: 110,
            child: GridView.builder(
              itemCount: task.assignedTo.length,
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
                final assignedUser = task.assignedTo[index];
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
        ],
      ),
    );
  }

  Widget _buildPageFooter(TaskModel task) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomButton(
        height: 55,
        buttoncolor: Palette.themecolor,
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          confirmationDialog(
            context: context,
            title: "Are you sure you want to done this task?",
            onTapConfirm: () async {
              Go.pop(context);
              await ref
                  .read(taskViewModelProvider.notifier)
                  .doneTask(id: task.id);
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Done Task",
              style: context.textTheme.bodyMedium?.themeWhiteColor.bold,
            ),
            10.kW,
            const Icon(
              Icons.check_circle,
              color: themewhitecolor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      height: 160,
      width: context.screenWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
      ),
      child: Shimmer.fromColors(
        baseColor: context.colorScheme.surfaceDim,
        highlightColor: context.colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 15,
              width: 110,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            10.kH,
            Container(
              height: 25,
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
          ],
        ),
      ),
    );
  }
}
