import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
import 'package:sis/core/common_widgets/filled_box.dart';
import 'package:sis/core/enums/message_enum.dart';
import 'package:sis/core/extensions/screen_size_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:sis/features/chat/model/message_model.dart';
import 'package:sis/features/chat/views/widgets/display_text_image_gif.dart';

class SenderMessageCard extends ConsumerWidget {
  final MessageModel message;
  final MessageEnum type;
  const SenderMessageCard({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserByIdProvider(message.senderId)).when(
          data: (senderUser) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    senderUser.profileImage.isEmpty
                        ? Image.asset(
                            Constants.defaultProfileImage,
                            height: 36,
                            width: 36,
                          )
                        : CustomCachedNetworkImage(
                            imageUrl: senderUser.profileImage,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                radius: 18,
                                backgroundImage: imageProvider,
                              );
                            },
                            animChild: CircleAvatar(
                              backgroundColor: context.colorScheme.surface,
                              radius: 18,
                            ),
                          ),
                    FilledBox(
                      color: context.colorScheme.surface,
                      constraints: BoxConstraints(
                        maxWidth: context.screenWidth - 100,
                      ),
                      innerBoxPadding: EdgeInsets.symmetric(
                        vertical: type == MessageEnum.text ? 8 : 4,
                        horizontal: type == MessageEnum.text ? 8 : 4,
                      ),
                      margin: const EdgeInsets.only(left: 4),
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: type == MessageEnum.text
                                ? const EdgeInsets.only(
                                    right: 60,
                                    bottom: 15,
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
                          Padding(
                            padding: type == MessageEnum.text
                                ? EdgeInsets.zero
                                : const EdgeInsets.only(
                                    right: 10,
                                    bottom: 4,
                                  ),
                            child: Text(
                              "${message.status == 2 ? "Edited " : ""}${DateFormat('hh:mm a').format(message.timeSent)}",
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, st) {
            return Text(
              error.toString(),
            );
          },
          loading: () => const SizedBox.shrink(),
        );
  }
}
