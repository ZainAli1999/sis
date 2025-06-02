import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/dailyreports/model/daily_report_model.dart';
import 'package:sis/features/dailyreports/viewmodel/daily_report_viewmodel.dart';

class DailyReportDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const DailyReportDetailsPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<DailyReportDetailsPage> createState() =>
      _DailyReportDetailsPageState();
}

class _DailyReportDetailsPageState
    extends ConsumerState<DailyReportDetailsPage> {
  final _dateFormatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return ref.watch(dailyReportByIdProvider(widget.id)).when(
          data: (dailyReport) => Scaffold(
            appBar: _buildPageHeader(dailyReport),
            body: _buildPageBody(dailyReport),
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

  PreferredSizeWidget _buildPageHeader(DailyReportModel dailyReport) {
    return AppBar(
      title: const Text('Daily Report Details'),
      actions: [
        FilledBox(
          height: 35,
          width: 130,
          innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
          color: Palette.themecolor.withAlpha(38),
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              _dateFormatter.format(dailyReport.createdAt.toDate()),
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

  Widget _buildPageBody(DailyReportModel dailyReport) {
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
                  dailyReport.projectName,
                  style: context.textTheme.bodyMedium?.bold,
                ),
                6.kH,
                Text.rich(
                  TextSpan(
                    text: "Task Name:  ",
                    style: context.textTheme.bodySmall?.themeGreyTextColor,
                    children: [
                      TextSpan(
                        text: dailyReport.taskName,
                        style: context.textTheme.bodySmall?.themeGreyTextColor,
                      ),
                    ],
                  ),
                ),
                6.kH,
                if (dailyReport.note.isNotEmpty)
                  Text.rich(
                    TextSpan(
                      text: "Note:  ",
                      style: context.textTheme.bodySmall?.themeGreyTextColor,
                      children: [
                        TextSpan(
                          text: dailyReport.note,
                          style:
                              context.textTheme.bodySmall?.themeGreyTextColor,
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
                          color: dailyReport.priority == 'Low'
                              ? themeyellowcolor
                              : dailyReport.priority == 'Medium'
                                  ? themegreencolor
                                  : themeredcolor,
                        )
                        .bold,
                    children: [
                      TextSpan(
                        text: dailyReport.priority,
                        style: context.textTheme.bodySmall
                            ?.copyWith(
                              color: dailyReport.priority == 'Low'
                                  ? themeyellowcolor
                                  : dailyReport.priority == 'Medium'
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
        ],
      ),
    );
  }

  // Widget _buildShimmerLoading() {
  //   return Container(
  //     height: 60,
  //     width: context.screenWidth,
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: context.colorScheme.surface,
  //     ),
  //     child: Shimmer.fromColors(
  //       baseColor: themelightgreycolor,
  //       highlightColor: themegreycolor,
  //       child: Container(
  //         height: 20,
  //         width: 110,
  //         decoration: BoxDecoration(
  //           color: themegreycolor,
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
