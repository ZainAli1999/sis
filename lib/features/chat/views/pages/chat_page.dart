import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:sis/features/chat/views/widgets/chat_card.dart';
import 'package:sis/features/chat/views/widgets/group_card.dart';
import 'package:sis/features/chat/views/widgets/new_group_dialog.dart';
import 'package:sis/features/chat/views/widgets/users_dialog.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const UsersDialog(),
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
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: const Text("Chat"),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
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
            prefix: const Icon(
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
      actions: [
        PopupMenuButton(
          padding: EdgeInsets.zero,
          menuPadding: EdgeInsets.zero,
          onSelected: (value) {
            if (value == '/new-group') {
              showDialog(
                context: context,
                builder: (context) => const NewGroupDialog(),
              );
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: '/new-group',
                child: Text(
                  "New Group",
                  style: context.textTheme.labelLarge,
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget _buildPageBody() {
    final chatGroupsAsync = ref.watch(chatGroupsProvider);
    final chatContactsAsync = ref.watch(chatContactsProvider);
    final hasChatGroups = chatGroupsAsync.value?.isNotEmpty ?? false;
    return SingleChildScrollView(
      child: Column(
        children: [
          chatGroupsAsync.when(
            data: (groups) {
              final query = searchQuery.toLowerCase();
              final filteredGroups = groups.where((group) {
                return group.name.toLowerCase().contains(query);
              }).toList();
              return SliderView(
                scrollDirection: Axis.vertical,
                isListView: true,
                spacer: 10.kH,
                padding: EdgeInsets.zero,
                items: filteredGroups.length,
                childBuilder: (context, index) {
                  final group = filteredGroups[index];
                  return GroupCard(
                    group: group,
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
          ),
          if (hasChatGroups) 10.kH,
          chatContactsAsync.when(
            data: (contacts) {
              return SliderView(
                scrollDirection: Axis.vertical,
                isListView: true,
                spacer: 10.kH,
                padding: EdgeInsets.zero,
                items: contacts.length,
                childBuilder: (context, index) {
                  final contact = contacts[index];
                  return FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: ChatCard(
                      contact: contact,
                      searchQuery: searchQuery,
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
            loading: () => const SizedBox(),
          ),
        ],
      ),
    );
  }

  // Widget _buildNoChatsView() {
  //   return SizedBox(
  //     height: context.screenHeight / 100 * 60,
  //     child: Center(
  //         child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Center(
  //           child: CircleAvatar(
  //             backgroundColor: context.colorScheme.surface,
  //             radius: 80,
  //             child: const Icon(
  //               CupertinoIcons.bubble_left,
  //               size: 100,
  //               color: Palette.themecolor,
  //             ),
  //           ),
  //         ),
  //         20.kH,
  //         Center(
  //           child: Text(
  //             "No Chats Found",
  //             style: context.textTheme.bodyMedium?.bold,
  //           ),
  //         ),
  //       ],
  //     )),
  //   );
  // }

  Widget _buildLoadingShimmer() {
    return SliderView(
      items: 10,
      scrollDirection: Axis.vertical,
      isListView: true,
      spacer: 10.kH,
      childBuilder: (context, index) {
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
            baseColor: context.colorScheme.surfaceDim,
            highlightColor: context.colorScheme.shadow,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: context.colorScheme.surface,
                ),
                15.kW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildShimmerLine(
                        height: 15,
                        width: 150,
                      ),
                      8.kH,
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
      },
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
