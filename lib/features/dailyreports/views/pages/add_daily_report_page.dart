import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/dailyreports/viewmodel/daily_report_viewmodel.dart';

class AddDailyReportPage extends ConsumerStatefulWidget {
  const AddDailyReportPage({super.key});

  @override
  ConsumerState<AddDailyReportPage> createState() => _AddDailyReportPageState();
}

class _AddDailyReportPageState extends ConsumerState<AddDailyReportPage> {
  final _taskNameController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _addNoteController = TextEditingController();

  // DateTime? _dueDate;

  final List<String> _priority = [
    'High',
    'Medium',
    'Low',
  ];

  String? _selectedPriority;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _taskNameController.dispose();
    _projectNameController.dispose();
    _addNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(dailyViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      dailyViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Daily Report Added Successfully!',
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
          bottomNavigationBar: _buildPageFooter(),
        ),
        if (isLoading) const LoadingProgress(),
      ],
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Add Daily Report'),
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
                    'Task Name',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomTextField(
                    controller: _taskNameController,
                    validator: validateField,
                    hintText: "Task Name",
                    isOutlinedInputBorder: true,
                    enabledBorderColor: context.colorScheme.surface,
                    focusedBorderColor: Palette.themecolor,
                    padding: const EdgeInsets.all(16),
                  ),
                  24.kH,
                  Text(
                    'Project Name',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomTextField(
                    controller: _projectNameController,
                    validator: validateField,
                    hintText: "Project Name",
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
                    'Add Note',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomTextField(
                    controller: _addNoteController,
                    maxLines: 4,
                    hintText: "Add Note",
                    isOutlinedInputBorder: true,
                    enabledBorderColor: context.colorScheme.surface,
                    focusedBorderColor: Palette.themecolor,
                    padding: const EdgeInsets.all(16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageFooter() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomButton(
        height: 55,
        width: 140,
        buttoncolor: Palette.themecolor,
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          if (_formKey.currentState!.validate() && _selectedPriority != null) {
            await ref.read(dailyViewModelProvider.notifier).addDailyReport(
                  taskName: _taskNameController.text,
                  projectName: _projectNameController.text,
                  note: _addNoteController.text,
                  priority: _selectedPriority!,
                );
          } else if (_selectedPriority == null) {
            showToast(
              content: 'Please Select Priority',
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
          "Add",
          style: context.textTheme.bodyMedium?.themeWhiteColor.bold,
        ),
      ),
    );
  }
}
