import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/add_members_dialog.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/common_widgets/outlined_box.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/projects/viewmodel/project_viewmodel.dart';
import 'package:sis/features/tasks/viewmodel/task_viewmodel.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priorityController = TextEditingController();

  DateTime? _deadline;

  final List<String> _priority = [
    'High',
    'Medium',
    'Low',
  ];

  String? _selectedPriority;

  String? _selectedProjectId;

  String? _selectedProject;

  final List<String> _selectAssignedTo = [];

  List<String> employeesDeviceTokens = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

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
              content: 'Task Added Successfully!',
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
    return Stack(
      children: [
        Scaffold(
          appBar: _buildPageHeader(),
          body: _buildPageBody(),
        ),
        if (isLoading) const LoadingProgress()
      ],
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Add Task'),
      actions: [
        CustomButton(
          height: 40,
          width: 140,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            if (_formKey.currentState!.validate() &&
                _selectedPriority != null &&
                _deadline != null &&
                _selectAssignedTo.isNotEmpty) {
              await ref.read(taskViewModelProvider.notifier).addTask(
                    title: _titleController.text,
                    description: _descController.text,
                    deadline: _deadline!,
                    priority: _selectedPriority!,
                    projectId: _selectedProjectId!,
                    receiverId: _selectAssignedTo,
                    assignedTo: _selectAssignedTo,
                    body: 'You have new task on $_selectedProject',
                    deviceTokens: employeesDeviceTokens,
                  );
            } else if (_selectedPriority == null) {
              showToast(
                content: 'Please Select Priority',
                context: context,
                toastType: ToastType.error,
              );
            } else if (_deadline == null) {
              showToast(
                content: 'Please Select Deadline',
                context: context,
                toastType: ToastType.error,
              );
            } else if (_selectAssignedTo.isEmpty) {
              showToast(
                content: 'Please Select Assigned to',
                context: context,
                toastType: ToastType.error,
              );
            } else {
              showToast(
                content: 'Please Enter All Required Fields',
                context: context,
                toastType: ToastType.error,
              );
            }
          },
          child: Text(
            "Add Task",
            style: context.textTheme.labelLarge?.themeWhiteColor.bold,
          ),
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const CustomHorizontalCalendar(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomTextField(
                    controller: _titleController,
                    validator: validateField,
                    hintText: "Title",
                    isOutlinedInputBorder: true,
                    enabledBorderColor: context.colorScheme.surface,
                    focusedBorderColor: Palette.themecolor,
                    padding: const EdgeInsets.all(16),
                  ),
                  24.kH,
                  Text(
                    'Description',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomTextField(
                    controller: _descController,
                    validator: validateField,
                    maxLines: 4,
                    hintText: "Description",
                    isOutlinedInputBorder: true,
                    enabledBorderColor: context.colorScheme.surface,
                    focusedBorderColor: Palette.themecolor,
                    padding: const EdgeInsets.all(16),
                  ),
                  24.kH,
                  Text(
                    'Priority',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomDropdown(
                    hintText: 'Select Priority',
                    items: _priority,
                    closedHeaderPadding: const EdgeInsets.all(16),
                    expandedHeaderPadding: const EdgeInsets.all(16),
                    decoration: CustomDropdownDecoration(
                      closedFillColor: context.colorScheme.primary,
                      expandedFillColor: context.colorScheme.primary,
                      closedBorder: Border.all(
                        color: context.colorScheme.surface,
                      ),
                      headerStyle: context.textTheme.bodySmall,
                      hintStyle: context.textTheme.bodySmall,
                      listItemStyle: context.textTheme.bodySmall,
                      closedSuffixIcon: Icon(
                        Icons.expand_more,
                        color: context.colorScheme.secondary,
                      ),
                      expandedSuffixIcon: Icon(
                        Icons.expand_less,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                    onChanged: (value) {
                      log('changing value to: $value');
                      _selectedPriority = value;
                    },
                  ),
                  24.kH,
                  Text(
                    'Deadline',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _deadline = selectedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.surface,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _deadline != null
                                ? "${_deadline!.day}/${_deadline!.month}/${_deadline!.year}"
                                : "Select Deadline",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  24.kH,
                  Text(
                    'Project',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  ref.watch(projectsProvider).when(
                        data: (projects) {
                          return CustomDropdown.search(
                            hintText: 'Select Project',
                            items: projects
                                .map((project) => project.title)
                                .toList(),
                            closedHeaderPadding: const EdgeInsets.all(15),
                            expandedHeaderPadding: const EdgeInsets.all(15),
                            decoration: CustomDropdownDecoration(
                              closedFillColor: context.colorScheme.primary,
                              expandedFillColor: context.colorScheme.primary,
                              headerStyle: context.textTheme.bodySmall,
                              hintStyle: context.textTheme.bodySmall,
                              listItemStyle: context.textTheme.bodySmall,
                              closedBorder: Border.all(
                                color: context.colorScheme.surface,
                              ),
                              closedSuffixIcon: Icon(
                                Icons.expand_more,
                                color: context.colorScheme.secondary,
                              ),
                              expandedSuffixIcon: Icon(
                                Icons.expand_less,
                                color: context.colorScheme.secondary,
                              ),
                              listItemDecoration: ListItemDecoration(
                                selectedIconColor:
                                    context.colorScheme.secondary,
                              ),
                              searchFieldDecoration: SearchFieldDecoration(
                                contentPadding: EdgeInsets.zero,
                                textStyle: context.textTheme.bodySmall,
                              ),
                            ),
                            onChanged: (value) {
                              final selectedProject = projects.firstWhere(
                                (project) => project.title == value,
                              );
                              log('Selected project title: $value, ID: ${selectedProject.id}');
                              _selectedProjectId = selectedProject.id;
                              _selectedProject = selectedProject.title;
                            },
                          );
                        },
                        loading: () => Text(
                          "Loading...",
                          style: context.textTheme.bodySmall,
                        ),
                        error: (error, st) => Center(
                          child: Text(
                            error.toString(),
                          ),
                        ),
                      ),
                  24.kH,
                  Text(
                    'Assigned to',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          OutlinedBox(
                            height: 50,
                            width: 50,
                            shape: BoxShape.circle,
                            child: const Icon(Icons.add),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AddMembersDialog(
                                  selectMembers: _selectAssignedTo,
                                  employeesDeviceTokens: employeesDeviceTokens,
                                  pageState: setState,
                                ),
                              );
                            },
                          ),
                          5.kH,
                          Text(
                            'Add',
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ref.watch(fetchUsersProvider).when(
                              data: (employees) {
                                final selectedEmployees = employees
                                    .where((employee) => _selectAssignedTo
                                        .contains(employee.uid))
                                    .toList();
                                return SliderView(
                                  items: selectedEmployees.length,
                                  childBuilder: (context, index) {
                                    final employee = selectedEmployees[index];
                                    final isSelected = _selectAssignedTo
                                        .contains(employee.uid);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectAssignedTo
                                                .remove(employee.uid);
                                            employeesDeviceTokens.removeWhere(
                                                (token) => employee.deviceTokens
                                                    .contains(token));
                                          } else {
                                            _selectAssignedTo.add(employee.uid);
                                            employeesDeviceTokens
                                                .addAll(employee.deviceTokens);
                                          }
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          employee.profileImage.isEmpty
                                              ? isSelected
                                                  ? Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: context
                                                              .colorScheme
                                                              .secondary,
                                                          width: 2.5,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                            Constants
                                                                .defaultProfileImage,
                                                          ),
                                                          fit: BoxFit.cover,
                                                          opacity: 0.5,
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: context
                                                            .colorScheme
                                                            .secondary,
                                                        size: 30,
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      Constants
                                                          .defaultProfileImage,
                                                      height: 50,
                                                      width: 50,
                                                    )
                                              : isSelected
                                                  ? Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: context
                                                              .colorScheme
                                                              .secondary,
                                                          width: 2.5,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            employee
                                                                .profileImage,
                                                          ),
                                                          fit: BoxFit.cover,
                                                          opacity: 0.5,
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: context
                                                            .colorScheme
                                                            .secondary,
                                                        size: 30,
                                                      ),
                                                    )
                                                  : CustomCachedNetworkImage(
                                                      imageUrl:
                                                          employee.profileImage,
                                                      imageBuilder: (context,
                                                          imageProvider) {
                                                        return CircleAvatar(
                                                          radius: 25,
                                                          backgroundImage:
                                                              imageProvider,
                                                        );
                                                      },
                                                      animChild: CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor: context
                                                            .colorScheme
                                                            .surface,
                                                      ),
                                                    ),
                                          5.kH,
                                          Text(
                                            "${employee.firstName} ${employee.lastName}",
                                            style: context.textTheme.labelLarge,
                                          ),
                                          Text(
                                            employee.cid,
                                            style: context.textTheme.labelLarge
                                                ?.themeGreyTextColor,
                                          ),
                                          Text(
                                            employee.designation,
                                            style: context.textTheme.labelLarge
                                                ?.themeColor,
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
                              loading: () => Shimmer.fromColors(
                                baseColor: context.colorScheme.onSurface,
                                highlightColor: context.colorScheme.surface,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          context.colorScheme.surface,
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
                            ),
                      ),
                    ],
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
