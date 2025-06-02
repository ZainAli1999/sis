import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/features/dailyreports/model/daily_report_model.dart';

class DailyReportCard extends ConsumerStatefulWidget {
  final DailyReportModel dailyReport;
  const DailyReportCard({
    super.key,
    required this.dailyReport,
  });

  @override
  ConsumerState<DailyReportCard> createState() => _DailyReportCardState();
}

class _DailyReportCardState extends ConsumerState<DailyReportCard> {
  final _dateFormatter = DateFormat('dd MMMM, yyyy');
  @override
  Widget build(BuildContext context) {
    return FilledBox(
      width: context.screenWidth,
      innerBoxPadding: const EdgeInsets.all(12),
      color: context.colorScheme.primary,
      onTap: () {
        Go.named(
          context,
          RouteName.projectDetailsPage,
        );
      },
      boxShadow: [
        BoxShadow(
          color: context.colorScheme.surface,
          blurRadius: 5,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dailyReport.projectName,
                    style: context.textTheme.bodyLarge?.w600,
                  ),
                  Text(
                    widget.dailyReport.taskName,
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                  ),
                  Text(
                    _dateFormatter
                        .format(widget.dailyReport.createdAt.toDate()),
                    style: context.textTheme.labelLarge?.themeColor.w600,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
