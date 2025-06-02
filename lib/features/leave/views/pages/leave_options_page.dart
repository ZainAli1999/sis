import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';

class LeaveOptionsPage extends StatefulWidget {
  const LeaveOptionsPage({super.key});

  @override
  State<LeaveOptionsPage> createState() => _LeaveOptionsPageState();
}

class _LeaveOptionsPageState extends State<LeaveOptionsPage> {
  final List<String> _employeeManagementModel = [
    'Leave Request',
    'All Leaves',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildPageHeader(),
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Leave Options",
      ),
    );
  }

  Widget _buildPageBody() {
    return SliderView(
      isListView: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(20),
      items: _employeeManagementModel.length,
      spacer: 15.kH,
      childBuilder: (context, index) {
        return FilledBox(
          onTap: () {
            if (index == 0) {
              Go.named(
                context,
                RouteName.addLeavePage,
              );
            } else if (index == 1) {
              Go.named(
                context,
                RouteName.leavesPage,
              );
            }
          },
          color: context.colorScheme.primary,
          innerBoxPadding: const EdgeInsets.all(12),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.surface,
              blurRadius: 5,
            ),
          ],
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            minVerticalPadding: 0,
            title: Text(
              _employeeManagementModel[index],
              style: context.textTheme.bodyMedium?.w600,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
