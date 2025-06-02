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

class EditTaskPage extends ConsumerStatefulWidget {
  final String id;
  const EditTaskPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends ConsumerState<EditTaskPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  late String _currentTitle;
  late String _currentDescription;
  String? _currentSelectedPriority;
  DateTime? _currentDeadline;
  final List<String> _currentAssignedTo = [];

  DateTime? _deadline;

  final List<String> _priority = [
    'High',
    'Medium',
    'Low',
  ];

  String? _selectedPriority;

  String? _selectedProject;

  List<String> _selectAssignedTo = [];

  List<String> employeesDeviceTokens = [];

  @override
  void initState() {
    _titleController.addListener(_onTextChanged);
    _descController.addListener(_onTextChanged);
    _getTaskById();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTextChanged);
    _descController.removeListener(_onTextChanged);
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  bool _hasChanges() {
    return (_titleController.text != _currentTitle) ||
        (_descController.text != _currentDescription) ||
        (_currentDeadline != _deadline) ||
        (_currentSelectedPriority != _selectedPriority) ||
        (_currentAssignedTo != _selectAssignedTo);
  }

  void _onTextChanged() {
    setState(() {});
  }

  Future<void> _getTaskById() async {
    try {
      final task = await ref.read(getTaskByIdProvider(widget.id).future);

      _currentTitle = task.title;
      _currentDescription = task.description;

      _currentDeadline = task.deadline;
      _currentSelectedPriority = task.priority;
      _selectAssignedTo = task.assignedTo;

      _titleController.text = task.title;
      _descController.text = task.description;

      final project =
          await ref.read(projectByIdProvider(task.projectId).future);
      _selectedProject = project.title;
    } catch (e) {
      e.toString;
    }
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
            Go.pop(context);
            showToast(
              content: 'Task Updated Successfully!',
              context: context,
              toastType: ToastType.success,
            );
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
        if (isLoading) const LoadingProgress(),
      ],
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Edit Task'),
      actions: [
        CustomButton(
          height: 40,
          width: 120,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            if (_hasChanges()) {
              await ref.read(taskViewModelProvider.notifier).editTask(
                    id: widget.id,
                    receiverId: _selectAssignedTo,
                    title: _titleController.text,
                    description: _descController.text,
                    deadline: _deadline,
                    priority: _selectedPriority!,
                    assignedTo: _selectAssignedTo,
                    body: 'You have new task on $_selectedProject',
                    deviceTokens: employeesDeviceTokens,
                  );
            } else {
              showToast(
                content: "No changes to update",
                context: context,
                toastType: ToastType.error,
              );
            }
          },
          child: Text(
            "Update",
            style: context.textTheme.labelLarge?.themeWhiteColor.bold,
          ),
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title *',
                  style: context.textTheme.bodySmall?.bold,
                ),
                10.kH,
                CustomTextField(
                  controller: _titleController,
                  validator: validateField,
                  hintText: "Title",
                  filled: true,
                  fillColor: context.colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.surface,
                      blurRadius: 5,
                    ),
                  ],
                ),
                24.kH,
                Text(
                  'Description *',
                  style: context.textTheme.bodySmall?.bold,
                ),
                10.kH,
                CustomTextField(
                  controller: _descController,
                  validator: validateField,
                  maxLines: 4,
                  hintText: "Description",
                  filled: true,
                  fillColor: context.colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.surface,
                      blurRadius: 5,
                    ),
                  ],
                ),
                24.kH,
                Text(
                  'Priority *',
                  style: context.textTheme.bodySmall?.bold,
                ),
                10.kH,
                CustomDropdown(
                  hintText: 'Select Priority',
                  initialItem: _currentSelectedPriority,
                  items: _priority,
                  closedHeaderPadding: const EdgeInsets.all(16),
                  expandedHeaderPadding: const EdgeInsets.all(16),
                  decoration: CustomDropdownDecoration(
                    closedFillColor: context.colorScheme.primary,
                    closedShadow: [
                      BoxShadow(
                        color: context.colorScheme.surface,
                        blurRadius: 5,
                      ),
                    ],
                    expandedFillColor: context.colorScheme.primary,
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
                  'Deadline *',
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
                        _currentDeadline = null;
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
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _currentDeadline != null
                              ? "${_currentDeadline!.day}/${_currentDeadline!.month}/${_currentDeadline!.year}"
                              : _deadline != null
                                  ? "${_deadline!.day}/${_deadline!.month}/${_deadline!.year}"
                                  : "Select Deadline",
                          style: context.textTheme.bodySmall,
                        ),
                        const Icon(Icons.calendar_today),
                      ],
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
                                  .where((employee) =>
                                      _selectAssignedTo.contains(employee.uid))
                                  .toList();
                              return SliderView(
                                items: selectedEmployees.length,
                                childBuilder: (context, index) {
                                  final employee = selectedEmployees[index];
                                  final isCurrentlyAssigned =
                                      _currentAssignedTo.contains(employee.uid);
                                  final isSelected =
                                      _selectAssignedTo.contains(employee.uid);
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
                                            ? (isCurrentlyAssigned ||
                                                    isSelected)
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
                                                      color: context.colorScheme
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
                                            : (isCurrentlyAssigned ||
                                                    isSelected)
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
                                                          employee.profileImage,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        opacity: 0.5,
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: context.colorScheme
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
                                                          .colorScheme.surface,
                                                    ),
                                                  ),
                                        5.kH,
                                        Text(
                                          "${employee.firstName} ${employee.lastName}",
                                          style: context.textTheme.labelLarge,
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
    );
  }
}
