import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/confirmation_dialog.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/enums/message_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/features/chat/model/message_model.dart';
import 'package:sis/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:sis/features/chat/views/pages/edit_message_page.dart';
import 'package:sis/features/chat/views/widgets/display_text_image_gif.dart';

class MyMessageCard extends ConsumerWidget {
  final MessageModel message;
  final MessageEnum type;
  const MyMessageCard({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: FilledBox(
        onLongPressDown: type == MessageEnum.text
            ? (details) {
                final renderBox = context.findRenderObject() as RenderBox;
                final offset = renderBox.localToGlobal(Offset.zero);
                final size = renderBox.size;

                final menuTop = offset.dy + size.height;
                final menuLeft = offset.dx + size.width - 1;
                final menuRight = context.screenWidth - menuLeft;

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    menuLeft,
                    menuTop,
                    menuRight,
                    0,
                  ),
                  menuPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  items: [
                    PopupMenuItem(
                      value: '/edit-message',
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined),
                          10.kW,
                          Text(
                            "Edit",
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '/delete-message',
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.delete),
                          10.kW,
                          Text(
                            "Delete",
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).then(
                  (value) {
                    if (value == '/edit-message') {
                      if (context.mounted) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          barrierColor: themeblackcolor.withValues(alpha: 0.1),
                          backgroundColor:
                              themeblackcolor.withValues(alpha: 0.1),
                          builder: (context) {
                            return EditMessagePage(
                              message: message,
                            );
                          },
                        );
                      }
                    } else if (value == '/delete-message') {
                      if (context.mounted) {
                        confirmationDialog(
                          context: context,
                          title:
                              "Are you sure you want to delete this message?",
                          onTapConfirm: () async {
                            Go.pop(context);
                            await ref
                                .read(chatViewModelProvider.notifier)
                                .deleteMyMessage(
                                  senderId: message.senderId,
                                  receiverId: message.receiverId,
                                  messageId: message.messageId,
                                );
                          },
                        );
                      }
                    }
                  },
                );
              }
            : null,
        color: context.colorScheme.surface,
        constraints: BoxConstraints(
          maxWidth: context.screenWidth - 100,
        ),
        innerBoxPadding: EdgeInsets.symmetric(
          vertical: type == MessageEnum.text ? 8 : 3,
          horizontal: type == MessageEnum.text ? 8 : 3,
        ),
        margin: const EdgeInsets.only(right: 8),
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: type == MessageEnum.text
                  ? const EdgeInsets.only(
                      right: 70,
                      bottom: 20,
                    )
                  : message.text.isNotEmpty
                      ? const EdgeInsets.only(
                          bottom: 10,
                        )
                      : EdgeInsets.zero,
              child: DisplayTextImageGif(
                message: message.text,
                image: message.file,
                type: type,
              ),
            ),
            Positioned(
              bottom: 0,
              right: -2,
              child: Row(
                children: [
                  Text(
                    "${message.status == 2 ? "Edited " : ""}${DateFormat('hh:mm a').format(message.timeSent)}",
                    style: context.textTheme.labelMedium,
                  ),
                  5.kW,
                  Icon(
                    message.isSeen ? Icons.done_all : Icons.done,
                    size: 20,
                    color: message.isSeen
                        ? Palette.themecolor
                        : context.colorScheme.secondary.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
