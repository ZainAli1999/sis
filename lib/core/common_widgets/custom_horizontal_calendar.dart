import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_calender_view.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';

class CustomHorizontalCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CustomHorizontalCalendar({
    super.key,
    required this.onDateSelected,
  });

  @override
  State<CustomHorizontalCalendar> createState() =>
      _CustomHorizontalCalendarState();
}

class _CustomHorizontalCalendarState extends State<CustomHorizontalCalendar> {
  DateTime _selectedDay = DateTime.now();
  final DateTime _focusedDay = DateTime.now();
  bool viewCalendar = false;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return viewCalendar
        ? FadeInDown(
            child: CustomCalendarView(
              onDateSelected: (selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                });
                widget.onDateSelected(_selectedDate);
              },
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSelectedDateDisplay(),
              16.kH,
              _buildHorizontalCalendar(),
            ],
          );
  }

  Widget _buildSelectedDateDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(_selectedDay),
                style: context.textTheme.bodyMedium?.bold,
              ),
              8.kH,
              Text(
                DateFormat.EEEE().format(_selectedDay),
                style: context.textTheme.titleMedium?.bold,
              ),
            ],
          ),
          CustomButton(
            height: 40,
            width: 140,
            buttoncolor: Palette.themecolor,
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              setState(() {
                viewCalendar = true;
              });
            },
            child: Text(
              "View Calendar",
              style: context.textTheme.labelLarge?.themeWhiteColor.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCalendar() {
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    final totalDays = lastDayOfMonth.day;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: List.generate(totalDays, (index) {
            DateTime day =
                DateTime(_focusedDay.year, _focusedDay.month, index + 1);
            bool isSelected = _selectedDay.day == day.day &&
                _selectedDay.month == day.month &&
                _selectedDay.year == day.year;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = day;
                });
                widget.onDateSelected(day);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 60,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Palette.themecolor
                      : context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    10.kH,
                    Text(
                      DateFormat.E().format(day),
                      style: context.textTheme.labelLarge
                          ?.copyWith(
                            color: isSelected
                                ? themewhitecolor
                                : themegreytextcolor,
                          )
                          .bold,
                    ),
                    5.kH,
                    Text(
                      '${day.day}',
                      style: context.textTheme.bodyLarge?.bold.copyWith(
                        color: isSelected
                            ? themewhitecolor
                            : context.colorScheme.secondary,
                      ),
                    ),
                    10.kH,
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
