import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/background_executor.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/chat/model/chat_contact_model.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';

class ChatCard extends ConsumerStatefulWidget {
  final ChatContactModel contact;
  final String searchQuery;
  const ChatCard({
    super.key,
    required this.contact,
    required this.searchQuery,
  });

  @override
  ConsumerState<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends ConsumerState<ChatCard> {
  @override
  Widget build(BuildContext context) {
    final chatUserId = Helpers.chatUserId(
        widget.contact.receiverId, widget.contact.senderId, ref);
    return ref.watch(getUserByIdProvider(chatUserId)).when(
          data: (user) {
            final fullName = "${user.firstName} ${user.lastName}".toLowerCase();
            final isMatch = fullName.contains(widget.searchQuery.toLowerCase());
            if (!isMatch) {
              return const SizedBox.shrink();
            }
            return ref
                .watch(unseenMessagesCountProvider(
                    widget.contact.senderId, widget.contact.receiverId))
                .when(
                  data: (count) {
                    return ListTile(
                      minTileHeight: 60,
                      horizontalTitleGap: 10,
                      leading: user.profileImage.isEmpty
                          ? Image.asset(
                              Constants.defaultProfileImage,
                              height: 50,
                              width: 50,
                            )
                          : CustomCachedNetworkImage(
                              imageUrl: user.profileImage,
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
                        "${user.firstName} ${user.lastName}",
                        style: context.textTheme.bodySmall?.bold,
                      ),
                      subtitle: Text(
                        widget.contact.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelLarge?.themeGreyTextColor,
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Helpers.messageTime(widget.contact.timeSent),
                            style: context.textTheme.labelMedium?.w600,
                          ),
                          3.kH,
                          if (count > 0)
                            FilledBox(
                              innerBoxPadding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              color: Palette.themecolor,
                              borderRadius: BorderRadius.circular(20),
                              constraints: const BoxConstraints(
                                minHeight: 20,
                                minWidth: 20,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  count > 999 ? '999+' : count.toString(),
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.labelMedium
                                      ?.themeWhiteColor.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        Go.named(
                          context,
                          RouteName.messagePage,
                          params: {
                            "uid": chatUserId,
                            "isGroupChat": "false",
                            "name": "${user.firstName} ${user.lastName}",
                            "profilePic": "profilePic",
                          },
                        );

                        runInBackground(
                          () => ref
                              .read(chatViewModelProvider.notifier)
                              .setChatMessageSeen(
                                widget.contact.senderId,
                                widget.contact.receiverId,
                              ),
                        );
                      },
                    );
                  },
                  error: (error, st) {
                    return Text(
                      error.toString(),
                    );
                  },
                  loading: () => _buildLoadingShimmer(),
                );
          },
          error: (error, st) {
            return Text(
              error.toString(),
            );
          },
          loading: () => _buildLoadingShimmer(),
        );
  }

  Widget _buildLoadingShimmer() {
    return FilledBox(
      height: 80,
      innerBoxPadding: const EdgeInsets.only(
        top: 12,
        left: 20,
        right: 20,
        bottom: 12,
      ),
      borderRadius: BorderRadius.zero,
      width: context.screenWidth,
      color: context.colorScheme.primary,
      boxShadow: [
        BoxShadow(
          color: context.colorScheme.surface,
          blurRadius: 10,
        ),
      ],
      child: Shimmer.fromColors(
        baseColor: context.colorScheme.surface,
        highlightColor: context.colorScheme.onSurface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: context.colorScheme.surface,
            ),
            15.kW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerLine(
                    height: 15,
                    width: 150,
                  ),
                  10.kH,
                  _buildShimmerLine(
                    height: 15,
                    width: 150,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLine({
    required double height,
    required double width,
  }) {
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
