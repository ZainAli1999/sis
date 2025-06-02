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
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/leave/viewmodel/leave_viewmodel.dart';

class AddLeavePage extends ConsumerStatefulWidget {
  const AddLeavePage({super.key});

  @override
  ConsumerState<AddLeavePage> createState() => _AddLeavePageState();
}

class _AddLeavePageState extends ConsumerState<AddLeavePage> {
  final _reasonController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _leaveType = [
    'Sick Leave',
    'Casual Leave',
    'Maternity Leave',
  ];

  String? _selectedLeaveType;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(leaveViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      leaveViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              context: context,
              content: 'Leave Request Sent Successfully!',
              toastType: ToastType.success,
            );
            Go.pop(context);
          },
          error: (error, st) {
            showToast(
              context: context,
              content: error.toString(),
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
      title: const Text('Leave Request'),
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
                    'Leave Type',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomDropdown(
                    hintText: 'Select Leave Type',
                    items: _leaveType,
                    closedHeaderPadding: const EdgeInsets.all(15),
                    expandedHeaderPadding: const EdgeInsets.all(15),
                    decoration: CustomDropdownDecoration(
                      closedFillColor: context.colorScheme.primary,
                      expandedFillColor: context.colorScheme.primary,
                      headerStyle: context.textTheme.bodySmall,
                      hintStyle: context.textTheme.bodySmall,
                      listItemStyle: context.textTheme.bodySmall,
                      closedBorder:
                          Border.all(color: context.colorScheme.surface),
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
                      _selectedLeaveType = value;
                    },
                  ),
                  24.kH,
                  Text(
                    'Reason',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  CustomTextField(
                    controller: _reasonController,
                    validator: validateField,
                    hintText: "Reason",
                    maxLines: 4,
                    isOutlinedInputBorder: true,
                    enabledBorderColor: context.colorScheme.surface,
                    focusedBorderColor: Palette.themecolor,
                  ),
                  24.kH,
                  Text(
                    'Start Date',
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
                          _startDate = selectedDate;
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
                            _startDate != null
                                ? "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}"
                                : "Select Start Date",
                            style: context.textTheme.bodySmall,
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  24.kH,
                  Text(
                    'End Date',
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
                          _endDate = selectedDate;
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
                            _endDate != null
                                ? "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"
                                : "Select End Date",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
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

  Widget _buildPageFooter() {
    final user = ref.read(currentUserNotifierProvider)!;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomButton(
        height: 55,
        buttoncolor: Palette.themecolor,
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          if (_formKey.currentState!.validate() &&
              _startDate != null &&
              _endDate != null &&
              _selectedLeaveType != null) {
            await ref.read(leaveViewModelProvider.notifier).addLeave(
              startDate: _startDate!,
              endDate: _endDate!,
              leaveType: _selectedLeaveType!,
              reason: _reasonController.text,
              title: 'Leave Request by ${user.firstName} ${user.lastName}',
              body: 'Request for $_selectedLeaveType',
              deviceTokens: [
                'cSutlrskQ6KmAUMUZUYaY8:APA91bElra37nFA5o6mxI5lxkuxcoUVLGgAeie4yFDGxcP0Byp6deDjNn7w-u9VNtWczBtlyR7e7V2MsEJgPK6CO7ALTr7x9n6auBI3x4Gt-P0-53Da59EE',
              ],
            );
          } else if (_startDate == null) {
            showToast(
              context: context,
              content: 'Please Select Start Date',
              toastType: ToastType.error,
            );
          } else if (_endDate == null) {
            showToast(
              context: context,
              content: 'Please Select End Date',
              toastType: ToastType.error,
            );
          } else if (_selectedLeaveType == null) {
            showToast(
              context: context,
              content: 'Please Select Leave type',
              toastType: ToastType.error,
            );
          } else {
            showToast(
              context: context,
              content: 'Please Enter All Required Fields',
              toastType: ToastType.error,
            );
          }
        },
        child: Text(
          "Request",
          style: context.textTheme.bodyMedium?.themeWhiteColor.bold,
        ),
      ),
    );
  }
}
