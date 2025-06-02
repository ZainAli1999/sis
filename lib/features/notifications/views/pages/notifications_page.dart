import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/notifications/viewmodel/notification_viewmodel.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildPageHeader(),
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text('Notifications'),
    );
  }

  Widget _buildPageBody() {
    return ref.watch(fetchMyNotificationsProvider).when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return _buildNoNotificationsView();
            }
            return SliderView(
              spacer: 10.kH,
              isListView: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items: notifications.length,
              childBuilder: (context, index) {
                final notification = notifications[index];

                return notificationTile(
                  title: notification.title,
                  date: Helpers.timeAgo(
                    notification.createdAt.millisecondsSinceEpoch,
                  ),
                  message: notification.body,
                  showDot: notification.isSeen == false ? true : false,
                );
              },
            );
          },
          error: (error, st) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
          loading: () => const LoadingProgress(),
        );
  }

  Widget notificationTile({
    required String title,
    required String date,
    required String message,
    required bool showDot,
  }) {
    return FilledBox(
      color: context.colorScheme.surface,
      innerBoxPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Palette.themecolor,
            child: Text(
              'V',
              style: context.textTheme.bodyMedium?.themeWhiteColor,
            ),
          ),
          10.kW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.labelLarge?.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                5.kH,
                Text(
                  message,
                  style: context.textTheme.labelLarge?.w400,
                ),
              ],
            ),
          ),
          if (showDot)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: context.textTheme.labelMedium?.themeGreyTextColor,
                ),
                const Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.blue,
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNoNotificationsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: CircleAvatar(
            backgroundColor: themelightgreycolor,
            radius: 80,
            child: Icon(
              Icons.notifications,
              size: 100,
              color: Palette.themecolor,
            ),
          ),
        ),
        20.kH,
        Center(
          child: Text(
            "No Notifications Found",
            style: context.textTheme.bodyMedium?.bold,
          ),
        ),
      ],
    );
  }
}
