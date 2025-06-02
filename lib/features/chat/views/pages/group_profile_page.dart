import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/confirmation_dialog.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/models/auth_model.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/chat/model/group_model.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:sis/features/chat/views/widgets/add_new_members_dialog.dart';

class GroupProfilePage extends ConsumerStatefulWidget {
  final String id;
  const GroupProfilePage({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GroupProfilePageState();
}

class _GroupProfilePageState extends ConsumerState<GroupProfilePage> {
  final _dateTimeFormatter = DateFormat('dd/MM/yyyy, hh:mm a');

  @override
  Widget build(BuildContext context) {
    return ref.watch(groupByIdProvider(widget.id)).when(
          data: (group) => Scaffold(body: _buildPageBody(group)),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Scaffold(body: LoadingProgress()),
        );
  }

  Widget _buildPageBody(GroupModel group) {
    final currentUser = ref.watch(currentUserNotifierProvider)!;

    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(group),
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildGroupHeader(group),
              _buildGroupMeta(group, currentUser),
              25.kH,
              _buildAddMembersTile(group, currentUser),
              20.kH,
              _buildMembersList(group, currentUser),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(GroupModel group) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final scrolled = constraints.scrollOffset > 150;
        return SliverAppBar(
          pinned: true,
          elevation: 0,
          centerTitle: true,
          title: scrolled ? _buildCompactTitle(group) : null,
          leading: CustomIconButton(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactTitle(GroupModel group) {
    return ListTile(
      minTileHeight: 50,
      horizontalTitleGap: 10,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      leading: CustomCachedNetworkImage(
        imageUrl: group.groupPic,
        imageBuilder: (_, image) =>
            CircleAvatar(radius: 20, backgroundImage: image),
        animChild: CircleAvatar(
          radius: 20,
          backgroundColor: context.colorScheme.surface,
        ),
      ),
      title: Text(group.name, style: context.textTheme.bodySmall?.bold),
    );
  }

  Widget _buildGroupHeader(GroupModel group) {
    return Column(
      children: [
        CustomCachedNetworkImage(
          imageUrl: group.groupPic,
          imageBuilder: (_, image) =>
              CircleAvatar(radius: 60, backgroundImage: image),
          animChild: CircleAvatar(
            radius: 60,
            backgroundColor: context.colorScheme.surface,
          ),
        ),
        15.kH,
        Text(group.name, style: context.textTheme.bodyMedium?.bold),
        Text(
          "Group • ${group.membersUid.length} members",
          style: context.textTheme.labelLarge?.themeGreyTextColor,
        ),
      ],
    );
  }

  Widget _buildGroupMeta(GroupModel group, AuthModel currentUser) {
    return ref.watch(getUserByIdProvider(group.senderId)).when(
          data: (user) {
            final creatorName = currentUser.uid == group.senderId
                ? "You"
                : "${user.firstName} ${user.lastName}";
            final createdAt =
                _dateTimeFormatter.format(group.createdAt.toDate());

            return Text(
              "Created by $creatorName, $createdAt",
              style: context.textTheme.labelLarge?.themeGreyTextColor,
            );
          },
          loading: () => Text(
            "Loading...",
            style: context.textTheme.labelLarge?.themeGreyTextColor
                .copyWith(fontStyle: FontStyle.italic),
          ),
          error: (e, _) => Text(e.toString()),
        );
  }

  Widget _buildAddMembersTile(GroupModel group, dynamic currentUser) {
    return ListTile(
      minTileHeight: 50,
      horizontalTitleGap: 10,
      minLeadingWidth: 0,
      leading: const CircleAvatar(radius: 25, child: Icon(Icons.person_add)),
      title: Text("Add members", style: context.textTheme.bodySmall?.w600),
      onTap: () {
        if (group.senderId == currentUser.uid) {
          showDialog(
            context: context,
            builder: (_) => AddNewMembersDialog(
              groupId: group.groupId,
              membersUid: group.membersUid,
            ),
          );
        }
      },
    );
  }

  Widget _buildMembersList(GroupModel group, dynamic currentUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Members", style: context.textTheme.labelLarge?.w600),
        ),
        10.kH,
        SliderView(
          scrollDirection: Axis.vertical,
          isListView: true,
          spacer: 10.kH,
          padding: EdgeInsets.zero,
          items: group.membersUid.length,
          childBuilder: (context, index) {
            final memberId = group.membersUid[index];

            return ref.watch(getUserByIdProvider(memberId)).when(
                  data: (user) => ListTile(
                    minTileHeight: 50,
                    horizontalTitleGap: 10,
                    minLeadingWidth: 0,
                    leading: _buildUserAvatar(user.profileImage),
                    title: Text(
                      user.uid == currentUser.uid
                          ? "You"
                          : "${user.firstName} ${user.lastName}",
                      style: context.textTheme.bodySmall?.w600,
                    ),
                    onTap: () {
                      if (group.senderId == currentUser.uid) {
                        confirmationDialog(
                          context: context,
                          title: "Are you sure you want to remove this member?",
                          onTapConfirm: () async {
                            Go.pop(context);
                            await ref
                                .read(chatViewModelProvider.notifier)
                                .removeMember(
                                  id: group.groupId,
                                  memberIdToRemove: user.uid,
                                );
                          },
                        );
                      }
                    },
                  ),
                  loading: () => _buildLoadingShimmer(),
                  error: (e, _) => Text(e.toString()),
                );
          },
        ),
      ],
    );
  }

  Widget _buildUserAvatar(String profileImage) {
    return profileImage.isEmpty
        ? Image.asset(Constants.defaultProfileImage, height: 50, width: 50)
        : CustomCachedNetworkImage(
            imageUrl: profileImage,
            imageBuilder: (_, image) =>
                CircleAvatar(radius: 25, backgroundImage: image),
            animChild: CircleAvatar(
              radius: 25,
              backgroundColor: context.colorScheme.surface,
            ),
          );
  }

  Widget _buildLoadingShimmer() {
    return SliderView(
      items: 10,
      scrollDirection: Axis.vertical,
      isListView: true,
      padding: const EdgeInsets.all(20),
      spacer: 10.kH,
      childBuilder: (_, __) => Shimmer.fromColors(
        baseColor: context.colorScheme.surface,
        highlightColor: context.colorScheme.onSurface,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: context.colorScheme.surface,
            ),
            15.kW,
            _buildShimmerLine(height: 15, width: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLine({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
