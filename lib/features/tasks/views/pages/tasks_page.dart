import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_calender_view.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/tasks/viewmodel/task_viewmodel.dart';
import 'package:sis/features/tasks/views/widgets/task_card.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  bool viewCalendar = false;

  DateTime? _selectedDate;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Go.named(
              context,
              RouteName.addTaskPage,
            );
          },
          backgroundColor: Palette.themecolor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: themewhitecolor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: _buildPageHeader(),
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Tasks'),
      actions: [
        CustomButton(
          height: 40,
          width: 120,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, dialogState) {
                    return FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: AlertDialog.adaptive(
                        backgroundColor: context.colorScheme.primary,
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          height: context.screenHeight / 100 * 50,
                          width: context.screenWidth,
                          child: CustomCalendarView(
                            onDateSelected: (selectedDate) {
                              setState(() {
                                _selectedDate = selectedDate;
                              });
                            },
                          ),
                        ),
                        actions: [
                          CustomButton(
                            height: 50,
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Go.pop(context);
                            },
                            child: Text(
                              "Done",
                              style: context
                                  .textTheme.bodyMedium?.themeWhiteColor.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text(
            "Calendar",
            style: context.textTheme.labelLarge?.themeWhiteColor.bold,
          ),
        ),
        15.kW,
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 16,
              ),
              child: CustomTextField(
                controller: _searchController,
                hintText: "Search by title",
                enabledBorderColor: context.colorScheme.surface,
                focusedBorderColor: Palette.themecolor,
                isOutlinedInputBorder: true,
                outlineBorderRadius: 40,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 16,
                ),
                suffix: const Icon(
                  Icons.search,
                  size: 25,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            _buildTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    final tasks = ref.watch(fetchTasksProvider).value ?? [];
    final pendingTasksCount = tasks.where((task) => task.status == 0).length;
    final completedTasksCount = tasks.where((task) => task.status == 1).length;
    return TabBar(
      controller: _tabController,
      labelStyle: context.textTheme.labelLarge?.bold,
      unselectedLabelStyle: context.textTheme.labelLarge,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Palette.themecolor,
      dividerColor: context.colorScheme.surface,
      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pending',
              ),
              4.kW,
              CircleAvatar(
                radius: 12,
                child: Text(
                  pendingTasksCount.toString(),
                  style: context.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Completed',
              ),
              4.kW,
              CircleAvatar(
                radius: 12,
                child: Text(
                  completedTasksCount.toString(),
                  style: context.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageBody() {
    return _buildTabBarView();
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTasks(
          selectedDate: _selectedDate,
          status: 0,
        ),
        _buildTasks(
          selectedDate: _selectedDate,
          status: 1,
        ),
      ],
    );
  }

  Widget _buildTasks({
    DateTime? selectedDate,
    required int status,
  }) {
    return ref.watch(tasksByStatusProvider(status)).when(
          data: (tasks) {
            final filteredTasks = tasks.where((task) {
              DateTime deadline = task.deadline.toLocal();

              bool matchesSelectedDate = selectedDate == null
                  ? true
                  : deadline.year == selectedDate.year &&
                      deadline.month == selectedDate.month &&
                      deadline.day == selectedDate.day;

              bool matchesSearchQuery = [
                task.title,
                task.priority,
              ].any(
                (element) =>
                    element.toLowerCase().contains(searchQuery.toLowerCase()),
              );
              return matchesSelectedDate && matchesSearchQuery;
            }).toList();

            if (filteredTasks.isEmpty) {
              return _buildNoTasksView();
            }
            return SliderView(
              items: filteredTasks.length,
              isListView: true,
              spacer: 10.kH,
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.vertical,
              childBuilder: (context, index) {
                return TaskCard(
                  task: filteredTasks[index],
                );
              },
            );
          },
          loading: () => _buildShimmerLoading(),
          error: (error, st) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
        );
  }

  Widget _buildShimmerLoading() {
    return SliderView(
      scrollDirection: Axis.vertical,
      isListView: true,
      spacer: 10.kH,
      items: 10,
      childBuilder: (context, index) {
        return Padding(
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
        );
      },
    );
  }

  Widget _buildNoTasksView() {
    return SizedBox(
      height: context.screenHeight / 100 * 60,
      child: Center(
          child: Column(
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
              "No Tasks Found",
              style: context.textTheme.bodyMedium?.bold,
            ),
          ),
        ],
      )),
    );
  }
}
