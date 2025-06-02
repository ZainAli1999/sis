import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';

class CustomCalendarView extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const CustomCalendarView({
    super.key,
    required this.onDateSelected,
  });

  @override
  State<CustomCalendarView> createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          16.kH,
          _buildWeekDays(),
          8.kH,
          _buildDaysGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(
                _focusedDay.year,
                _focusedDay.month - 1,
                1,
              );
            });
          },
        ),
        Text(
          DateFormat.yMMMM().format(_focusedDay),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(
                _focusedDay.year,
                _focusedDay.month + 1,
                1,
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays() {
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: weekDays
          .map((day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDaysGrid() {
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    final totalDays = lastDayOfMonth.day;

    int startOffset = firstDayOfMonth.weekday - 1;

    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: totalDays + startOffset,
      itemBuilder: (context, index) {
        if (index < startOffset) {
          return const SizedBox();
        }

        int day = index - startOffset + 1;

        bool isSelected = _selectedDay != null &&
            _selectedDay!.day == day &&
            _selectedDay!.month == _focusedDay.month &&
            _selectedDay!.year == _focusedDay.year;

        bool isToday = day == DateTime.now().day &&
            _focusedDay.month == DateTime.now().month &&
            _focusedDay.year == DateTime.now().year;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDay = DateTime(_focusedDay.year, _focusedDay.month, day);
            });
            widget.onDateSelected(_selectedDay!);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Palette.themecolor
                  : isToday
                      ? Palette.themecolor.withAlpha(50)
                      : context.colorScheme.surface,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : isToday
                        ? Palette.themecolor
                        : context.colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );
  }
}
