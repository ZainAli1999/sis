import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
import 'package:sis/features/meeting/viewmodel/meeting_viewmodel.dart';

class AddMeetingPage extends ConsumerStatefulWidget {
  const AddMeetingPage({super.key});

  @override
  ConsumerState<AddMeetingPage> createState() => _AddMeetingPageState();
}

class _AddMeetingPageState extends ConsumerState<AddMeetingPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  DateTime? _date;
  TimeOfDay? _time;

  final List<String> _selectMembers = [];

  List<String> employeesDeviceTokens = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hour;
    int minute = timeOfDay.minute;

    String period = hour >= 12 ? 'PM' : 'AM';

    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;

    String formattedMinute = minute < 10 ? '0$minute' : '$minute';

    return '$hour:$formattedMinute $period';
  }

  final _dateFormatter = DateFormat('dd MMM, yyyy');

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        meetingViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      meetingViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content: 'Meeting Created Successfully!',
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
      title: const Text('Add Meeting'),
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
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.surface,
                        blurRadius: 10,
                      ),
                    ],
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
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.surface,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  24.kH,
                  Text(
                    'Date',
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
                          _date = selectedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
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
                            _date != null
                                ? "${_date!.day}/${_date!.month}/${_date!.year}"
                                : "Select Date",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  24.kH,
                  Text(
                    'Time',
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  10.kH,
                  GestureDetector(
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        setState(() {
                          _time = selectedTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
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
                            _time != null
                                ? MaterialLocalizations.of(context)
                                    .formatTimeOfDay(_time!)
                                : "Select Time",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  24.kH,
                  Text(
                    'Members',
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
                                  selectMembers: _selectMembers,
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
                                        _selectMembers.contains(employee.uid))
                                    .toList();
                                return SliderView(
                                  items: selectedEmployees.length,
                                  childBuilder: (context, index) {
                                    final employee = selectedEmployees[index];
                                    final isSelected =
                                        _selectMembers.contains(employee.uid);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectMembers.remove(employee.uid);
                                            employeesDeviceTokens.removeWhere(
                                                (token) => employee.deviceTokens
                                                    .contains(token));
                                          } else {
                                            _selectMembers.add(employee.uid);
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
                                                      animChild:
                                                          const CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor:
                                                            themegreycolor,
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
                                baseColor: context.colorScheme.surface,
                                highlightColor: context.colorScheme.onSurface,
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

  Widget _buildPageFooter() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomButton(
        height: 55,
        buttoncolor: Palette.themecolor,
        borderRadius: BorderRadius.circular(30),
        onTap: () async {
          if (_formKey.currentState!.validate() &&
              _time != null &&
              _date != null &&
              _selectMembers.isNotEmpty) {
            await ref.read(meetingViewModelProvider.notifier).addMeeting(
                  time: _time!,
                  date: _date!,
                  title: _titleController.text,
                  desc: _descController.text,
                  members: _selectMembers,
                  receiverId: _selectMembers,
                  deviceTokens: employeesDeviceTokens,
                  body:
                      'Meeting Schedule on ${_dateFormatter.format(_date!)} at ${formatTimeOfDay(_time!)}',
                );
          } else if (_time == null) {
            showToast(
              content: 'Please Select Time',
              context: context,
              toastType: ToastType.error,
            );
          } else if (_date == null) {
            showToast(
              content: 'Please Select Date',
              context: context,
              toastType: ToastType.error,
            );
          } else if (_selectMembers.isEmpty) {
            showToast(
              content: 'Please Select Members',
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
