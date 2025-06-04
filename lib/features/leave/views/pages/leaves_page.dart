import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/leave/viewmodel/leave_viewmodel.dart';
import 'package:sis/features/leave/views/widgets/leave_card.dart';

class LeavesPage extends ConsumerStatefulWidget {
  const LeavesPage({super.key});

  @override
  ConsumerState<LeavesPage> createState() => _LeavesPageState();
}

class _LeavesPageState extends ConsumerState<LeavesPage> {
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
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Leaves'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 16,
          ),
          child: CustomTextField(
            controller: _searchController,
            hintText: "Search",
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
      ),
    );
  }

  Widget _buildPageBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ref.watch(fetchLeavesProvider).when(
                    data: (leaves) {
                      if (leaves.isEmpty) {
                        return SizedBox(
                          height: context.screenHeight - 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: context.colorScheme.surface,
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
                                  "No Leave requests found",
                                  style: context.textTheme.bodyMedium?.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      final query = searchQuery.toLowerCase();

                      final filteredLeaves = leaves.where((leave) {
                        return leave.leaveType.toLowerCase().contains(query);
                      }).toList();

                      return SliderView(
                        items: filteredLeaves.length,
                        scrollDirection: Axis.vertical,
                        childBuilder: (context, index) {
                          return LeaveCard(
                            leave: filteredLeaves[index],
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
        ],
      ),
    );
  }
}
