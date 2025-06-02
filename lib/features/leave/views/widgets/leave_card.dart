import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/leave/model/leave_model.dart';

class LeaveCard extends ConsumerStatefulWidget {
  final LeaveModel leave;
  const LeaveCard({
    super.key,
    required this.leave,
  });

  @override
  ConsumerState<LeaveCard> createState() => _LeaveCardState();
}

class _LeaveCardState extends ConsumerState<LeaveCard> {
  final _dateFormatter = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    return FilledBox(
      width: context.screenWidth,
      color: context.colorScheme.primary,
      onTap: () {},
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
                    widget.leave.leaveType,
                    style: context.textTheme.bodyLarge?.w600,
                  ),
                  Text(
                    widget.leave.reason,
                    style: context.textTheme.labelLarge?.themeGreyTextColor,
                  ),
                  6.kH,
                  Text(
                    "From: ${_dateFormatter.format(widget.leave.startDate)}",
                    style: context.textTheme.labelLarge?.themeColor.w600,
                  ),
                  6.kH,
                  Text(
                    "To: ${_dateFormatter.format(widget.leave.endDate)}",
                    style: context.textTheme.labelLarge?.themeColor.w600,
                  ),
                ],
              ),
              if (widget.leave.status == 0)
                FilledBox(
                  height: 35,
                  width: 110,
                  innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
                  color: Palette.themecolor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  child: Center(
                    child: Text(
                      "Pending",
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: Palette.themecolor)
                          .w600,
                    ),
                  ),
                ),
              if (widget.leave.status == 1)
                FilledBox(
                  height: 35,
                  width: 110,
                  innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
                  color: Palette.themecolor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  child: Center(
                    child: Text(
                      "Approved",
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: Palette.themecolor)
                          .w600,
                    ),
                  ),
                ),
              if (widget.leave.status == 2)
                FilledBox(
                  height: 35,
                  width: 110,
                  innerBoxPadding: const EdgeInsets.symmetric(horizontal: 8),
                  color: themeredcolor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  child: Center(
                    child: Text(
                      "Rejected",
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: themeredcolor)
                          .w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
