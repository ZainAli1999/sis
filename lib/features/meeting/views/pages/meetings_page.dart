import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_horizontal_calendar.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/meeting/viewmodel/meeting_viewmodel.dart';
import 'package:sis/features/meeting/views/widgets/meeting_card.dart';

class MeetingsPage extends ConsumerStatefulWidget {
  const MeetingsPage({super.key});

  @override
  ConsumerState<MeetingsPage> createState() => _MeetingsPageState();
}

class _MeetingsPageState extends ConsumerState<MeetingsPage> {
  DateTime _selectedDate = DateTime.now();

  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildPageHeader(),
      body: _buildPageBody(selectedDate: _selectedDate),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Meetings'),
      actions: [
        CustomButton(
          height: 40,
          width: 140,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Go.named(
              context,
              RouteName.addMeetingPage,
            );
          },
          child: Text(
            "Add Meeting",
            style: context.textTheme.labelLarge?.themeWhiteColor.bold,
          ),
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody({
    DateTime? selectedDate,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHorizontalCalendar(
            onDateSelected: (selectedDate) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meetings list',
                  style: context.textTheme.bodyMedium?.bold,
                ),
                ref.watch(meetingsProvider).when(
                      data: (meetings) {
                        final filteredMeetings = meetings.where((meeting) {
                          DateTime deadline = meeting.date.toLocal();

                          bool matchesSelectedDate = selectedDate == null
                              ? true
                              : deadline.year == selectedDate.year &&
                                  deadline.month == selectedDate.month &&
                                  deadline.day == selectedDate.day;

                          bool matchesSearchQuery = [
                            meeting.title,
                          ].any(
                            (element) => element
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()),
                          );
                          return matchesSelectedDate && matchesSearchQuery;
                        }).toList();
                        return filteredMeetings.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          context.colorScheme.surface,
                                      radius: 80,
                                      child: const Icon(
                                        Icons.calendar_today,
                                        size: 80,
                                        color: Palette.themecolor,
                                      ),
                                    ),
                                  ),
                                  20.kH,
                                  Center(
                                    child: Text(
                                      "No Meetings for today",
                                      style: context.textTheme.bodyMedium?.bold,
                                    ),
                                  ),
                                ],
                              )
                            : SliderView(
                                items: filteredMeetings.length,
                                scrollDirection: Axis.vertical,
                                childBuilder: (context, index) {
                                  return MeetingCard(
                                    meeting: filteredMeetings[index],
                                  );
                                },
                              );
                      },
                      loading: () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 250,
                          width: context.screenWidth / 100 * 80,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Shimmer.fromColors(
            baseColor: context.colorScheme.surfaceDim,
            highlightColor: context.colorScheme.shadow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                10.kH,
                                Container(
                                  height: 15,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                6.kH,
                                Container(
                                  height: 15,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                6.kH,
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: context.colorScheme.surface,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      error: (error, st) {
                        return Center(
                          child: Text(
                            error.toString(),
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
