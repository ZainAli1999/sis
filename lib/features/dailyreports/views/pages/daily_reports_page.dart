import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/custom_text_button.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/auth/models/auth_model.dart';
import 'package:sis/features/dailyreports/model/daily_report_model.dart';
import 'package:sis/features/dailyreports/viewmodel/daily_report_viewmodel.dart';

class DailyReportsPage extends ConsumerStatefulWidget {
  const DailyReportsPage({super.key});

  @override
  ConsumerState<DailyReportsPage> createState() => _DailyReportsPageState();
}

class _DailyReportsPageState extends ConsumerState<DailyReportsPage> {
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

  final _dateFormatter = DateFormat('dd MMMM, yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildPageHeader(),
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('My Daily Reports'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildMonthSelector(),
      ),
    );
  }

  Widget _buildPageBody() {
    final user = ref.watch(currentUserNotifierProvider)!;
    final dailyReportsAsync = ref.watch(dailyReportsProvider);
    return dailyReportsAsync.when(
      data: (dailyReportsList) {
        final filteredDailyReportsList = dailyReportsList.where((dailyReport) {
          return dailyReport.uid == user.uid &&
              dailyReport.createdAt.toDate().month == selectedMonth.month &&
              dailyReport.createdAt.toDate().year == selectedMonth.year;
        }).toList();

        if (filteredDailyReportsList.isEmpty) {
          return _buildNoDailyReportsView();
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
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
              rows: filteredDailyReportsList.map((dailyReport) {
                return _buildDataRow(
                  dailyReport,
                  user,
                );
              }).toList(),
            ),
          ),
        );
      },
      loading: () => const LoadingProgress(),
      error: (error, st) {
        return Center(
          child: Text(
            error.toString(),
          ),
        );
      },
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
              'Report Details',
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
              'Task Name',
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
              'Project Name',
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
              'Priority',
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
              'Note',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.bold,
            ),
          ),
        ),
      ),
    ];
  }

  DataRow _buildDataRow(DailyReportModel dailyReport, AuthModel user) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: CustomTextButton(
              buttonText: "View",
              buttonTextStyle: context.textTheme.bodySmall?.underline,
              onTap: () {
                Go.named(
                  context,
                  RouteName.dailyReportDetailsPage,
                  params: {
                    "id": dailyReport.id,
                  },
                );
              },
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              _dateFormatter.format(dailyReport.createdAt.toDate()),
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              Helpers.limitText(dailyReport.taskName, 15),
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              Helpers.limitText(dailyReport.projectName, 15),
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              dailyReport.priority,
              style: context.textTheme.bodySmall,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              dailyReport.note.isEmpty
                  ? "-"
                  : Helpers.limitText(dailyReport.note, 15),
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

  Widget _buildNoDailyReportsView() {
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
            "No Daily Reports Found",
            style: context.textTheme.bodyMedium?.bold,
          ),
        ),
      ],
    );
  }
}
