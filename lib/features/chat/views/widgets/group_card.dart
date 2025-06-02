import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/features/chat/model/group_model.dart';

class GroupCard extends ConsumerStatefulWidget {
  final GroupModel group;
  const GroupCard({
    super.key,
    required this.group,
  });

  @override
  ConsumerState<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends ConsumerState<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 60,
      horizontalTitleGap: 10,
      leading: CustomCachedNetworkImage(
        imageUrl: widget.group.groupPic,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: 25,
            backgroundImage: imageProvider,
          );
        },
        animChild: CircleAvatar(
          backgroundColor: context.colorScheme.surface,
          radius: 25,
        ),
      ),
      title: Text(
        widget.group.name,
        style: context.textTheme.bodySmall?.bold,
      ),
      subtitle: Text(
        widget.group.lastMessage,
        style: context.textTheme.labelLarge?.themeGreyTextColor,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('hh:mm a').format(widget.group.timeSent),
            style: context.textTheme.labelMedium?.w600,
          ),
          15.kH,
          // CircleAvatar(
          //   radius: 10,
          //   backgroundColor: Palette.themecolor,
          //   child: Text(
          //     "12",
          //     style: context.textTheme.labelMedium?.themeWhiteColor.bold,
          //   ),
          // ),
        ],
      ),
      onTap: () {
        Go.named(
          context,
          RouteName.messagePage,
          params: {
            "uid": widget.group.groupId,
            "isGroupChat": "true",
            "name": widget.group.name,
            "profilePic": widget.group.groupPic,
          },
        );
      },
    );
  }
}
