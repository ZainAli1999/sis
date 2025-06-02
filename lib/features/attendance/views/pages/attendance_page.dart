import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/confirmation_dialog.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/attendance/model/attendance_model.dart';
import 'package:sis/features/attendance/viewmodel/attendance_viewmodel.dart';
import 'package:sis/features/auth/models/auth_model.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  DateTime? _date;
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hour;
    int minute = timeOfDay.minute;

    String period = hour >= 12 ? 'PM' : 'AM';

    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;

    String formattedMinute = minute < 10 ? '0$minute' : '$minute';

    return '$hour:$formattedMinute $period';
  }

  final _dateFormatter = DateFormat('dd MMMM, yyyy');
  Duration calculateTimeDifference({
    TimeOfDay? checkInTime,
    TimeOfDay? timeOfDay,
  }) {
    if (checkInTime == null || timeOfDay == null) {
      return Duration.zero;
    }

    int checkInMinutes = checkInTime.hour * 60 + checkInTime.minute;
    int startMinutes = timeOfDay.hour * 60 + timeOfDay.minute;

    if (checkInMinutes > startMinutes) {
      int differenceInMinutes = checkInMinutes - startMinutes;
      return Duration(minutes: differenceInMinutes);
    } else {
      return Duration.zero;
    }
  }

  Duration calculateLateTimeDifference({
    TimeOfDay? checkInTime,
    TimeOfDay? timeOfDay,
  }) {
    if (checkInTime == null || timeOfDay == null) {
      return Duration.zero;
    }

    int checkInMinutes = checkInTime.hour * 60 + checkInTime.minute;
    int startMinutes = timeOfDay.hour * 60 + timeOfDay.minute;

    if (checkInMinutes > startMinutes) {
      int differenceInMinutes = checkInMinutes - startMinutes;
      return Duration(minutes: differenceInMinutes);
    } else {
      return Duration.zero;
    }
  }

  String formatWorkingHours(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    return '${hours}h ${minutes}m';
  }

  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Attendance"),
        actions: [
          CustomButton(
            height: 35,
            width: 120,
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, dialogState) {
                    return FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: AlertDialog(
                        backgroundColor: context.colorScheme.primary,
                        scrollable: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Date",
                              style: context.textTheme.bodyLarge?.bold,
                            ),
                            CustomIconButton(
                              onTap: () {
                                Go.pop(context);
                              },
                              child: const Icon(
                                Icons.cancel,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        content: SizedBox(
                          width: context.screenWidth,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (selectedDate != null) {
                                    dialogState(() {
                                      _date = selectedDate;
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _date != null
                                            ? "${_date!.day}/${_date!.month}/${_date!.year}"
                                            : "Select Date",
                                        style: context.textTheme.bodySmall,
                                      ),
                                      const Icon(Icons.calendar_today),
                                    ],
                                  ),
                                ),
                              ),
                              20.kH,
                              CustomButton(
                                height: 50,
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  confirmationDialog(
                                    context: context,
                                    title:
                                        "Are you sure you want to mark absent",
                                    onTapConfirm: () async {
                                      if (_date != null) {
                                        await ref
                                            .read(attendanceViewModelProvider
                                                .notifier)
                                            .markAbsent(
                                              date: _date!,
                                            );
                                      } else {
                                        showToast(
                                          content: "Please Select Date",
                                          context: context,
                                          toastType: ToastType.error,
                                        );
                                      }
                                    },
                                  );
                                },
                                child: Text(
                                  "Mark Absent",
                                  style: context.textTheme.bodySmall
                                      ?.themeWhiteColor.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Text(
              "Mark Absent",
              style: context.textTheme.labelLarge?.themeWhiteColor.w600,
            ),
          ),
          15.kW,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildMonthSelector(),
        ),
      ),
      body: _buildPageBody(),
    );
  }

  Widget _buildPageBody() {
    final attendanceAsync = ref.watch(fetchAttendanceProvider);
    final user = ref.watch(currentUserNotifierProvider)!;

    return attendanceAsync.when(
      data: (attendanceList) {
        double totalSalary = 0;
        int lateCount = 0;
        int absentCount = 0;
        double perDaySalary = 0;
        double deductionAmount = 0;

        final filteredAttendanceList = attendanceList.where((attendance) {
          return attendance.uid == user.uid &&
              attendance.date.month == selectedMonth.month &&
              attendance.date.year == selectedMonth.year;
        }).toList();

        if (filteredAttendanceList.isNotEmpty) {
          for (var attendance in filteredAttendanceList) {
            final lateTimeDifference = calculateLateTimeDifference(
              checkInTime: attendance.checkInTime,
              timeOfDay: user.graceTime,
            );

            if (lateTimeDifference > Duration.zero) {
              lateCount++;
            }

            if (attendance.status == 3) {
              absentCount++;
            }
          }

          int leaveCount = (lateCount / 3).floor();
          leaveCount += absentCount;

          perDaySalary = user.salary / 30;

          deductionAmount = leaveCount * perDaySalary;

          double salaryAfterLeave = user.salary - deductionAmount;

          totalSalary = salaryAfterLeave;

          log("Total Salary for Current User: $totalSalary");
          log("Late Count: $lateCount, Absent Count: $absentCount");
          log("ID: $absentCount");
        }
        if (filteredAttendanceList.isEmpty) {
          return _buildNoAttendanceView();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder(
                    bottom: BorderSide(
                      color: context.colorScheme.surface,
                    ),
                  ),
                  headingTextStyle: context.textTheme.bodyMedium,
                  headingRowColor: WidgetStatePropertyAll(
                    context.colorScheme.surface,
                  ),
                  columns: _buildDataColumns(),
                  rows: filteredAttendanceList.map((attendance) {
                    return _buildDataRow(
                      attendance,
                      user,
                    );
                  }).toList(),
                ),
              ),
              10.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Number of Lates: $lateCount',
                      style: context.textTheme.bodySmall,
                    ),
                    2.kH,
                    Text(
                      'Number of Absences: $absentCount',
                      style: context.textTheme.bodySmall,
                    ),
                    2.kH,
                    Text(
                      'Salary Per Day: Rs. ${perDaySalary.toStringAsFixed(2)}',
                      style: context.textTheme.bodySmall,
                    ),
                    2.kH,
                    Text(
                      'Deducted Salary: Rs. ${deductionAmount.toStringAsFixed(2)}',
                      style: context.textTheme.bodySmall,
                    ),
                    5.kH,
                    Text(
                      'Total Salary After Deduction: Rs. ${totalSalary.toStringAsFixed(2)}',
                      style: context.textTheme.bodyMedium?.bold,
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
          child: Text(error.toString()),
        );
      },
      loading: () => const LoadingProgress(),
    );
  }

  Widget _buildMonthSelector() {
    return CustomDropdown.search(
      hintText: 'Select Month',
      items: months,
      initialItem: months[selectedMonth.month - 1],
      closedHeaderPadding: const EdgeInsets.all(15),
      expandedHeaderPadding: const EdgeInsets.all(15),
      decoration: CustomDropdownDecoration(
        closedFillColor: context.colorScheme.primary,
        expandedFillColor: context.colorScheme.primary,
        headerStyle: context.textTheme.bodySmall,
        hintStyle: context.textTheme.bodySmall,
        listItemStyle: context.textTheme.bodySmall,
        searchFieldDecoration: SearchFieldDecoration(
          fillColor: context.colorScheme.primary,
          contentPadding: EdgeInsets.zero,
          textStyle: context.textTheme.bodySmall,
        ),
        closedBorderRadius: BorderRadius.zero,
        expandedBorderRadius: BorderRadius.zero,
        closedBorder: Border.all(color: context.colorScheme.surface),
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
        if (value != null) {
          final selectedIndex = months.indexOf(value);
          if (selectedIndex != -1) {
            final selectedMonthDateTime =
                DateTime(DateTime.now().year, selectedIndex + 1);
            setState(() {
              selectedMonth = selectedMonthDateTime;
            });
            log('Selected month DateTime: $selectedMonthDateTime');
          }
        }
      },
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Date',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Check In',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Status',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Check Out',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Late',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Working Hours',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'ID',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
    ];
  }

  DataRow _buildDataRow(AttendanceModel attendance, AuthModel user) {
    // final startTimeDifference =
    //     calculateTimeDifference(
    //   checkInTime: attendance.checkInTime,
    //   timeOfDay: employee.startTime,
    // );

    final graceTimeDifference = calculateTimeDifference(
      checkInTime: attendance.checkInTime,
      timeOfDay: user.graceTime,
    );

    final formattedLate = graceTimeDifference == Duration.zero
        ? '-'
        : Helpers.formatTime(graceTimeDifference);

    final DateTime checkInDateTime = DateTime(
      attendance.date.year,
      attendance.date.month,
      attendance.date.day,
      attendance.checkInTime.hour,
      attendance.checkInTime.minute,
    );

    final DateTime? checkOutDateTime = attendance.checkOutTime != null
        ? DateTime(
            attendance.date.year,
            attendance.date.month,
            attendance.date.day,
            attendance.checkOutTime!.hour,
            attendance.checkOutTime!.minute,
          )
        : null;

    final workingHours = checkOutDateTime != null
        ? checkOutDateTime.difference(checkInDateTime)
        : Duration.zero;

    final formattedWorkingHours =
        checkOutDateTime != null ? formatWorkingHours(workingHours) : 'N/A';
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              _dateFormatter.format(attendance.date),
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              attendance.status == 3
                  ? "-"
                  : formatTimeOfDay(attendance.checkInTime),
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              attendance.status == 1
                  ? 'Present'
                  : attendance.status == 2
                      ? 'Checked-Out'
                      : attendance.status == 3
                          ? 'Absent'
                          : 'Unknown',
              style: context.textTheme.bodySmall
                  ?.copyWith(
                    color: attendance.status == 1
                        ? Palette.themecolor
                        : themeredcolor,
                  )
                  .bold,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              attendance.status == 3
                  ? "-"
                  : attendance.checkOutTime != null
                      ? formatTimeOfDay(attendance.checkOutTime!)
                      : 'Not yet checked out',
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              formattedLate,
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              attendance.status == 3 ? "-" : formattedWorkingHours,
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              attendance.id,
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }

  // DataRow _buildLoadingRow() {
  //   return DataRow(
  //     cells: List.generate(
  //       6,
  //       (_) => DataCell(
  //         Center(
  //           child: Text("Loading...", style: context.textTheme.bodySmall),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // DataRow _buildErrorRow(String error) {
  //   return DataRow(
  //     cells: List.generate(
  //       6,
  //       (_) => DataCell(
  //         Text(error),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNoAttendanceView() {
    return Column(
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
            "No Attendance Found",
            style: context.textTheme.bodyMedium?.bold,
          ),
        ),
      ],
    );
  }
}
