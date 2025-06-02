import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/common_widgets/slider_view.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/background_executor.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/chat/model/message_model.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:sis/features/chat/views/widgets/my_message_card.dart';
import 'package:sis/features/chat/views/widgets/send_file_message_page.dart';
import 'package:sis/features/chat/views/widgets/sender_message_card.dart';

class MessagePage extends ConsumerStatefulWidget {
  final String uid;
  final String name;
  final bool isGroupChat;
  final String profilePic;
  const MessagePage({
    super.key,
    required this.uid,
    required this.name,
    required this.isGroupChat,
    required this.profilePic,
  });

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController messageScrollController = ScrollController();

  String searchQuery = '';

  bool isSeachBar = false;

  bool showFAB = false;

  @override
  void dispose() {
    _messageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (messageScrollController.hasClients) {
        messageScrollController.animateTo(
          messageScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      chatStreamProvider(widget.uid),
      (previous, next) {
        final prevIds = {
          for (final message in previous?.value ?? []) message.messageId,
        };
        final newMessages = next.value ?? [];

        for (final message in newMessages) {
          if (!prevIds.contains(message.messageId) && !message.isSeen) {
            runInBackground(
              () => ref.read(chatViewModelProvider.notifier).setChatMessageSeen(
                    message.senderId,
                    message.receiverId,
                  ),
            );
          }
        }
      },
    );

    return Scaffold(
      appBar: _buildPageHeader(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: showFAB
            ? SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  backgroundColor: Palette.themecolor,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.keyboard_double_arrow_down_outlined,
                    color: themewhitecolor,
                    size: 30,
                  ),
                  onPressed: () {
                    _scrollToBottom();
                  },
                ),
              )
            : null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: _buildPageBody(),
    );
  }

  PreferredSizeWidget _buildPageHeader() {
    return AppBar(
      title: isSeachBar
          ? CustomTextField(
              controller: _searchController,
              hintText: "Search",
              enabledBorderColor: context.colorScheme.surface,
              focusedBorderColor: Palette.themecolor,
              isOutlinedInputBorder: true,
              outlineBorderRadius: 12,
              fillColor: context.colorScheme.surface,
              filled: true,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
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
            )
          : widget.isGroupChat
              ? ListTile(
                  minTileHeight: 50,
                  horizontalTitleGap: 10,
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  leading: widget.profilePic.isEmpty
                      ? Image.asset(
                          Constants.defaultProfileImage,
                          height: 50,
                          width: 50,
                        )
                      : CustomCachedNetworkImage(
                          imageUrl: widget.profilePic,
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
                    widget.name,
                    style: context.textTheme.bodySmall?.bold,
                  ),
                  onTap: () {
                    Go.named(
                      context,
                      RouteName.groupProfilePage,
                      params: {
                        "id": widget.uid,
                      },
                    );
                  },
                )
              : ref.watch(getUserByIdProvider(widget.uid)).when(
                    data: (user) {
                      return ListTile(
                        minTileHeight: 50,
                        horizontalTitleGap: 10,
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        leading: user.profileImage.isEmpty
                            ? Image.asset(
                                Constants.defaultProfileImage,
                                height: 40,
                                width: 40,
                              )
                            : CustomCachedNetworkImage(
                                imageUrl: user.profileImage,
                                imageBuilder: (context, imageProvider) {
                                  return CircleAvatar(
                                    radius: 20,
                                    backgroundImage: imageProvider,
                                  );
                                },
                                animChild: CircleAvatar(
                                  backgroundColor: context.colorScheme.surface,
                                  radius: 20,
                                ),
                              ),
                        title: Text(
                          "${user.firstName} ${user.lastName}",
                          style: context.textTheme.bodySmall?.bold,
                        ),
                      );
                    },
                    error: (error, st) {
                      return Text(
                        error.toString(),
                      );
                    },
                    loading: () => Container(),
                  ),
      actions: [
        CustomIconButton(
          onTap: () {
            setState(() {
              isSeachBar = !isSeachBar;
            });
          },
          child: Icon(
            isSeachBar ? Icons.close : Icons.search,
          ),
        ),
        15.kW,
      ],
    );
  }

  Widget _buildPageBody() {
    final user = ref.watch(currentUserNotifierProvider)!;
    final messageProvider = widget.isGroupChat
        ? groupChatStreamProvider(widget.uid)
        : chatStreamProvider(widget.uid);
    return Stack(
      children: [
        ref.watch(messageProvider).when(
              data: (messages) {
                final filteredMessages = _filterMessages(messages);

                _scrollToBottom();

                return SliderView(
                  controller: messageScrollController,
                  scrollDirection: Axis.vertical,
                  isListView: true,
                  spacer: 10.kH,
                  items: filteredMessages.length,
                  padding: const EdgeInsets.only(top: 10, bottom: 100),
                  childBuilder: (context, index) {
                    final message = filteredMessages[index];
                    final isMyMessage = message.senderId == user.uid;

                    return isMyMessage
                        ? MyMessageCard(
                            message: message,
                            type: message.type,
                          )
                        : SenderMessageCard(
                            message: message,
                            type: message.type,
                          );
                  },
                );
              },
              error: (error, _) => Text(error.toString()),
              loading: () => const LoadingProgress(),
            ),
        _buildPageFooter(),
      ],
    );
  }

  List<MessageModel> _filterMessages(List<MessageModel> messages) {
    return messages.where((message) {
      return message.text.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildPageFooter() {
    final user = ref.watch(getUserByIdProvider(widget.uid)).value;
    final receiverTokens = user?.deviceTokens ?? [];
    return Align(
      alignment: Alignment.bottomCenter,
      child: FilledBox(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.zero,
        innerBoxPadding: const EdgeInsets.all(12),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.surface,
            blurRadius: 5,
          ),
        ],
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _messageController,
                maxLines: null,
                hintText: "Type Message",
                enabledBorderColor: context.colorScheme.surface,
                focusedBorderColor: Palette.themecolor,
                isOutlinedInputBorder: true,
                outlineBorderRadius: 12,
                fillColor: context.colorScheme.surface,
                filled: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                prefix: CustomIconButton(
                  onTap: () {
                    Go.route(
                      context,
                      SendFileMessagePage(
                        id: widget.uid,
                        isGroupChat: widget.isGroupChat,
                        receiverDeviceTokens: receiverTokens,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.attach_file,
                    size: 25,
                  ),
                ),
              ),
            ),
            10.kW,
            CustomIconButton(
              onTap: () async {
                if (_messageController.text.isNotEmpty) {
                  await ref
                      .read(chatViewModelProvider.notifier)
                      .sendTextMessage(
                        receiverId: widget.uid,
                        text: _messageController.text,
                        isGroupChat: widget.isGroupChat,
                        deviceTokens: receiverTokens,
                      );
                  _messageController.clear();
                } else {
                  showToast(
                    content: "Please type message first!",
                    context: context,
                    toastType: ToastType.error,
                  );
                }
              },
              child: const CircleAvatar(
                backgroundColor: Palette.themecolor,
                child: Icon(
                  Icons.send_rounded,
                  color: themewhitecolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
